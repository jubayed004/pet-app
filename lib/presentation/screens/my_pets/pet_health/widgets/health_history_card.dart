import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/presentation/screens/my_pets/pet_health/controller/pet_health_controller.dart';
import 'package:pet_app/presentation/screens/my_pets/pet_health/model/pet_health_model.dart';

class HealthHistoryCard extends StatelessWidget {
  final HealthHistoryItem item;
  final PetHealthController controller;

  const HealthHistoryCard({
    super.key,
    required this.controller,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final treatmentName = item.treatmentName ?? "Unknown Treatment";
    final doctorName = item.doctorName ?? "Unknown Doctor";
    final treatmentType = item.treatmentType ?? "N/A";
    final treatmentStatus = item.treatmentStatus ?? "Pending";
    final treatmentDescription = item.treatmentDescription ?? "No description available.";
    final treatmentDate = DateFormat("dd MMMM yyyy").format(item.treatmentDate ?? DateTime.now());

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            treatmentName,
            style: TextStyle(
              color: Colors.green,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(4.h),
          Text(
            treatmentType,
            style: TextStyle(
              color: Colors.green,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(4.h),
          Text(
            doctorName,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
          Gap(4.h),
          Text(
            treatmentDate,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
          Gap(8.h),
          Text(
            "Treatment Description",
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          Gap(6.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.green.withOpacity(0.4)),
            ),
            child: Text(
              treatmentDescription,
              style: TextStyle(
                fontSize: 12.5.sp,
                color: Colors.black87,
              ),
            ),
          ),
          Gap(10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: treatmentStatus == "Completed" ? Colors.green.shade700 : Colors.orange,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                treatmentStatus,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
