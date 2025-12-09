import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/screens/subscription/controller/subscription_controller.dart';

class ActiveSubscriptionView extends StatelessWidget {
  final SubscriptionController controller;

  const ActiveSubscriptionView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => AppRouter.route.pop(RoutePath.subscriptionScreen),
        ),
        centerTitle: true,
        title: Text(
          'My Subscription',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_circle_rounded,
                size: 60.sp,
                color: Colors.green.shade600,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Premium Active',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(() {
              return Text(
                controller.getDaysRemaining(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
            SizedBox(height: 48.h),
            Obx(() {
              final entitlement = controller.activeEntitlement;
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      'Plan',
                      entitlement?.productIdentifier ?? 'Unknown',
                      Icons.card_membership,
                    ),
                    Divider(height: 32.h, color: Colors.grey.shade100),
                    _buildDetailRow(
                      'Started',
                      controller.getFormattedDate(
                        entitlement?.originalPurchaseDate,
                      ),
                      Icons.calendar_today,
                    ),
                    Divider(height: 32.h, color: Colors.grey.shade100),
                    _buildDetailRow(
                      'Renews',
                      controller.getFormattedDate(entitlement?.expirationDate),
                      Icons.autorenew,
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: OutlinedButton(
                onPressed: () => controller.launchManageSubscriptions(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue.shade600),
                  foregroundColor: Colors.blue.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Manage Subscription',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Manage your subscription in App Store or Play Store settings',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 20.sp, color: Colors.grey.shade700),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
