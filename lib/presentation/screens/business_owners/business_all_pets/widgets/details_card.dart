import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class DetailsCard extends StatelessWidget {
  final String age;
  final String date;

  const DetailsCard({super.key, required this.age, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFd2ead1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: age, fontWeight: FontWeight.w400, fontSize: 14),
            CustomText(
              text: date,
              color: const Color(0xFF064E57),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}