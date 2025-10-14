import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/screens/inbox/model/conversation_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/service/socket_service.dart';

class MessageController extends GetxController {
  final ApiClient apiClient = serviceLocator<ApiClient>();

  bool isRunning = false;

  Future<void> getAllConversation({required int pageKey, required PagingController<int, ConversationItem> pagingController}) async {
    final response = await apiClient.get(url: ApiUrl.getConversation(pageKey: pageKey));
    if (response.statusCode == 200) {
      final newData = ConversationModel.fromJson(response.body);
      final newItems = newData.data ?? [];
      if (newItems.isEmpty) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } else {
      pagingController.error = 'An error occurred';
    }
  }

  void listenForNewConversation({required PagingController<int, ConversationItem> pagingController}) async {
    try {
      final userId = await DBHelper().getUserId();
      SocketApi.socket?.off('conversation_update/$userId');
      SocketApi.socket?.on('conversation_update/$userId', (data) {
        debugPrint("Conversation Received: ${data.toString()}");

        if (data['messageType'] == 'TEXT') {
          final updatedMessage = ConversationItem.fromJson(data);
          final currentMessages = pagingController.itemList ?? [];

          int existingIndex = currentMessages.indexWhere((msg) => msg.conversationId == updatedMessage.conversationId);

          if (existingIndex != -1) {
            if (existingIndex == 0) {
              currentMessages[0] = updatedMessage;
            } else {
              currentMessages.removeAt(existingIndex);
              currentMessages.insert(0, updatedMessage);
            }
          } else {
            currentMessages.insert(0, updatedMessage);
          }

          pagingController.itemList = [...currentMessages];
          debugPrint("Updated conversation list: ${pagingController.itemList?.length}");
        } else {
          debugPrint("Ignored non-text message");
        }
      });
    } catch (e) {
      debugPrint("Socket Error Inbox Controller Try Catch $e");
    }
  }

}
