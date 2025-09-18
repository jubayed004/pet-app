import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/screens/chat/model/chat_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/service/socket_service.dart';
import 'package:pet_app/utils/popup_loader/popup_loader.dart';

class ChatController extends GetxController{
  final ApiClient apiClient = serviceLocator<ApiClient>();
  final DBHelper dbHelper = serviceLocator<DBHelper>();

  final Rx<ChatModel> chatModel = ChatModel().obs;

  bool isLoading= false;
  Future<void> getChatList({required int pageKey,required String id, required PagingController<int, MessageItem> pagingController,}) async {
    if(isLoading)return;
    isLoading = true;
    try{
      final response = await apiClient.get(url: ApiUrl.getMessageForChat(pageKey: pageKey, id: id));
      if (response.statusCode == 200) {
        final newData = ChatModel.fromJson(response.body);
        if(pageKey == 1){
          chatModel.value = newData;
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
    }catch(_){
      pagingController.error = 'An error occurred';
    }finally{
      isLoading = false;
    }
  }


  bool callMessageSend = false;

  Future<void> sendMessage({required String senderId, required BuildContext context, required TextEditingController messageController}) async {
    try{
      if (callMessageSend) return;
      callMessageSend = true;

      print("Is Socket Connected: ${SocketApi.socket!.connected}");
      showPopUpLoader(context: context);

      // final ImageUploadResponse imageUploadResponse = await uploadImages();
      if (SocketApi.socket != null && SocketApi.socket!.connected) {
        final body = {
          "senderId": userId.value,
          "receiverId": senderId,
          "text": messageController.text,
          "images": [],
          "video": "",
          "videoCover": ""
        };

        SocketApi.socket?.emit('new-message', body);
        print(body.toString());
        messageController.clear();
        AppRouter.route.pop();
        selectedImages.clear();
        callMessageSend = false;

        SocketApi.socket?.onAny((event, data) {
          debugPrint("📡 Event: $event -> $data");
        });
      } else {
        debugPrint("Socket Null Or Socket Not Connected Send Message");
        AppRouter.route.pop();
        callMessageSend = false;
        SocketApi.reconnect();
      }
    }catch(e){
      callMessageSend = false;
      AppRouter.route.pop();
      debugPrint("Socket Error Send Message Controller Try Catch Error $e");
    }
  }



  void listenForNewMessages({required String senderId, required PagingController<int, MessageItem> pagingController,}) {
    try{
      debugPrint("Socket 4");
      SocketApi.socket?.off('new-message/$senderId');
      debugPrint("Socket 5");
      print("Message ..................................");
      SocketApi.socket?.on('new-message/$senderId', (data) {
        print("Message $data");
        final newMessage = MessageItem.fromJson(data);
        final currentMessages = pagingController.itemList ?? [];
        if (!currentMessages.any((msg) => msg.conversationId == newMessage.id)) {
          pagingController.itemList = [newMessage, ...currentMessages];
        }
      });
    }catch(e){
      print("Message..................................");
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

/*  Future<ChatItem> uploadImages() async {
    try {
      if(selectedImages.isNotEmpty){
        List<MultipartBody> multipartBody = selectedImages.map((item) {
          return MultipartBody("images", File(item.path));
        }).toList();

        final response = await apiClient.multipartRequest(
          url: ApiUrl.updateFile(),
          reqType: "POST",
          body: {},
          multipartBody: multipartBody,
        );

        if(response.statusCode == 201){
          final responseData = ChatItem.fromJson(response.body);
          return responseData;
        }else{
          return ChatItem();
        }
      }else{
        return ChatItem();
      }
    } catch (e) {
      return ChatItem();
    }
  }*/

  RxString userId = "".obs;
  void getUserId() async{
    try{
      userId.value = await dbHelper.getUserId();
    }catch(_){}
  }

  @override
  void onReady() {
    getUserId();
    super.onReady();
  }
}
