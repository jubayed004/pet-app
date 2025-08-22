
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/screens/chat/chat_message_model/chat_message_model.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/variable/variable.dart';


class ChatMessageCardItemWidget extends StatelessWidget {
  const ChatMessageCardItemWidget({
    super.key,
    required this.isDriverMessage,
    required this.message,
  });

  final bool isDriverMessage;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: isDriverMessage
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver avatar (only for driver messages)
          if (isDriverMessage)
           CustomNetworkImage(imageUrl: dummyProfileImage,height: 50.w,
             boxShape: BoxShape.circle,
             width: 50.w,),

          Expanded(
            child: Column(
              crossAxisAlignment: isDriverMessage
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                // Message container
                Container(
                  margin: EdgeInsets.only(
                    left: isDriverMessage ? 8 : 0,
                    right: isDriverMessage ? 0 : 8,
                  ),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color:!isDriverMessage?Color(0xffEFEFEF): AppColors.purple510,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Text(
                    message.content,
                    style: TextStyle(
                      color:AppColors.kBlackColor,
                      fontSize: 15,
                    ),
                  ),


                ),

                // Timestamp
                Padding(
                  padding: EdgeInsets.only(
                    top: 4,
                    left: isDriverMessage ? 8 : 0,
                    right: isDriverMessage ? 0 : 8,
                  ),
                  child: Text(
                    message.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // User avatar (only for user messages)
          if (!isDriverMessage)
            CustomNetworkImage(imageUrl: dummyProfileImage,height: 50.w,
              boxShape: BoxShape.circle,
              width: 50.w,),
        ],
      ),
    );
  }
}
