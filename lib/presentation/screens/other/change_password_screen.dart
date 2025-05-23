/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/helper/dialog/show_custom_animated_dialog.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:betwise_app/presentation/widget/align/custom_align_text.dart';
import 'package:betwise_app/presentation/widget/back_button/back_button.dart';
import 'package:betwise_app/presentation/widget/text_field/custom_text_field.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final controller = GetControllers.instance.getOtherController();
  final controllerNav = GetControllers.instance.getNavigationControllerMain();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.password.clear();
    controller.newPassword.clear();
    controller.confirmPassword.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomText(text: "Change Password",fontSize: 16,fontWeight: FontWeight.w500,),
        leading: CustomBackButton(
          onTap: () {
            AppRouter.route.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomAlignText(text: "Type Password"),
              const Gap(5),
              CustomTextField(
                hintText: "************",
                isPassword: true,
                textEditingController: controller.password,
                fillColor: Colors.white,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password_is_required';
                  }
                  if (value.length < 6) {
                    return 'Password_must_be_at_least_6_characters';
                  }
                  return null;
                },
              ),
              const Gap(12),
              CustomAlignText(text: "New password"),
              const Gap(5),
              CustomTextField(
                hintText: "•••••••••••••",
                isPassword: true,
                fillColor: Colors.white,
                textEditingController: controller.newPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password_is_required';
                  }
                  if (value.length < 6) {
                    return 'Password_must_be_at_least_6_characters';
                  }
                  return null;
                },
              ),
              const Gap(12),
              CustomAlignText(text: "New Confirm password"),
              const Gap(5),
              CustomTextField(
                hintText: "•••••••••••••",
                isPassword: true,
                fillColor: Colors.white,
                textEditingController: controller.confirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please_confirm_your_password';
                  }
                  if (value != controller.newPassword.text) {
                    return 'Passwords_do_not_match';
                  }
                  return null;
                },
              ),
              const Gap(24),
              Obx(() {
                return CustomButton(
                  title: "Update",
                  isLoading: controller.changePasswordLoading.value,
                  onTap: () {
                   */
/* if(_formKey.currentState!.validate()){
                      controller.changePassword();
                    }*//*

                    showCustomAnimatedDialog(
                      animationSrc: "assets/images/warning.png",
                      context: context,
                      title: "Warning",
                      subtitle: "Are you sure you want to change your password?",
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
                              subtitle: "Your password has been changed successfully.",
                              animationSrc: "assets/animation/success.json",  // Path to your Lottie animation
                              isDismissible: true,
                              actionButton: [
                                CustomButton(
                                  height: 36,
                                  width: 100,
                                  onTap: () {
                                    AppRouter.route.pop();  // Navigate
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
                    );
                  },
                );
              }),
              const Gap(12),
            ],
          ),
        ),
      ),
    );
  }
}
*/
