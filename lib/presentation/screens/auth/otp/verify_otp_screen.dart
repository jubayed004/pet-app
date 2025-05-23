/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_pin_code/custom_pin_code.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/widget/back_button/back_button.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key, required this.email, required this.isSignUp});

  final String email;
  final bool isSignUp;

  final _authController = GetControllers.instance.getAuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    print(isSignUp);
*/
/*
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
*//*


    print(isSignUp);
    print(email);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
     appBar: AppBar(
       backgroundColor: Colors.white,
       leading: CustomBackButton(
         onTap: () {
           AppRouter.route.pop();
         },
       ),
     ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "6-digit code",
                    fontWeight: FontWeight.w600,

                    fontSize: 30),
                Gap(8),
                CustomText(
                  text: "${"Please enter the code we've sent to michelle.rivera@example.com"} $email",
                  color: AppColors.secondTextColor,
                  maxLines: 2,
                  textAlign: TextAlign.start,),
                const Gap(24),

                ///==================== PIN Put input Field =======================
                isSignUp?Align(
                  alignment: Alignment.center,
                  child: CustomPinCode(
                    controller:  _authController.accountVerifyOtp,
                  ),
                ): Align(
                  alignment: Alignment.center,
                  child: CustomPinCode(
                    controller: _authController.verifyOtp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() =>
                        TextButton(
                          onPressed: () {
                            if (isSignUp) {
                              if (_authController.resendActiveLoading.value ==
                                  false) {
                                _authController.resendActiveOTP(email: email);
                              }
                            } else {
                              if (_authController.resendOTPLoading.value ==
                                  false) {
                                _authController.resendOTP(email: email);
                              }
                            }
                          },
                          child: isSignUp ? Text(
                            _authController.resendActiveLoading.value
                                ? "loading"
                                : "resend_otp",
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                          ) : Text(
                            _authController.resendOTPLoading.value ? "loading"
                                : "resend_otp",
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                          ),
                        ),
                    ),
                  ],
                ),
                Gap(24),

          CustomButton(
            isLoading: isSignUp
                ? _authController.activeLoading.value
                : _authController.otpLoading.value,
            title: "Confirm",
                    onTap: () {
                      print("verifyOtpScreen");
                       if(isSignUp){
                         _authController.activeAccount(email: email);
                       }else{
                         _authController.otpVerify(email: email);
                       }

                    },

                 */
/*   isLoading: isSignUp
                        ? _authController.activeLoading.value
                        : _authController.otpLoading.value,
                    title: "confirm",
                    onTap: () {
                      print("verifyOtpScreen");
                      if (isSignUp) {
                        _authController.activeAccount(email: email);
                      } else {
                        _authController.otpVerify(email: email);
                      }
                    },*//*

                  ),

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
