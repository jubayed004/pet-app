
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class MoreDataErrorCard extends StatelessWidget {
  const MoreDataErrorCard({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()=>onTap(),
        child: Column(
          children: [
            CustomText(text: "something went wrong tap to try again", maxLines: 3, fontWeight: FontWeight.w600, fontSize: 12.sp),
            const Gap(5),
            /*const Icon(Icons.refresh),*/
          ],
        ),
      ),
    );
  }
}
