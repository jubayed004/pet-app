import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class ChangePasswordScreen extends StatefulWidget {

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final controller = GetControllers.instance.getOtherController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Change Password",),
          SliverToBoxAdapter(child: Padding(
            padding: paddingH16V8,
            child: Form(
              key: _fromKey,
              child: Column(
                spacing: 12.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Current Password',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),

                  CustomTextField(
                    fillColor: AppColors.whiteColor,
                    hintText: "Enter current password",
                    isPassword: true,
                    fieldBorderColor: AppColors.blackColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                    textEditingController: currentPasswordController,
                    keyboardType: TextInputType.phone,
                  ),

                  CustomText(
                    text: 'New Password',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),

                  CustomTextField(
                    fillColor: AppColors.kWhiteColor,
                    hintText: "Enter new password",
                    isPassword: true,
                    fieldBorderColor: AppColors.blackColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    textEditingController: newPasswordController,
                    keyboardType: TextInputType.phone,
                  ),

                  CustomText(
                    text: 'Confirm Password',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),

                  CustomTextField(
                    fillColor: AppColors.kWhiteColor,
                    hintText: "Confirm new password",
                    isPassword: true,
                    fieldBorderColor: AppColors.blackColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (value != newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    textEditingController: confirmPasswordController,
                    keyboardType: TextInputType.phone,
                  ),
                  Gap(8),
                  Obx(() {
                    return CustomButton(
                      isLoading: controller.changePasswordLoading.value,
                      onTap: () {
                        final body = {
                          "oldPassword": currentPasswordController.text,
                          "newPassword": newPasswordController.text,
                          "confirmPassword": confirmPasswordController.text
                        };
                        if(_fromKey.currentState!.validate()){
                          controller.changePassword(body: body);
                        }
                      AppRouter.route.pop();
                    }, title: "Change Password", textColor: Colors.black,);
                  }),
                ],
              ),
            ),
          ),)
        ],
      ),
    );
  }
}
