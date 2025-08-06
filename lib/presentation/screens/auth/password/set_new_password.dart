import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key, required this.email, required this.code});

  final String email;
  final String code;

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final _authController = GetControllers.instance.getAuthController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController resetPassword = TextEditingController();
  final TextEditingController resetConfirmPassword = TextEditingController();
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
                CustomText(text: "set a new password",
                    fontWeight: FontWeight.w800,
                    fontSize: 24),
                CustomText(
                  text: "create a secure password to protect your account and get started seamlessly"
                      .tr, color: AppColors.secondTextColor, maxLines: 2,),
                const Gap(24),

                ///=============================== Password text ==================================
                const Gap(12),
                CustomAlignText(text: "New password"),
                const Gap(8),
                CustomTextField(
                  fillColor: AppColors.kWhiteColor,
                  hintText: "enter your password",
                  isPassword: true,
                  keyboardType: TextInputType.text,
                  textEditingController: resetPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                ///=============================== Confirm Password text ==================================
                const Gap(24),
                CustomAlignText(text: "Confirm Password"),
                const Gap(8),
                CustomTextField(
                  fillColor: AppColors.kWhiteColor,
                  hintText: "confirm your password",
                  isPassword: true,
                  keyboardType: TextInputType.text,
                  textEditingController: resetConfirmPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field can't be empty";
                    } else if (value != resetPassword.text) {
                      return "password should match";
                    }
                    return null;
                  },
                ),
                Gap(24),
                Obx(() {
                  return CustomButton(
                    isLoading: _authController.resetLoading.value,
                      title: "confirm", onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final body = {
                        "email": widget.email,
                        "code": widget.code,
                        "password": resetPassword.text,
                        "confirmPassword": resetConfirmPassword.text
                      };
                      _authController.reset(body: body);
                    }
                  /*  AppRouter.route.goNamed(RoutePath.signInScreen);*/
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
