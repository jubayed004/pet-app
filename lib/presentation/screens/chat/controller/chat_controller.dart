// ============================================
// 1. UPDATED CHAT CONTROLLER
// ============================================

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/chat/model/chat_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/service/socket_service.dart';
import 'package:pet_app/utils/popup_loader/popup_loader.dart';

class ChatController extends GetxController {
  final ApiClient apiClient = serviceLocator<ApiClient>();
  final DBHelper dbHelper = serviceLocator<DBHelper>();

  final Rx<ChatModel> chatModel = ChatModel().obs;
  final RxBool isBlocked = false.obs;
  final RxBool isBlockedByOther = false.obs;
  final RxBool isBlockLoading = false.obs;

  bool isLoading = false;

  Future<void> getChatList({
    required int pageKey,
    required String id,
    required PagingController<int, MessageItem> pagingController,
  }) async {
    if (isLoading) return;
    isLoading = true;
    try {
      final response = await apiClient.get(url: ApiUrl.getMessageForChat(pageKey: pageKey, id: id));
      if (response.statusCode == 200) {
        final newData = ChatModel.fromJson(response.body);
        if (pageKey == 1) {
          chatModel.value = newData;
          // Check block status from chat model if available
         /* checkBlockStatus(id);*/
        }
        final newItems = newData.conversation?.messages ?? [];
        if (newItems.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error = 'An error occurred';
      }
    } catch (e) {
      debugPrint("Error in getChatList: $e");
      pagingController.error = 'An error occurred';
    } finally {
      isLoading = false;
    }
  }
/*
  // Check if user is blocked
  Future<void> checkBlockStatus(String userId) async {
    try {
      final response = await apiClient.get(url: ApiUrl.checkBlockStatus(userId: userId));
      if (response.statusCode == 200) {
        isBlocked.value = response.body['isBlocked'] ?? false;
        isBlockedByOther.value = response.body['isBlockedByOther'] ?? false;
      }
    } catch (e) {
      debugPrint("Error checking block status: $e");
    }
  }*/

/*  // Block user
  Future<void> blockUser(String userId, BuildContext context) async {
    try {
      isBlockLoading.value = true;

      final response = await apiClient.post(
        url: ApiUrl.blockUser(),
        body: {"userId": userId},
      );

      if (response.statusCode == 200) {
        isBlocked.value = true;
        toastMessage(message: "User blocked successfully");
        Navigator.of(context).pop(); // Close bottom sheet
      } else {
        toastMessage(message: response.body['message'] ?? "Failed to block user");
      }
    } catch (e) {
      debugPrint("Error blocking user: $e");
      toastMessage(message: "Failed to block user");
    } finally {
      isBlockLoading.value = false;
    }
  }*/

/*  // Unblock user
  Future<void> unblockUser(String userId, BuildContext context) async {
    try {
      isBlockLoading.value = true;

      final response = await apiClient.post(
        url: ApiUrl.unblockUser(),
        body: {"userId": userId},
      );

      if (response.statusCode == 200) {
        isBlocked.value = false;
        toastMessage(message: "User unblocked successfully");
        Navigator.of(context).pop(); // Close bottom sheet
      } else {
        toastMessage(message: response.body['message'] ?? "Failed to unblock user");
      }
    } catch (e) {
      debugPrint("Error unblocking user: $e");
      toastMessage(message: "Failed to unblock user");
    } finally {
      isBlockLoading.value = false;
    }
  }*/



  var callMessageSend = false.obs;

  Future<void> sendMessage({
    required String senderId,
    required BuildContext context,
    required TextEditingController messageController,
  }) async {
    try {
      // Check if blocked before sending
      if (isBlocked.value) {
        toastMessage(message: "You have blocked this user. Unblock to send messages.");
        return;
      }

      if (isBlockedByOther.value) {
        toastMessage(message: "You cannot send messages to this user.");
        return;
      }

      if (callMessageSend.value) return;
      callMessageSend.value = true;

      debugPrint("Is Socket Connected: ${SocketApi.socket!.connected}");
      showPopUpLoader(context: context);

      final UploadImage imageUploadResponse = await uploadImages();

      debugPrint("Images: ${imageUploadResponse.images?.length} / ${imageUploadResponse.images.toString()}");

      if (SocketApi.socket != null && SocketApi.socket!.connected) {
        final body = {
          "senderId": userId.value,
          "receiverId": senderId,
          "text": messageController.text,
          "images": imageUploadResponse.images ?? [],
          "video": "",
          "videoCover": ""
        };

        SocketApi.socket?.emit('new-message', body);
        debugPrint(body.toString());

        messageController.clear();
        AppRouter.route.pop();
        selectedImages.clear();
        callMessageSend.value = false;

        SocketApi.socket?.onAny((event, data) {
          debugPrint("📡 Event: $event -> $data");
        });
      } else {
        debugPrint("Socket Null Or Socket Not Connected Send Message");
        AppRouter.route.pop();
        callMessageSend.value = false;
        SocketApi.reconnect();
      }
    } catch (e) {
      callMessageSend.value = false;
      if (Navigator.canPop(context)) {
        AppRouter.route.pop();
      }
      debugPrint("Socket Error Send Message Controller Try Catch Error $e");
    }
  }

  void listenForNewMessages({
    required String senderId,
    required PagingController<int, MessageItem> pagingController,
  }) {
    try {
      debugPrint("Setting up message listener");
      SocketApi.socket?.off('new-message/$senderId');

      SocketApi.socket?.on('new-message/$senderId', (data) {
        debugPrint("New message received: $data");
        final newMessage = MessageItem.fromJson(data);
        final currentMessages = pagingController.itemList ?? [];
        if (!currentMessages.any((msg) => msg.conversationId == newMessage.id)) {
          pagingController.itemList = [newMessage, ...currentMessages];
        }
      });
    } catch (e) {
      debugPrint("Socket Error New Message Controller Try Catch Error $e");
    }
  }

  final ImagePicker _picker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs;

  Future<void> pickImage() async {
    selectedImages.clear();
    List<XFile> images = await _picker.pickMultiImage(imageQuality: 50, limit: 6);
    if (images.isNotEmpty) {
      selectedImages.addAll(images);
    }
  }

  Future<void> pickCameraImage() async {
    selectedImages.clear();
    XFile? image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      selectedImages.add(image);
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  Future<UploadImage> uploadImages() async {
    try {
      if (selectedImages.isNotEmpty) {
        List<MultipartBody> multipartBody = selectedImages.map((item) {
          return MultipartBody("chatImage", File(item.path));
        }).toList();

        final response = await apiClient.multipartRequest(
          url: ApiUrl.updateFile(),
          reqType: "POST",
          body: {},
          multipartBody: multipartBody,
        );

        if (response.statusCode == 200) {
          final responseData = UploadImage.fromJson(response.body);
          return responseData;
        } else {
          return UploadImage();
        }
      } else {
        return UploadImage();
      }
    } catch (e) {
      debugPrint("Error uploading images: $e");
      return UploadImage();
    }
  }

  RxString userId = "".obs;

  void getUserId() async {
    try {
      userId.value = await dbHelper.getUserId();
    } catch (e) {
      debugPrint("Error getting user ID: $e");
    }
  }

  @override
  void onReady() {
    getUserId();
    super.onReady();
  }

  @override
  void onClose() {
    selectedImages.clear();
    super.onClose();
  }
}

class UploadImage {
  final bool? success;
  final List<String>? images;
  final dynamic video;
  final dynamic cover;

  UploadImage({
    this.success,
    this.images,
    this.video,
    this.cover,
  });

  factory UploadImage.fromJson(Map<String, dynamic> json) => UploadImage(
    success: json["success"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    video: json["video"],
    cover: json["cover"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "video": video,
    "cover": cover,
  };
}

// ============================================
// 2. API URL EXTENSIONS (Add to ApiUrl class)
// ============================================

extension ChatBlockingUrls on ApiUrl {
  static String checkBlockStatus({required String userId}) => "/chat/block-status/$userId";
  static String blockUser() => "/chat/block";
  static String unblockUser() => "/chat/unblock";
  static String reportUser() => "/chat/report";
}