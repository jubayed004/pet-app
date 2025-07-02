import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderSide? border;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomTextButton({
    super.key,
    required this.title,
    this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.padding,
    this.border,
    this.borderRadius,
    this.fontSize, this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          overlayColor: AppColors.kPrimaryColor,// Remove minimum tap area
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            side: border ?? BorderSide.none,
          ),
        ),
        onPressed: onPressed ?? () {},
        child: Padding(
          padding: padding8,
          child: CustomText(text: title,

                fontSize: fontSize ?? 14,
                fontWeight: fontWeight ?? FontWeight.w500,
                color:textColor?? AppColors.kPrimaryColor
              ),
        ));
  }
}
