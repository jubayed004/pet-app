import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/widget/text_field/otp_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class AccountActiveOtpScreen extends StatefulWidget {
  const AccountActiveOtpScreen({super.key, required this.email});

  final String email;

  @override
  State<AccountActiveOtpScreen> createState() => _AccountActiveOtpScreenState();
}

class _AccountActiveOtpScreenState extends State<AccountActiveOtpScreen> {
  final _authController = GetControllers.instance.getAuthController();

  final _formKey = GlobalKey<FormState>();
  final accountVerifyOtp = TextEditingController();

  @override
  void dispose() {
    accountVerifyOtp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      "${"Please enter the code we've sent to "} ${widget.email}",
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

                  ],
                ),
                Gap(24),
                CustomButton(
                  isLoading: _authController.activeLoading.value,
                  title: "Confirm",
                  onTap: () {
                    _authController.activeAccount(email: widget.email,code: accountVerifyOtp.text.trim());
                  }
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
