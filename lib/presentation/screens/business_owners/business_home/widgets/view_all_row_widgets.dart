import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/custom_text_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
class ViewAllRow extends StatelessWidget {
  final String title;
  final String? buttonText;
  final Color? titleColor;
  final Function() onPressed;
  const ViewAllRow({
    super.key,
    required this.title,
    required this.onPressed,
    this.buttonText, this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            text: title,
            color:titleColor?? AppColors.kPrimaryLightDarkColor,
            fontSize:14,
           fontWeight: FontWeight.w600,
          ),
        ),
        CustomTextButton(
            onPressed: onPressed,
            title: buttonText ?? " Sell All",
            textColor: AppColors.kSeeAllColor
        ),
      ],
    );
  }
}
