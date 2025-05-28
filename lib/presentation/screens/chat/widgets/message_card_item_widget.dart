import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button_tap/custom_button_tap.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/chat/view/chatting_page.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/variable/variable.dart';

class MessageCardItemWidget extends StatelessWidget {
  final bool? isRead;
  const MessageCardItemWidget({super.key, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isRead == false ? AppColors.kPrimaryAccentColor : AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: AppColors.kBlackColor.withValues(alpha: .1),blurRadius: 12.r)],
      ),
      child: ButtonTapWidget(
        radius: 16.r,
        onTap: () {
          AppRouter.route.pushNamed(RoutePath.chatScreen);
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            spacing: 12.w,
            children: [
              CustomNetworkImage(
                imageUrl: dummyProfileImage,
                boxShape: BoxShape.circle,
                height: 50.w,
                width: 50.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///=============================dynamic user name =============================///
                    CustomText(text: 'Alex Wheeler', ),

                    ///=============================dynamic message =============================///
                    CustomText(
                      text: 'Hello! Im available to pick you up. Ill be th..',

                    ),
                  ],
                ),
              ),
              CustomText(
                text: '09/27/24',

                color: AppColors.kExtraLightGreyTextColor,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
