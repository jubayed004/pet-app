import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/dialog/show_custom_animated_dialog.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_button_tap/custom_button_tap.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class SettingsPage extends StatelessWidget {
   SettingsPage({super.key});
  final profileController = GetControllers.instance.getProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: AppStrings.settings),
          SliverToBoxAdapter(
            child: Padding(
              padding: paddingH12V6,
              child: Column(
                spacing: 12.h,
                children: [

                 Assets.images.splashlogo.image(width:100),
                  SettingsCardWidget(
                    title: "FAQs",

                    icon: Assets.icons.faq.svg(),
                    onTap: () {
                     AppRouter.route.pushNamed(RoutePath.helpFaqScreen);
                    },
                  ),
                  SettingsCardWidget(
                    title: "Help Center",
                    icon: Assets.icons.help.svg(),
                    onTap: () {
                     AppRouter.route.pushNamed(RoutePath.helpCenterScreen);
                    },
                  ),
                  SettingsCardWidget(
                    title: "Terms & Condition",

                    icon: Assets.icons.termsCondition.svg(),
                    onTap: () {
                    AppRouter.route.pushNamed(RoutePath.termsOfCondition);
                    },
                  ),
                  SettingsCardWidget(
                    title:"Privacy Policy",

                    icon: Assets.icons.privacypolicy.svg(),
                    onTap: () {
                     AppRouter.route.pushNamed(RoutePath.privacyPolicy);
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
                      showCustomAnimatedDialog(

                        context: context,
                        title: "Warning",
                        subtitle:
                        "Do you want to delete your profile?",
                        actionButton: [
                          CustomButton(
                            width: double.infinity,
                            height: 36,
                            fillColor: Colors.white,
                            // White background
                            borderWidth: 1,
                            // Border width
                            borderColor: AppColors.greenColor,
                            // Border color (black)
                            onTap: () {
                              AppRouter.route.pop();
                            },
                            textColor: AppColors.greenColor,
                            title: "Cancel",
                            isBorder: true,
                            fontSize: 14, // Ensure the border is visible
                          ),
                          CustomButton(

                            fillColor: AppColors.primaryColor,
                            width: double.infinity,
                            height: 36,
                            onTap: ()  {

                              DBHelper().logOut();// Navigate
                            },
                            title: " Confirm",
                            fontSize: 14,
                          ),
                        ],
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
        color: Color(0xFFF9F7F1),
        border: Border.all(color: AppColors.purple200),
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
                color: AppColors.purple200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}