import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _authController = GetControllers.instance.getAuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  CustomText(
                    text: "Welcome Back!",
                    fontWeight: FontWeight.w800,
                    fontSize: 24.sp,
                  ),
                  Gap(16),
                  Assets.icons.loginimage.svg(), // Your login image
                  Gap(24),
                  // Email Field
                  CustomAlignText(text: "Email",fontSize: 16,fontWeight: FontWeight.w600,),
                  Gap(8),
                  CustomTextField(
                    fillColor: Colors.white,
                    hintText: AppStrings.enterYourEmail,
                    textEditingController: email,
                    keyboardType: TextInputType.emailAddress,
                    fieldBorderRadius: 10.r,
                    fieldBorderColor: AppColors.secondPrimaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  Gap(24),

                  // Password Field
                  CustomAlignText(text: "Password",fontWeight: FontWeight.w600,fontSize: 16,),
                  Gap(8),
                  CustomTextField(
                    fillColor: Colors.white,
                    hintText: AppStrings.enterYourPassword,
                    textEditingController: password,
                    isPassword: true,
                    fieldBorderRadius: 10.r,
                    fieldBorderColor: AppColors.secondPrimaryColor,
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
                  Gap(16),

                  // Remember Me + Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            _authController.rememberMe.value =
                            !_authController.rememberMe.value;
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 18.h,
                                width: 18.w,
                                decoration: BoxDecoration(
                                  color: _authController.rememberMe.value
                                      ? AppColors.purple500
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 1.sp,
                                      color: AppColors.secondPrimaryColor),
                                  borderRadius: BorderRadius.circular(4.sp),
                                ),
                                child: _authController.rememberMe.value
                                    ? Icon(Icons.check,
                                    color: AppColors.whiteColor, size: 14.sp)
                                    : SizedBox.shrink(),
                              ),
                              Gap(8),
                              CustomText(
                                text: "Remember Me",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        );
                      }),
                      GestureDetector(
                        onTap: () {
                          AppRouter.route
                              .pushNamed(RoutePath.forgotPassScreen);
                        },
                        child: CustomText(
                          text: "Forgot Password?",
                          color: AppColors.whiteColor700,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Gap(24),

                  // Login Button
                  Obx(() {
                    return CustomButton(
                      title: AppStrings.signIn,
                      isLoading: _authController.loginLoading.value,
                      textColor: Colors.black,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final body = {
                            "email": email.text.trim(),
                            "password": password.text
                          };
                          _authController.login(body: body);
                        }
                      },
                    );
                  }),
                  Gap(24),

                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                            color: AppColors.purple500,
                            thickness: 1,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: CustomText(text: "OR"),
                      ),
                      Expanded(
                          child: Divider(
                            color: AppColors.purple500,
                            thickness: 1,
                          )),
                    ],
                  ),
                  Gap(24),

                  // Sign Up Link
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                            color: AppColors.secondTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                                color: AppColors.purple500,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppRouter.route.pushNamed(
                                    RoutePath.vendorSelectionScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
