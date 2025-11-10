import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/widgets/tab_button.dart';

class TopTabs extends StatelessWidget {
  const TopTabs({super.key, required this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: const Color(0xFFecfaf3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Obx(() {
        final sel = controller.selectedTabIndex.value;
        return Row(
          children: [
            TabButton(
              label: 'PENDING',
              isActive: sel == 0,
              onTap: () => controller.selectTab(0),
            ),
            TabButton(
              label: 'Ongoing',
              isActive: sel == 1,
              onTap: () => controller.selectTab(1),
            ),
            TabButton(
              label: 'Completed',
              isActive: sel == 2,
              onTap: () => controller.selectTab(2),
            ),
            TabButton(
              label: 'Rejected',
              isActive: sel == 3,
              onTap: () => controller.selectTab(3),
            ),
          ],
        );
      }),
    );
  }
}