/*

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/chat/model/model.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/variable/variable.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatBubble extends StatelessWidget {
  final MessageItems message;
  final bool isSentByMe;
  final String? name, image;

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
  final MessageItems message;

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
          child: message.imageUrl != null && ((message.imageUrl?.length??0) > 0)?Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                children: List.generate(message.imageUrl?.length??0, (imageIndex){
                  return GestureDetector(
                    onTap: (){},*/
/*AppRouter.route.pushNamed(RoutePath.imagesViewScreen, extra: [message.imageUrl?[imageIndex]??""]),*//*

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: CustomNetworkImage(imageUrl: message.imageUrl?[imageIndex]??"",width: 100,
                        height: 100,
                        fit: BoxFit.cover,),
                    ),
                  );
                }),
              ),
              const Gap(2),
              Text(
                message.text ?? "",
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ):Text(
            message.text ?? "",
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        const Gap(5),
        CustomText(text: timeago.format(message.createdAt ?? DateTime.now()), color: Colors.black, fontSize: 12),
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
  final MessageItems message;

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
              child: CustomNetworkImage(imageUrl: image??""),
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
                  margin: EdgeInsets.only(left: isSentByMe ? 40 : 0, right: isSentByMe ? 0 : 40,),
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
                  child: message.imageUrl != null && ((message.imageUrl?.length??0) > 0)?Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8,
                        children: List.generate(message.imageUrl?.length??0, (imageIndex){
                          return GestureDetector(
                            onTap: (){},*/
/*AppRouter.route.pushNamed(RoutePath.imagesViewScreen, extra: [message.imageUrl?[imageIndex]??""]),*//*

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CustomNetworkImage(imageUrl: message.imageUrl?[imageIndex]??"",width: 100,
                                height: 100,
                                fit: BoxFit.cover,),
                            ),
                          );
                        }),
                      ),
                      const Gap(12),
                      Text(
                        message.text ?? "",
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      )
                    ],
                  ):Text(
                    message.text ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const Gap(5),
                CustomText(text: timeago.format(message.createdAt ?? DateTime.now()), color: Colors.black, fontSize: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
