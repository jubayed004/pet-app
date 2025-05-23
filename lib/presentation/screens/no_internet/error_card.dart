/*
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/widget/custom_text/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
                CustomText(text: "something_went_wrong", fontWeight: FontWeight.w600, fontSize: 24.sp),
                const Gap(12),
                CustomText(text: "the_application_has_encountered_an_unknown_error",maxLines: 2,),
                CustomText(text: "please_try_again_later"),
              ],
            ),
            const Gap(24),
            CustomButton(title: "try_again",onTap: onTap),
          ],
        ),
      ),
    );
  }
}
*/
