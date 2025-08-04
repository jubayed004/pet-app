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
import 'package:pet_app/presentation/components/custom_pin_code/custom_pin_code.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/widget/text_field/otp_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class AccountActiveOtpScreen extends StatefulWidget {
  AccountActiveOtpScreen({super.key, required this.email, required this.isSignUp});

  final String email;
  final bool isSignUp;

  @override
  State<AccountActiveOtpScreen> createState() => _AccountActiveOtpScreenState();
}

class _AccountActiveOtpScreenState extends State<AccountActiveOtpScreen> {
  final _authController = GetControllers.instance.getAuthController();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController accountVerifyOtp = TextEditingController();

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isSignUp);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    print(widget.isSignUp);
    print(widget.email);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: AppStrings.checkYourEmail,
                  fontWeight: FontWeight.w500,

                  fontSize: 22,
                ),
                Gap(8),
                CustomText(
                  text:
                      "${"Please enter the code we've sent to michelle.rivera@example.com"} ${widget.email}",
                  color: AppColors.secondTextColor,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                const Gap(24),
                Assets.icons.veryfiyscreenimage.svg(),
                const Gap(24),

                ///==================== PIN Put input Field =======================
                Align(
                      alignment: Alignment.center,
                      child: OtpTextField(
                        controller:accountVerifyOtp,
                      ),
                    ),

                Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Didn’t get a code?  ",
                        style: TextStyle(
                          color: AppColors.secondTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text:(_authController.resendActiveLoading.value
                                ? "loading"
                                : "Resend Otp"),

                            style: TextStyle(
                              color: AppColors.purple500,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (!_authController.resendActiveLoading.value) {
                                  _authController.resendActiveOTP(email: widget.email);
                                }

                              },
                          ),
                        ],
                      ),
                    ),
                    /* Obx(
                          () => TextButton(
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
                        child:
                        isSignUp
                            ? Text(
                          _authController.resendActiveLoading.value
                              ? "loading"
                              : "resend_otp",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        )
                            : Text(
                          _authController.resendOTPLoading.value
                              ? "loading"
                              : "resend_otp",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
                Gap(24),
                CustomButton(
                  isLoading:
                      widget.isSignUp
                          ? _authController.activeLoading.value
                          : _authController.otpLoading.value,
                  title: "Confirm",
                  onTap: () {
                    print("verifyOtpScreen");
                    if (widget.isSignUp) {
                      _authController.activeAccount(email: widget.email);
                    } else {
                      _authController.otpVerify(email: widget.email);
                    }
               /*     if (isSignUp){
                    }else{
                      AppRouter.route.pushNamed(RoutePath.setNewPassword,extra: "text@gmail.com");
                    }*/

                  },
                  /*    isLoading: isSignUp
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
                    },
*/
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
