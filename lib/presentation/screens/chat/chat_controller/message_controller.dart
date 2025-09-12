import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/screens/chat/chat_message_model/chat_message_model.dart';
import 'package:pet_app/presentation/screens/chat/chat_message_model/message_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/service/socket_service.dart';
import 'package:pet_app/utils/popup_loader/popup_loader.dart';


class MessageController extends GetxController{
  final messages = <ChatMessage>[].obs;
  var tabContent = <Widget>[].obs;
  final ApiClient apiClient = serviceLocator();

  final PagingController<int, Conversation> pagingController = PagingController(firstPageKey: 1);

  bool isRunning = false;

  Future<void> getAllMessage({required int pageKey}) async {
    if(isRunning)return;
    isRunning = true;
    try{
      final response = await apiClient.get(url: ApiUrl.getMessage(pageKey: pageKey));
      if (response.statusCode == 200) {
        final newData = MessageModel.fromJson(response.body);
        final newItems = newData.conversations ?? [];
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
      isRunning = false;
    }
  }

  void listenForNewConversation() {
    try{
      SocketApi.socket?.on('new_notification', (data) {
        debugPrint(data.toString());
        // final newMessage = Conversation.fromJson(data);
        // final currentMessages = pagingController.itemList ?? [];
        //
        // if (!currentMessages.any((msg) => msg.roomId == newMessage.roomId)) {
        //   final updatedList = [newMessage, ...currentMessages];
        //   pagingController.itemList = List<Conversation>.from(updatedList);
        // }
      });
    }catch(e){
      debugPrint("Socket Error New Message Controller Try Catch Error $e");
    }
  }


  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getAllMessage(pageKey: pageKey);
    });
    listenApi();
  }

  Future<void> listenApi() async {
    await SocketApi.init();
    listenForNewConversation();
  }

/*
  // Listen for new messages
  void listenForNewMessages({required String senderId}) {
    try{
      if (kDebugMode) {
        print("message-$senderId");
      }
      SocketApi.socket?.on('message-$senderId', (data) {
        final newMessage = Message.fromJson(data);
        final currentMessages = pagingController.itemList ?? [];
        if (!currentMessages.any((msg) => msg.id == newMessage.id)) {
          pagingController.itemList = [newMessage, ...currentMessages];
        }
      });
    }catch(e){
      debugPrint("Socket Error New Message Controller Try Catch Error $e");
    }
  }

  void seenMessage({required String senderId}) {
    try{
      print("Is Socket Connected: ${SocketApi.socket!.connected}");
      if (SocketApi.socket != null && SocketApi.socket!.connected) {
        final body = {
          "conversationId": model.value.data?.result?.conversationId,
          "msgByUserId": senderId,
        };
        SocketApi.socket?.emit('seen', body);
      } else {
        debugPrint("Socket Null Or Socket Not Connected Seen Message");
        SocketApi.reconnect();
      }
    }catch(e){
      debugPrint("Socket Error Seen Message Controller Try Catch Error $e");
    }
  }
}
*/

/*  ApiClient apiClient = ApiClient();
  DBHelper dbHelper = DBHelper();
  RxBool isLoadingMove = false.obs;
  Rx<ChatMessage> model = ChatMessage().obs;
  RxString userId = "".obs;
  final TextEditingController messageController = TextEditingController();
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

  Future<ImageUploadResponse> uploadImages() async {
    try {
      if(selectedImages.isNotEmpty){
        List<MultipartBody> multipartBody = selectedImages.map((item) {
          return MultipartBody("chat_images", File(item.path));
        }).toList();

        final response = await apiClient.multipartRequest(
          url: ApiUrl.updateFile(),
          reqType: "POST",
          body: {},
          multipartBody: multipartBody,
        );

        if(response.statusCode == 201){
          final responseData = ImageUploadResponse.fromJson(response.body);
          return responseData;
        }else{
          return ImageUploadResponse();
        }
      }else{
        return ImageUploadResponse();
      }
    } catch (e) {
      return ImageUploadResponse();
    }
  }

  final PagingController<int, Message> pagingController = PagingController(firstPageKey: 1);

  // Fetch paginated chat history
  Future<void> getAllChat({required int page, required String id}) async {
    if (isLoadingMove.value) return;
    isLoadingMove.value = true;

    try {
      userId.value = await dbHelper.getUserId();
      final response = await apiClient.get(url: ApiUrl.getAllMessage(id: id, page: page));

      if (response.statusCode == 201) {
        model.value = MessageModel.fromJson(response.body);
        final newItems = model.value.data?.result?.messages ?? [];

        if (newItems.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, page + 1);
        }

        if(SocketApi.socket != null && SocketApi.socket!.connected){
          seenMessage(senderId: id);
        }
      } else {
        pagingController.error = 'Error fetching data';
      }
    } catch (e) {
      pagingController.error = 'An error occurred';
    } finally {
      isLoadingMove.value = false;
    }
  }

  RxBool callMessageSend = false.obs;

  Future<void> sendMessage({required String senderId, required BuildContext context}) async {
    try{
      if (callMessageSend.value) return;
      callMessageSend.value = true;

      print("Is Socket Connected: ${SocketApi.socket!.connected}");
      showPopUpLoader(context: context);

      final ImageUploadResponse imageUploadResponse = await uploadImages();
      if (SocketApi.socket != null && SocketApi.socket!.connected) {

        print(imageUploadResponse.data?.images?.length);
        final body = {
          "sender": userId.value,
          "receiver": senderId,
          "text": messageController.text,
          "msgByUserId": userId.value,
          "imageUrl": imageUploadResponse.data?.images,
        };
        print(body.toString());
        SocketApi.socket?.emit('new-message', body);
        print(body.toString());
        messageController.clear();
        AppRouter.route.pop();
        selectedImages.clear();
        callMessageSend.value = false;
      } else {
        debugPrint("Socket Null Or Socket Not Connected Send Message");
        AppRouter.route.pop();
        callMessageSend.value = false;
        SocketApi.reconnect();
      }
    }catch(e){
      callMessageSend.value = false;
      AppRouter.route.pop();
      debugPrint("Socket Error Send Message Controller Try Catch Error $e");
    }
  }

  // Listen for new messages
  void listenForNewMessages({required String senderId}) {
    try{
      print("message-${senderId}");
      SocketApi.socket?.on('message-${senderId}', (data) {
        final newMessage = Message.fromJson(data);
        final currentMessages = pagingController.itemList ?? [];
        if (!currentMessages.any((msg) => msg.id == newMessage.id)) {
          pagingController.itemList = [newMessage, ...currentMessages];
        }
      });
    }catch(e){
      debugPrint("Socket Error New Message Controller Try Catch Error $e");
    }
  }

  void seenMessage({required String senderId}) {
    try{
      print("Is Socket Connected: ${SocketApi.socket!.connected}");
      if (SocketApi.socket != null && SocketApi.socket!.connected) {
        final body = {
          "conversationId": model.value.data?.result?.conversationId,
          "msgByUserId": senderId,
        };
        SocketApi.socket?.emit('seen', body);
      } else {
        debugPrint("Socket Null Or Socket Not Connected Seen Message");
        SocketApi.reconnect();
      }
    }catch(e){
      debugPrint("Socket Error Seen Message Controller Try Catch Error $e");
    }
  }
}

class ImageUploadResponse {
  final bool? success;
  final String? message;
  final Data? data;

  ImageUploadResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) => ImageUploadResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final List<String>? images;
  final List<String>? videos;

  Data({
    this.images,
    this.videos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
  };*/
}