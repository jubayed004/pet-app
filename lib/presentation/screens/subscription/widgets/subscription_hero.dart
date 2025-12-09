import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionHero extends StatelessWidget {
  const SubscriptionHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.workspace_premium,
            size: 50.sp,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Unlock Premium',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'Get unlimited access to all features\nand remove ads.',
          style: TextStyle(fontSize: 16.sp, color: Colors.black54, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
