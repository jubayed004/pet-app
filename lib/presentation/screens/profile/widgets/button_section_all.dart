import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class ButtonSectionAll extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;
  final bool showTrailingIcon;

  const ButtonSectionAll({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.showTrailingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon,
                  const Gap(8),
                  CustomText(
                    text: text,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
        
              if (showTrailingIcon)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: AppColors.purple500,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
