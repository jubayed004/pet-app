/*
import 'package:betwise_app/helper/image/network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileInfoDetailsWidget extends StatelessWidget {
  final String? img;
  final String? name;
  final String? email;
  final String? phone;
  final bool isEdit;
  const ProfileInfoDetailsWidget({
    super.key,  this.isEdit = true, this.img, this.name, this.email, this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.w,
      children: [
        CustomNetworkImage(
          imageUrl:img?? dummyProfileImage,
          height: 80.w,
          width: 80.w,
        ),
        Expanded(
          child: Column(
            spacing: 4.w,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(

                spacing: 8.w,

                children: [
                  Expanded(
                    child: CustomText(
                      text:name?? "Ely Mohammed",
                      style: poppinsMedium,
                    ),
                  ),
                  isEdit?   ButtonTapWidget(
                    onTap: () {
                      Get.toNamed(EditProfilePage.routeName);
                    },
                    child: GreenAccentContainerWidget(
                      radius: 4.r,
                      child: Padding(
                        padding: padding2,
                        child: Row(
                          spacing: 4.w,
                          children: [
                            SvgPicture.asset(
                              editIcon,
                              colorFilter: ColorFilter.mode(
                                AppColors.kPrimaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            CustomText(
                              text: AppStaticStrings.editProfile.tr,
                              style: poppinsRegular,
                              color: AppColors.kPrimaryColor,
                              fontSize: 10.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ):SizedBox.shrink(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.w,
                children: [
                  SvgPicture.asset(mainIcon),
                  Expanded(
                    child: CustomText(
                      text:email?? "Marvin@gmail.com",
                      style: poppinsRegular,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(
                    callIcon,
                    colorFilter: ColorFilter.mode(
                      AppColors.kPrimaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text:phone?? "(555) 123-4567",
                      style: poppinsRegular,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }
}
*/
