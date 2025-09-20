import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/service/socket_service.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

import 'controller/chat_controller.dart';
import 'model/chat_model.dart';
import 'widgets/chat_message_card_item_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.senderId});

  final String senderId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final pagingController = PagingController<int, MessageItem>(firstPageKey: 1);
  final scrollController = ScrollController();
  final messageController = TextEditingController();
  final controller = GetControllers.instance.getChatController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      controller.getChatList(pageKey: pageKey, id: widget.senderId, pagingController: pagingController);
    });
    _initializeSocketAndController();
  }

  Future<void> _initializeSocketAndController() async {
    try {
      debugPrint("Socket 1");
      await SocketApi.init();
      debugPrint("Socket 2");
      controller.listenForNewMessages(senderId: widget.senderId, pagingController: pagingController);
      debugPrint("Socket 3");
    } catch (e) {
      debugPrint("Socket Error Chat Screen Try Catch $e");
    }
  }

  @override
  void dispose() {
    Get.delete<ChatController>();
    pagingController.dispose();
    scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MessageListCard(controller: controller, scrollController: scrollController, pagingController: pagingController,),
              ChatInputBox(controller: controller,
                formKey: _formKey,
                widget: widget,
                messageController: messageController,
                senderId: '',),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatInputBox extends StatelessWidget {
  const ChatInputBox({
    super.key,
    required this.controller,
    required GlobalKey<FormState> formKey,
    required this.widget,
    required this.messageController, required this.senderId,
  }) : _formKey = formKey;

  final ChatController controller;
  final TextEditingController messageController;
  final GlobalKey<FormState> _formKey;
  final ChatScreen widget;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    print("1111111 -> Input- Build");
    return Container(
      padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12, top: 5),
      width: double.infinity,
      child: Column(
        children: [
          Obx(() {
            print("1111111 -> Input- Obx");
            return controller.selectedImages.isNotEmpty ? Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Wrap(
                spacing: 10,
                children: List.generate(controller.selectedImages.length, (index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          File(controller.selectedImages[index].path),
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(color: AppColors.whiteColor.withValues(alpha: 0.6), shape: BoxShape.circle),
                            child: const Icon(
                              Iconsax.trash,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ) : SizedBox();
          }),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.pickCameraImage();
                  },
                  icon: const Icon(Iconsax.camera),
                ),
                IconButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  icon: const Icon(Iconsax.gallery),
                ),
                Expanded(
                  child: TextFormField(

                    controller: messageController,
                    maxLines: 5,
                    minLines: 1,
                    maxLength: 500,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Please Write a message...";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Aa",
                      hintStyle: const TextStyle(color: Colors.black),
                      counterText: "",
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return IconButton(
                    onPressed: controller.callMessageSend.value
                        ? null
                        : () {
                      if (controller.selectedImages.isNotEmpty) {
                        controller.sendMessage(
                          senderId: widget.senderId,
                          context: context,
                          messageController: messageController,
                        );
                      } else {
                        if (_formKey.currentState!.validate()) {
                          controller.sendMessage(
                            senderId: widget.senderId,
                            context: context,
                            messageController: messageController,
                          );
                        }
                      }
                    },
                    icon: controller.callMessageSend.value
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Icon(Iconsax.send1, size: 24),
                  );
                })

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageListCard extends StatelessWidget {
  const MessageListCard({
    super.key,
    required this.controller,
    required this.pagingController,
    required this.scrollController,
  });

  final ChatController controller;
  final PagingController<int, MessageItem> pagingController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: PagedListView<int, MessageItem>(
          pagingController: pagingController,
          scrollController: scrollController,
          reverse: true,
          builderDelegate: PagedChildBuilderDelegate<MessageItem>(
            itemBuilder: (context, message, index) {
              print("MY USER ID: $index ${controller.userId.value} / ${message.sender}");

              final String? image = controller.chatModel.value.participant?.profilePic;
              final String? name = controller.chatModel.value.participant?.name;

              return ChatBubble(
                message: message,
                name: name,
                image: image,
                isSentByMe: (controller.userId.value == message.sender),
              );
            },
            firstPageProgressIndicatorBuilder: (_) =>
            const Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 60.0,
                )),
            newPageProgressIndicatorBuilder: (_) =>
            const Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 60.0,
                )),
            noItemsFoundIndicatorBuilder: (_) => Center(child: Text("No conversation found!"),),
          ),
        ),
      ),
    );
  }
}


/*class ChatScreen extends StatefulWidget {
  final String id;
  static const String routeName = '/chatting';

  const ChatScreen({super.key, required this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = GetControllers.instance.getChatController();

  @override
  void initState() {
    chatController.pagingController.addPageRequestListener((int index){
      chatController.getMessageForChat(pageKey: index, id: widget.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ChatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: CustomScrollView(

        slivers: [
          CustomDefaultAppbar(title: "Chat",),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final message = messageController.messages[index];
                final isDriverMessage = message.isFromDriver;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ChatMessageCardItemWidget(
                    isDriverMessage: isDriverMessage,
                    message: message,
                  ),
                );
              },
              childCount: messageController.messages.length,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // This pushes content to bottom
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.image, color: AppColors.purple500),
                      ),
                      Expanded(
                        child: CustomTextField(
                          hintText: "Type here",
                          fillColor: Colors.white,
                          fieldBorderColor: AppColors.purple500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send, color: AppColors.purple500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}*/
