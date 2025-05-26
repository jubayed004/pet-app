
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:pet_app/utils/app_strings/app_strings.dart';

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
                  text: AppStrings.helloLets,
                  color: AppColors.blackNormal,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,

                ),
                Gap(14),
                CustomAlignText(text:AppStrings.fullName,fontWeight: FontWeight.w500,),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: "John",
                  keyboardType: TextInputType.text,
                  textEditingController: _authController.nameSignUp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;  // Valid
                  },
                ),
                Gap(14),
                CustomAlignText(text: "Email",fontWeight: FontWeight.w500,),
                Gap(8.0),
                CustomTextField(
                  hintText: AppStrings.enterYourEmail,
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: _authController.emailSignUp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                Gap(14),
                CustomAlignText(text: AppStrings.phoneNumber,fontWeight: FontWeight.w500,),
                Gap(8.0),
                CustomTextField(
                  textEditingController: _authController.phoneNumberSignUp,
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterYourPhone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }

                  },
                ),

                Gap(14),

                CustomAlignText(text: "PassWord",fontWeight: FontWeight.w500,),
                Gap(8.0),
                CustomTextField(

                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterYourPassword,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textEditingController: _authController.passwordSignUp,
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
                Gap(14),
                CustomAlignText(text: AppStrings.confirmPassword,fontWeight: FontWeight.w500),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.confirmNewPassword,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textEditingController: _authController.confirmPasswordSignUp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _authController.passwordSignUp.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                Gap(24),
                Obx(() {
                  return CustomButton(
                    isLoading: _authController.loginLoading.value,
                    title: " Continue   ",
                   textColor: Colors.black,
                   showIcon : false,
                    onTap: () {
                   /*    if (_formKey.currentState!.validate()) {
                        _authController.signUp();
                      }*/
                      AppRouter.route.pushNamed(RoutePath.petRegistrationScreen);
                    },
                  );
                }),
                Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.5.h,
                      color: AppColors.purple500,
                      width: MediaQuery.of(context).size.width * .38,
                    ),
                    CustomText(text: "OR", left: 8.w, right: 8.w,fontWeight: FontWeight.w600,),
                    Container(
                      height: 1.5.h,
                      color: AppColors.purple500,
                      width: MediaQuery.of(context).size.width * .43,
                    ),
                  ],
                ),
                Gap(24),
                Align(
                  alignment: Alignment.topCenter,
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(color: AppColors.secondTextColor, fontSize: 16,fontWeight: FontWeight.w400 ),
                      children: [
                        TextSpan(
                          text: " Sign In",
                          style: TextStyle(color: AppColors.purple500,fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppRouter.route.goNamed(RoutePath.signInScreen);
                            },
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
