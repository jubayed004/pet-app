
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height = 55,
    this.width = double.maxFinite,
    required this.onTap,
    this.title = '',
    this.marginVertical = 0,
    this.marginHorizontal = 0,
    this.fillColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.isBorder = false,
    this.fontSize,
    this.borderWidth,
    this.borderRadius,
    this.isLoading = false,
    this.showIcon = false,
    this.iconSize = 20,
    this.borderColor,
   this.icon,
    this.fontWeight,
  });

  final Color? borderColor;
  final double height;
  final double? width;
  final Color? fillColor;
  final Color textColor;
  final VoidCallback onTap;
  final String title;
  final double marginVertical;
  final double marginHorizontal;
  final bool isBorder;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final bool? isLoading;
  final bool showIcon;
  final double iconSize;
  final Widget? icon;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(),
        margin: EdgeInsets.symmetric(vertical: marginVertical, horizontal: marginHorizontal),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: isBorder
              ? Border.all(color: borderColor ?? Colors.black, width: borderWidth ?? 2)  // Ensure fallback if borderColor is null
              : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
          color: fillColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              fontSize: fontSize ?? 18.sp,
              fontWeight: fontWeight??FontWeight.w700,
              color: textColor,
              textAlign: TextAlign.center,
              text: title,
            ),
            Gap(8),
            // Show icon only if showIcon is true
            showIcon ? icon?? SizedBox() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}



