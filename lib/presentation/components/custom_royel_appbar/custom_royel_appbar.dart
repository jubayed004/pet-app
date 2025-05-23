/*
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomRoyelAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleName;
  final List<Widget>? actions; // Added actions as a list of custom widgets
  final void Function()? rightOnTap;
  final Icon? rightIcon;
  final bool? leftIcon;
  final double fontSize;
  final Color colors;
  final Color iconColors;
  final VoidCallback? rightOnPressed;
  final VoidCallback? leftOnPressed;

  const CustomRoyelAppbar(
      {super.key,
        this.titleName,
        this.actions, // Receive custom actions as a list of widgets
        this.rightIcon,
        this.rightOnTap,
        this.leftIcon = true,
        this.fontSize = 20,
        this.colors = AppColors.whiteColor,
        this.iconColors = AppColors.whiteColor,
        this.rightOnPressed,
        this.leftOnPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14),
      child: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: actions ?? [
          IconButton(
            onPressed: rightOnPressed,
            icon: Center(
              child: rightIcon
            ),
          )
        ], // Custom actions or default one if none passed
        backgroundColor: Colors.transparent,
        leading: leftIcon == true
            ? IconButton(
          onPressed: leftOnPressed  ?? (){
            Get.back();
          },
          icon: Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Center(
              child: Icon(
                size: 20,
                Icons.arrow_back,
                color: Colors.blue,
              ),
            ),
          ),
        )
            : SizedBox(),
        title: CustomText(
          text: titleName ?? "",
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: colors,
        ),
      ),
    );
  }

  @override
  // TO DO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
*/
