/*
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileBoxCard extends StatelessWidget {
   ProfileBoxCard({
    super.key,
    required this.text,
    required this.icons,
    required this.onTap,
    this.color =AppColors.blackColor,
     this.iconColor =AppColors.blackColor,
  });
   final Color? iconColor;
   final Color? color;
  final String text;
  final Widget icons;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0,),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 24,

                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    icons,
                    Gap(10),
                    Flexible(
                      child: CustomText(
                        text: text,
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: iconColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
