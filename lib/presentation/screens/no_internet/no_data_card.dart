import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class NoDataCard extends StatelessWidget {
  const NoDataCard({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Gap(24),
          CustomText(text: "no items found", fontWeight: FontWeight.w600, fontSize: 22.sp),
          const Gap(12),
          CustomText(text: "the list is currently empty",maxLines: 2,),
          const Gap(24),
          CustomButton(title: "try again",onTap: onTap),
        ],
      ),
    );
  }
}
