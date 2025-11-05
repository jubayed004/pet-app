

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.onTap, this.text});
  final VoidCallback onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(24),
            text != null?CustomText(text: text??"", fontWeight: FontWeight.w600, fontSize: 16.sp):
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(text: "something went wrong", fontWeight: FontWeight.w600, fontSize: 24.sp),
                const Gap(12),
                CustomText(text: "the application has encountered an unknown error",maxLines: 2,),
                CustomText(text: "please try again later"),
              ],
            ),
            const Gap(24),
        /*    CustomButton(title: "Try Again",onTap: onTap),*/
          ],
        ),
      ),
    );
  }
}
