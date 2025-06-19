import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_button_tap/custom_button_tap.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = "/settings";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: AppStrings.settings),
          SliverToBoxAdapter(
            child: Padding(
              padding: paddingH12V6,
              child: Column(
                spacing: 12.h,
                children: [
                 /* Image.asset(logo, height: 100.h),*/
                 Assets.images.splashlogo.image(width:100),
                  SettingsCardWidget(
                    title: "FAQs",

                    icon: Assets.icons.faq.svg(),
                    onTap: () {
                     // Get.toNamed(TermsPolicyHelpPage.routeName,arguments: AppStaticStrings.faqs.tr);
                    },
                  ),
                  SettingsCardWidget(
                    title: "Terms & Condition",

                    icon: Assets.icons.termsCondition.svg(),
                    onTap: () {
                    //  Get.toNamed(TermsPolicyHelpPage.routeName,arguments: AppStaticStrings.termsCondition.tr);
                    },
                  ),
                  SettingsCardWidget(
                    title:"Privacy Policy",

                    icon: Assets.icons.privacypolicy.svg(),
                    onTap: () {
                     // Get.toNamed(TermsPolicyHelpPage.routeName,arguments: AppStaticStrings.privacyPolicy.tr);
                    },
                  ),
                  SettingsCardWidget(
                    title: "Change Password",

                    icon: Assets.icons.changepassword.svg(),
                    onTap: () {
                     AppRouter.route.pushNamed(RoutePath.changePasswordScreen);
                    },
                  ),

                  SettingsCardWidget(
                    title: "Delete Account",

                    icon: Assets.icons.delete.svg(),
                    onTap: () {
                      defaultYesNoDialog(
                        title: "Do you want to delete your profile?",
                        onTap: () {
                        //  Get.offAllNamed(LoginPage.routeName);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> defaultYesNoDialog({
  required String title,
  required Function() onTap,
})
{
  return Get.dialog(
    AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(text: title, ),
         Gap(8),
          Row(
            spacing: 16.w,
            children: [
              Expanded(
                child: CustomButton(
                  borderRadius: 8.r,
                  onTap: onTap,
                  title: "Yes",
                  borderColor: AppColors.kPrimaryDarkColor,
                  textColor: AppColors.kPrimaryDarkColor,
                  fillColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: CustomButton(
                  borderRadius: 8.r,
                  onTap: () {
                    Get.back();
                  },
                  title: "No",
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
class SettingsCardWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function() onTap;
  const SettingsCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kPrimaryColor),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: ButtonTapWidget(
        radius: 6.r,
        onTap: onTap,
        child: Padding(
          padding: padding12,
          child: Row(
            spacing: 8.w,
            children: [
              icon,
              Expanded(child: CustomText(text: title, textAlign: TextAlign.start,)),
              Icon(
                Icons.keyboard_arrow_right_sharp,
                color: AppColors.kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}