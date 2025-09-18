import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button_tap/custom_button_tap.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class MessageCardItemWidget extends StatelessWidget {
  final bool isRead;
  final String name;
  final String message;
  final String date;
  final String image;
  final String senderId;

  const MessageCardItemWidget({
    super.key,
    this.isRead = false,
    required this.name,
    required this.message,
    required this.date,
    required this.image,
    required this.senderId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isRead == false ? AppColors.kPrimaryAccentColor : AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: AppColors.kBlackColor.withValues(alpha: 0.1), blurRadius: 12.r)],
      ),
      child: ButtonTapWidget(
        radius: 16.r,
        onTap: () {
          AppRouter.route.pushNamed(RoutePath.chatScreen, extra: senderId);
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            spacing: 12.w,
            children: [
              CustomNetworkImage(imageUrl: "${ApiUrl.imageBase}$image", boxShape: BoxShape.circle, height: 50.w, width: 50.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///=============================dynamic user name =============================///
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: name,
                            fontWeight: FontWeight.bold, // Bold if owner
                          ),
                        ),
                        Expanded(child: CustomText(text: date, color: AppColors.kExtraLightGreyTextColor)),
                      ],
                    ),

                    ///=============================dynamic message =============================///
                    CustomText(
                      text: message,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
