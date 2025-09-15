import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/service/socket_service.dart';
import '../widgets/chat_message_card_item_widget.dart';

/*class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.id, required this.type});

  final String id;
  final String type;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController scrollController = ScrollController();
 *//* final controller = Get.put(SocketChatController());*//*
  final messageController = GetControllers.instance.getChatController();
  @override
  void initState() {
    super.initState();
    _initializeSocketAndController();
  }

  Future<void> _initializeSocketAndController() async {
    try {
      messageController.pagingController.addPageRequestListener((pageKey) {
        messageController.getMessageForChat(pageKey: pageKey, id: widget.id,);
      });
      await SocketApi.init();
      messageController.listenForNewMessages(projectId: widget.id, groupName: widget.type);
*//*      if (controller.model.value.data?.result?.conversationId != null && controller.model.value.data!.result!.conversationId!.isNotEmpty) {
        controller.seenMessage(senderId: widget.id);
      }*//*
    } catch (e) {
      debugPrint("Socket Error Chat Screen Try Catch $e");
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Get.delete<SocketChatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    print("1111111 Build Context ${widget.type}");
    return Scaffold(
      appBar: AppBar(
        title: Text("inbox".tr),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MessageListCard(controller: controller, scrollController: scrollController),
              ChatInputBox(controller: controller, formKey: _formKey, widget: widget),
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
  }) : _formKey = formKey;

  final SocketChatController controller;
  final GlobalKey<FormState> _formKey;
  final ChatScreen widget;

  @override
  Widget build(BuildContext context) {
    print("1111111 -> Input- Build");
    return Container(
      padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12, top: 5),
      width: double.infinity,
      child: Column(
        children: [
          Obx((){
            print("1111111 -> Input- Obx");
            return controller.selectedImages.isNotEmpty?Padding(
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
                          width: 100,
                          height: 100,
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
            ):SizedBox();
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
                *//*IconButton(
                    onPressed: () {
                      controller.pickCameraImage();
                    },
                    icon: const Icon(Iconsax.camera),
                ),*//*
                *//*IconButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    icon: const Icon(Iconsax.gallery),
                ),*//*
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
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
                IconButton(
                  onPressed: () {
                    if(controller.selectedImages.isNotEmpty){
                      controller.sendMessage(projectId: widget.id, context: context, type: widget.type);
                    }else{
                      if (_formKey.currentState!.validate()) {
                        controller.sendMessage(projectId: widget.id, context: context, type: widget.type);
                      }
                    }
                  },
                  icon: const Icon(Iconsax.send1, size: 24,),
                ),
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
    required this.scrollController,
  });

  final SocketChatController controller;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: PagedListView<int, Message>(
          pagingController: controller.pagingController,
          scrollController: scrollController,
          reverse: true,
          builderDelegate: PagedChildBuilderDelegate<Message>(
            itemBuilder: (context, message, index) {
              print("MY USER ID: ${controller.userId.value} / ${message.msgByUserId?.id}");

              final String? image = controller.model.value.data?.result?.info?.projectImage;
              final senderImage = message.msgByUserId?.profileImage;
              final isSenderImage = senderImage != null && senderImage.isNotEmpty;

              return ChatBubble(
                message: message,
                name: message.msgByUserId?.name,
                image:  isSenderImage? senderImage : image,
                isSentByMe: (controller.userId.value == message.msgByUserId?.id),
              );
            },
            firstPageProgressIndicatorBuilder: (_) => const Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 60.0,
                )),
            newPageProgressIndicatorBuilder: (_) => const Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 60.0,
                )),
            noItemsFoundIndicatorBuilder: (_) => Obx(() {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CustomNetworkImage(imageUrl: controller.model.value.data?.result?.info?.projectImage ?? ""),
                      ),
                    ),
                    const Gap(8),
                    CustomText(
                      text: controller.model.value.data?.result?.info?.name ?? "",
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                    CustomText(text: "Messenger", fontWeight: FontWeight.w800, color: const Color(0xFF818386)),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}*/

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
