import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/screens/chat/chat_controller/message_controller.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

import '../widgets/chat_message_card_item_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chatting';
   const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = GetControllers.instance.getMessageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Chat",),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final message = messageController.messages[index];
                final isDriverMessage = message.isFromDriver;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
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
}
