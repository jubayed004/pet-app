
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

import '../components/custom_button/custom_button.dart';

class NoInternetCard extends StatelessWidget {
  const NoInternetCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(20),
            CustomText(text: "no internet connection", color: AppColors.blackColor, maxLines: 3,fontSize: 14,fontWeight: FontWeight.w600,),
            const Gap(20),
           /* CustomButton(title: "Try again",onTap: onTap),*/
          ],
        ),
      ),
    );
  }
}
