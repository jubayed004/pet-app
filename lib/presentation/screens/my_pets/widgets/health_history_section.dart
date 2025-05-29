import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class HealthHistorySection extends StatelessWidget {
  final String text;
  final String subText;

  const HealthHistorySection({
    super.key, required this.text, required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 4,
          backgroundColor: Colors.black,
        ),
        Gap(12),
        CustomText(text: text,fontWeight: FontWeight.w600,fontSize: 13,),
        Gap(
            8
        ),
        Flexible(child: CustomText(text: subText,fontWeight: FontWeight.w600,fontSize: 13,)),
      ],
    );
  }
}