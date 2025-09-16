import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/chat/chat_message_model/chat_message_model.dart';
import 'package:pet_app/presentation/screens/chat/chat_message_model/message_model.dart' hide MessageItem;
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class ChatController extends GetxController{
  final ApiClient apiClient = serviceLocator<ApiClient>();
  final PagingController<int, MessageItems> pagingController = PagingController(firstPageKey: 1);

  bool isLoading= false;

  Future<void> getMessageForChat({required int pageKey,required String id}) async {
    if(isLoading)return;
    isLoading = true;
    try{
      final response = await apiClient.get(url: ApiUrl.getMessageForChat(pageKey: pageKey, id: id));
      if (response.statusCode == 200) {
        final newData = MessageForChatModel.fromJson(response.body);
        final newItems = newData.conversation?.messages ?? [];
        if (newItems.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error = 'An error occurred';
      }
    }catch(_){
      pagingController.error = 'An error occurred';
    }finally{
      isLoading = false;
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
