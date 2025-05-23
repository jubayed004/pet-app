/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:betwise_app/presentation/widget/align/custom_align_text.dart';
import 'package:betwise_app/presentation/widget/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/widget/text_field/custom_text_field.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SetNewPassword extends StatelessWidget {
  SetNewPassword({super.key, required this.email});

  final String email;

  final _authController = GetControllers.instance.getAuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(text: "set_a_new_password".tr,
                    fontWeight: FontWeight.w800,
                    fontSize: 24),
                CustomText(
                  text: "create_a_secure_password_to_protect_your_account_and_get_started_seamlessly"
                      .tr, color: AppColors.secondTextColor, maxLines: 2,),
                const Gap(24),

                ///=============================== Password text ==================================
                const Gap(12),
                CustomAlignText(text: "password"),
                const Gap(8),
                CustomTextField(
                  hintText: "enter_your_password".tr,
                  isPassword: true,
                  keyboardType: TextInputType.text,
                  textEditingController: _authController.resetPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password_is_required'.tr;
                    }
                    if (value.length < 6) {
                      return 'Password_must_be_at_least_6_characters'.tr;
                    }
                    return null;
                  },
                ),

                ///=============================== Confirm Password text ==================================
                const Gap(24),
                CustomAlignText(text: "confirm_password".tr),
                const Gap(8),
                CustomTextField(
                  hintText: "confirm_your_password".tr,
                  isPassword: true,
                  keyboardType: TextInputType.text,
                  textEditingController: _authController.resetConfirmPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field_can_t_be_empty".tr;
                    } else if (value != _authController.resetPassword.text) {
                      return "password_should_match".tr;
                    }
                    return null;
                  },
                ),
                Gap(24),
                Obx(() {
                  return CustomButton(
                    isLoading: _authController.resetLoading.value,
                      title: "confirm".tr, onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _authController.reset(email: email);
                    }
                  });
                }),
                Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
