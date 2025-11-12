import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/service/socket_service.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'controller/chat_controller.dart';
import 'model/chat_model.dart';

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
  late final ChatController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = GetControllers.instance.getChatController();
    pagingController.addPageRequestListener((pageKey) {
      controller.getChatList(
        pageKey: pageKey,
        id: widget.senderId,
        pagingController: pagingController,
      );
    });
    _initializeSocketAndController();
  }

  Future<void> _initializeSocketAndController() async {
    try {
      debugPrint("Socket 1");
      await SocketApi.init();
      debugPrint("Socket 2");
      controller.listenForNewMessages(
        senderId: widget.senderId,
        pagingController: pagingController,
      );
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

  void _showOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(
                  controller.isBlocked.value ? Iconsax.lock_1 : Iconsax.lock,
                  color: controller.isBlocked.value ? Colors.green : Colors.red,
                ),
                title: Text(
                  controller.isBlocked.value ? 'Unblock User' : 'Block User',
                  style: TextStyle(
                    color: controller.isBlocked.value ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  controller.isBlocked.value
                      ? 'Allow messages from this user'
                      : 'Stop receiving messages from this user',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                onTap: () {
                  if (controller.isBlocked.value) {
                    _showUnblockConfirmation();
                  } else {
                    _showBlockConfirmation();
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }

  void _showBlockConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Block User?'),
        content: const Text(
          'Are you sure you want to block this user? You won\'t receive messages from them.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          Obx(() {
            return TextButton(
              onPressed: controller.isBlockLoading.value
                  ? null
                  : () {
                Navigator.pop(context);
                controller.blockUser( id: widget.senderId);
                print("================SENDER ID =======================${widget.senderId}===================SENDER ID=================");
              },
              child: controller.isBlockLoading.value
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text(
                'Block',
                style: TextStyle(color: Colors.red),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showUnblockConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Unblock User?'),
        content: const Text(
          'Are you sure you want to unblock this user? You will start receiving messages from them.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          Obx(() {
            return TextButton(
              onPressed: controller.isBlockLoading.value
                  ? null
                  : () {
                Navigator.pop(context);
                controller.blockUser(id: widget.senderId);
              },
              child: controller.isBlockLoading.value
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text(
                'Unblock',
                style: TextStyle(color: Colors.green),
              ),
            );
          }),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Obx(() {
          final name = controller.chatModel.value.participant?.name ?? "Chat";
          return Text(name);
        }),
        centerTitle: true,
        actions: [
          Obx(() {
            if (controller.isBlocked.value) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  label: const Text(
                    'Blocked',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.zero,
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          IconButton(
            icon: const Icon(Iconsax.more),
            onPressed: _showOptionsBottomSheet,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          if (controller.isBlockedByOther.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.lock,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'You cannot send messages to this user',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This user has blocked you',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return Form(
            key: _formKey,
            child: Column(
              children: [
                MessageListCard(
                  controller: controller,
                  scrollController: scrollController,
                  pagingController: pagingController,
                ),
                ChatInputBox(
                  controller: controller,
                  formKey: _formKey,
                  widget: widget,
                  messageController: messageController,
                  senderId: widget.senderId,
                ),
              ],
            ),
          );
        }),
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
    required this.messageController,
    required this.senderId,
  }) : _formKey = formKey;

  final ChatController controller;
  final TextEditingController messageController;
  final GlobalKey<FormState> _formKey;
  final ChatScreen widget;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isInputDisabled = controller.isBlocked.value || controller.isBlockedByOther.value;

      return Container(
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12, top: 5),
        width: double.infinity,
        child: Column(
          children: [
            if (controller.isBlocked.value)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.info_circle, size: 20, color: Colors.orange[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You have blocked this user. Unblock to send messages.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Obx(() {
              return controller.selectedImages.isNotEmpty && !isInputDisabled
                  ? Padding(
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
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                              ),
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
              )
                  : const SizedBox();
            }),
            Container(
              decoration: BoxDecoration(
                color: isInputDisabled ? Colors.grey[200] : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: isInputDisabled
                        ? null
                        : () {
                      controller.pickCameraImage();
                    },
                    icon: Icon(
                      Iconsax.camera,
                      color: isInputDisabled ? Colors.grey : null,
                    ),
                  ),
                  IconButton(
                    onPressed: isInputDisabled
                        ? null
                        : () {
                      controller.pickImage();
                    },
                    icon: Icon(
                      Iconsax.gallery,
                      color: isInputDisabled ? Colors.grey : null,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      enabled: !isInputDisabled,
                      maxLines: 5,
                      minLines: 1,
                      maxLength: 500,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        } else {
                          return "Please write a message...";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: isInputDisabled ? "Chat disabled" : "Aa",
                        hintStyle: TextStyle(
                          color: isInputDisabled ? Colors.grey : Colors.black,
                        ),
                        counterText: "",
                        filled: true,
                        fillColor: isInputDisabled ? Colors.grey[200] : AppColors.whiteColor,
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
                      onPressed: controller.callMessageSend.value || isInputDisabled
                          ? null
                          : () {
                        if (controller.selectedImages.isNotEmpty) {
                          controller.sendMessage(
                            senderId: senderId,
                            context: context,
                            messageController: messageController,
                          );
                        } else {
                          if (_formKey.currentState!.validate()) {
                            controller.sendMessage(
                              senderId: senderId,
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
                          : Icon(
                        Iconsax.send1,
                        size: 24,
                        color: isInputDisabled ? Colors.grey : null,
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      );
    });
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
              final String? image = controller.chatModel.value.participant?.profilePic;
              final String? name = controller.chatModel.value.participant?.name;

              return ChatBubble(
                message: message,
                name: name,
                image: image,
                isSentByMe: (controller.userId.value == message.sender),
              );
            },
            firstPageProgressIndicatorBuilder: (_) => const Center(
              child: SpinKitCircle(
                color: Colors.grey,
                size: 60.0,
              ),
            ),
            newPageProgressIndicatorBuilder: (_) => const Center(
              child: SpinKitCircle(
                color: Colors.grey,
                size: 60.0,
              ),
            ),
            noItemsFoundIndicatorBuilder: (_) => const Center(
              child: Text("No conversation found!"),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageItem message;
  final bool isSentByMe;
  final String? name;
  final String? image;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByMe,
    this.name,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: isSentByMe
          ? MyBubble(
        isSentByMe: isSentByMe,
        message: message,
      )
          : PartnerBubble(
        isSentByMe: isSentByMe,
        message: message,
        name: name,
        image: image,
      ),
    );
  }
}

class MyBubble extends StatelessWidget {
  const MyBubble({
    super.key,
    required this.isSentByMe,
    required this.message,
  });

  final bool isSentByMe;
  final MessageItem message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: isSentByMe ? 40 : 0, right: isSentByMe ? 0 : 40, top: 12),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.secondPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: isSentByMe ? const Radius.circular(15) : const Radius.circular(0),
              bottomRight: isSentByMe ? const Radius.circular(0) : const Radius.circular(15),
            ),
          ),
          child: message.images != null && ((message.images?.length ?? 0) > 0)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                children: List.generate(message.images?.length ?? 0, (imageIndex) {
                  return GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: CustomNetworkImage(
                        imageUrl: message.images?[imageIndex] ?? "",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
              if (message.text != null && message.text!.isNotEmpty) ...[
                const Gap(2),
                Text(
                  message.text ?? "",
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ],
          )
              : Text(
            message.text ?? "",
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        const Gap(5),
        CustomText(
          text: timeago.format(message.createdAt ?? DateTime.now()),
          color: Colors.black,
          fontSize: 12,
        ),
      ],
    );
  }
}

class PartnerBubble extends StatelessWidget {
  const PartnerBubble({
    super.key,
    required this.isSentByMe,
    required this.message,
    this.name,
    this.image,
  });

  final bool isSentByMe;
  final String? name, image;
  final MessageItem message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CustomNetworkImage(imageUrl: image ?? ""),
            ),
          ),
          const Gap(5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: name ?? "Unknown", color: Colors.black, fontSize: 14),
                const Gap(5),
                Container(
                  margin: EdgeInsets.only(
                    left: isSentByMe ? 40 : 0,
                    right: isSentByMe ? 0 : 40,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF363636),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: isSentByMe ? const Radius.circular(15) : const Radius.circular(0),
                      bottomRight: isSentByMe ? const Radius.circular(0) : const Radius.circular(15),
                    ),
                  ),
                  child: message.images != null && ((message.images?.length ?? 0) > 0)
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8,
                        children: List.generate(message.images?.length ?? 0, (imageIndex) {
                          return GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CustomNetworkImage(
                                imageUrl: message.images?[imageIndex] ?? "",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                      ),
                      if (message.text != null && message.text!.isNotEmpty) ...[
                        const Gap(12),
                        Text(
                          message.text ?? "",
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ],
                  )
                      : Text(
                    message.text ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const Gap(5),
                CustomText(
                  text: timeago.format(message.createdAt ?? DateTime.now()),
                  color: Colors.black,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}