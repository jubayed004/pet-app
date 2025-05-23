/*
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller: controller,
      autofocus: true,
      defaultPinTheme: PinTheme(
        height: 50,
        width: 50,
        textStyle: const TextStyle(color: AppColors.blackColor, fontSize: 18,fontWeight: FontWeight.w800),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
        ),
      ),
      focusedPinTheme: PinTheme(
        height: 50,
        width: 50,
        textStyle: const TextStyle(color: AppColors.blackColor, fontSize: 18,fontWeight: FontWeight.w800),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
        ),
      ),
      submittedPinTheme: PinTheme(
        height: 50,
        width: 50,
        textStyle: const TextStyle(color: AppColors.blackColor, fontSize: 18,fontWeight: FontWeight.w800),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
        ),
      ),
      disabledPinTheme: PinTheme(
        height: 50,
        width: 50,
        textStyle: const TextStyle(color: AppColors.blackColor, fontSize: 18,fontWeight: FontWeight.w800),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
        ),
      ),
      errorPinTheme: PinTheme(
        height: 50,
        width: 50,
        textStyle: const TextStyle(color: AppColors.blackColor, fontSize: 18,fontWeight: FontWeight.w800),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.greenColor,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'OTP_is_required'.tr;
        }
        if (value.length != 6) {
          return 'OTP_must_be_6_digits'.tr;
        }
        return null;
      },
    );
  }
}
*/
