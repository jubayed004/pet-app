// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCode extends StatelessWidget {
  const CustomPinCode({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: PinCodeTextField(
        keyboardType: TextInputType.number,
        appContext: context,
        length: 6, // Ensure length is set to 6 digits
        enableActiveFill: true,
        animationType: AnimationType.fade,
        animationDuration: Duration(milliseconds: 300),
        controller: controller,
        textStyle: TextStyle(color: AppColors.purple500),
        cursorColor: AppColors.purple500,
        hintCharacter: "*",
        hintStyle: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(6),
          fieldHeight: 50,
          fieldWidth: size.width * 0.14,
          inactiveColor: AppColors.grey700,
          activeColor: AppColors.purple500, // active color
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          inactiveBorderWidth: 1,
          activeBorderWidth: 1,
          selectedBorderWidth: 1,
          disabledBorderWidth: 1,
          selectedFillColor: Colors.white, // selected color
          disabledColor: AppColors.purple500,
          selectedColor: AppColors.purple500,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'OTP is required';
          }
          if (value.length != 6) {
            return 'OTP must be 6 digits';
          }
          return null;
        },
      ),
    );
  }
}
