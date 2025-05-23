/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:betwise_app/presentation/widget/align/custom_align_text.dart';
import 'package:betwise_app/presentation/widget/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/widget/text_field/custom_text_field.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _authController = GetControllers.instance.getAuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
   backgroundColor: AppColors.whiteColor,

      body:  Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16, top: 54,right: 16,bottom: 44),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Create Your Account',
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
                CustomText(
                  text: "Join BetWise Picks today. Get expert insights, win smarter, and stay ahead of the game!",
                  color: AppColors.secondTextColor,
                  maxLines: 3,

                ),
                Gap(14),
                CustomAlignText(text: "Name",fontWeight: FontWeight.w500,),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.secondTextColor,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: "John",
                  keyboardType: TextInputType.text,
                  textEditingController: _authController.nameSignUp,

                ),
                Gap(14),
                CustomAlignText(text: "Email",fontWeight: FontWeight.w500,),
                Gap(8.0),
                CustomTextField(
                  hintText: "michelle.rivera@example.com",
                  fieldBorderColor: AppColors.secondTextColor,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: _authController.emailSignUp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email_is_required';
                    }
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter_a_valid_email';
                    }
                    return null;
                  },
                ),
                Gap(14),
                CustomAlignText(text: "Contact number",fontWeight: FontWeight.w500,),
                Gap(8.0),
                CustomTextField(
                  textEditingController: _authController.phoneNumberSignUp,
                  fieldBorderColor: AppColors.secondTextColor,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: "(603) 555-0123",
                  keyboardType: TextInputType.phone,
                  //textEditingController: _authController.p,

                ),
                Gap(14),

                CustomAlignText(text: "PassWord",fontWeight: FontWeight.w500,),
                Gap(8.0),
                CustomTextField(

                  fieldBorderColor: AppColors.secondTextColor,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: "•••••••••••••",
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textEditingController: _authController.passwordSignUp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password_is_required';
                    }
                    if (value.length < 6) {
                      return 'Password_must_be_at_least_6_characters'.tr;
                    }
                    return null;
                  },
                ),
                Gap(14),
                CustomAlignText(text: " Confirm password",fontWeight: FontWeight.w500),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.secondTextColor,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: "•••••••••••••",
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textEditingController: _authController.confirmPasswordSignUp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please_confirm_your_password';
                    }
                    if (value != _authController.passwordSignUp.text) {
                      return 'Passwords_do_not_match';
                    }
                    return null;
                  },
                ),
                Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.5.h,
                      color: AppColors.secondTextColor,
                      width: MediaQuery.of(context).size.width * .38,
                    ),
                    CustomText(text: "OR", left: 8.w, right: 8.w,fontWeight: FontWeight.w600,),
                    Container(
                      height: 1.5.h,
                      color: AppColors.secondTextColor,
                      width: MediaQuery.of(context).size.width * .43,
                    ),
                  ],
                ),
                Gap(24),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(color: AppColors.secondTextColor, fontSize: 16,fontWeight: FontWeight.w400 ),
                      children: [
                        TextSpan(
                          text: " Log In",
                          style: TextStyle(color: AppColors.blueColor,fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppRouter.route.goNamed(RoutePath.signInScreen);
                            },
                        ),

                      ],
                    ),
                  ),
                ),
                Gap(24),
                Obx(() {
                  return CustomButton(
                    isLoading: _authController.loginLoading.value,
                    title: " Continue   ",
                   showIcon : false,
                    onTap: () {
                       if (_formKey.currentState!.validate()) {
                        _authController.signUp();
                      }
                    },
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
