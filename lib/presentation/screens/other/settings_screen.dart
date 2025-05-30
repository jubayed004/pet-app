/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/custom_assets/assets.gen.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/helper/dialog/show_custom_animated_dialog.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:betwise_app/presentation/screens/other/widget/setting_notification_card.dart';
import 'package:betwise_app/presentation/screens/profile/profile_screen.dart';
import 'package:betwise_app/presentation/screens/profile/widgets/button_section_all.dart';
import 'package:betwise_app/presentation/widget/align/custom_align_text.dart';
import 'package:betwise_app/presentation/widget/back_button/back_button.dart';
import 'package:betwise_app/presentation/widget/text_field/custom_text_field.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final controller = GetControllers.instance.getOtherController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomText(text: "Account Setting",fontWeight: FontWeight.w500,fontSize: 16,),
        leading:CustomBackButton(
          onTap: () {
            AppRouter.route.pop();
          },
        )

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            SettingNotificationCard(
              icons: Assets.icons.notificationmail.svg(),
              text: "Send Notification On Mail",
              onTap: (){},
            ),
           controller.isSubscription ? ProfileBoxCard(
              icons: Assets.icons.mysubscip.svg(),
              text: "My Subscription",
              onTap: () => AppRouter.route.pushNamed(RoutePath.subscriptionStatusScreen),
            ):SizedBox(),
            ProfileBoxCard(
              icons: Assets.icons.changepass.svg(),
              text: "Change Password",
            onTap: () {
                   AppRouter.route.pushNamed(RoutePath.changePasswordScreen);
                 },
            ),
            ProfileBoxCard(
              iconColor: Colors.red,
              color: Colors.red,
              icons: Assets.icons.deletedaccount.svg(),
              text: "Delete Account",
              onTap: () =>

                  showCustomAnimatedDialog(
                animationSrc: "assets/images/warning.png",
                context: context,
                title: "Warning",
                subtitle: "Are you sure you want to permanently delete your account? This action cannot be undone.",
                actionButton: [
                  CustomButton(
                    width: double.infinity,
                    height: 36,
                    fillColor: Colors.white,                 // White background
                    borderWidth: 1,                          // Border width
                    borderColor: AppColors.greenColor,               // Border color (black)
                    onTap: () {
                      AppRouter.route.pop();
                    },
                    textColor: AppColors.greenColor,
                    title: "Cancel",
                    isBorder: true,
                    fontSize: 14,// Ensure the border is visible
                  ),
                  CustomButton(
                    width: double.infinity,
                    height: 36,
                    onTap: ()async{

                      AppRouter.route.pop();
                      await Future.delayed(Duration(milliseconds: 100));
                      showCustomAnimatedDialog(
                        context: context,
                        title: "Success",
                        subtitle: "Your account has been deleted successfully.",
                        animationSrc: "assets/animation/success.json",  // Path to your Lottie animation
                        isDismissible: true,
                        actionButton: [
                          CustomButton(
                            height: 36,
                            width: 100,
                            onTap: () {
                              AppRouter.route.goNamed(RoutePath.signInScreen);  // Navigate
                            },
                            title: "Confirm",
                            fontSize: 14,
                          ),
                        ],
                      );

                    },
                    title: " Confirm",
                    fontSize: 14,

                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }


}
*/
