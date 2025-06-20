
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _authController = GetControllers.instance.getAuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: '"Welcome Back!"',
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
               Assets.icons.loginimage.svg(),
               /* CustomText(
                  text: "Access your account and stay ahead with expert picks.",
                  color: AppColors.secondTextColor,
                  maxLines: 3,

                ),*/
                Gap(24),
                CustomAlignText(text: "Email"),
                Gap(8.0),
                CustomTextField(
                  hintText: AppStrings.enterYourEmail,
                  fieldBorderColor: AppColors.secondPrimaryColor,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: _authController.email,
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
                Gap(24),
                CustomAlignText(text: "PassWord"),
                Gap(8.0),
                CustomTextField(

                  fieldBorderColor: AppColors.secondPrimaryColor,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterYourPassword,
                  isPassword: true,
                  keyboardType: TextInputType.text,
                  textEditingController: _authController.password,
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
                Gap(16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          // Toggling the rememberMe value
                          _authController.rememberMe.value =
                              !_authController.rememberMe.value;
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 16.h,
                              width: 16.w,
                              decoration: BoxDecoration(
                                color:
                                    _authController.rememberMe.value
                                        ? AppColors.purple500
                                        : Colors.transparent,
                                border: Border.all(
                                  width: .5.sp,
                                  color: AppColors.secondPrimaryColor
                                ),
                                borderRadius: BorderRadius.circular(4.sp),
                              ),
                              child: Center(
                                child:
                                    _authController.rememberMe.value
                                        ? Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 14.sp,
                                        )
                                        : const SizedBox(),
                              ),
                            ),
                            CustomText(
                              left: 8.w,
                              text: "Remember Me",
                              // Replace this with appropriate text
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      );
                    }),

                    GestureDetector(
                      onTap: () {
                        AppRouter.route.pushNamed(RoutePath.forgotPassScreen);
                      },
                      child: CustomText(
                        text: "Forget Password ?",
                        color: AppColors.whiteColor700,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                Gap(24),
              CustomButton(
                // isLoading: _authController.loginLoading.value,
                textColor: Colors.black,
                title: AppStrings.signIn,
                onTap: () {
                  /*      if (_formKey.currentState!.validate()) {
                        _authController.login();
                      }*/

                  if(_authController.isUser.value){
                    AppRouter.route.goNamed(RoutePath.navigationPage);
                  }else{
                    AppRouter.route.goNamed(RoutePath.navigationPage);
                  }
                },
              ),
              /*  Obx(() {
                  return
                }),*/
                Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.h,
                      color: AppColors.purple500,
                      width: MediaQuery.of(context).size.width * .38,
                    ),
                    CustomText(text: "OR", left: 8.w, right: 8.w),
                    Container(
                      height: 1.h,
                      color: AppColors.purple500,
                      width: MediaQuery.of(context).size.width * .38,
                    ),
                  ],
                ),
                Gap(24),
                Align(
                  alignment: Alignment.topCenter,
                  child: RichText(
                    text: TextSpan(
                      text: 'Don’t have an account?',
                      style: TextStyle(color: AppColors.secondTextColor, fontSize: 16,fontWeight: FontWeight.w400 ),
                      children: [
                        TextSpan(
                          text: " Sign Up",
                          style: TextStyle(color: AppColors.purple500,fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppRouter.route.goNamed(RoutePath.signUpScreen);
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
