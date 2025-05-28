import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/chat/chat_message_model/chat_message_model.dart';


class MessageController extends GetxController{
  final messages = <ChatMessage>[].obs;



  var tabContent = <Widget>[].obs;
  @override
  void onInit() {
    super.onInit();
    // Add static message examples
    messages.addAll([
      ChatMessage(
        content: "Hello! I'm available to pick you up. I'll be there in about",
        time: "02:15 PM",
        isFromDriver: true,
      ),
      ChatMessage(
        content: "Thankyou Sir"*10,
        time: "02:20 PM",
        isFromDriver: false,
      ),
      ChatMessage(
        content: "I've arrived at Location. Look for a Red Car with the license plate XXXX.",
        time: "02:35 PM",
        isFromDriver: true,
      ),
      ChatMessage(
        content: "Great! I'll be there in a minute.",
        time: "02:36 PM",
        isFromDriver: false,
      ),

    ]);
  }
}