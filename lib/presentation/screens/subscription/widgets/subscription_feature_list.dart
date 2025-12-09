import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionFeatureList extends StatelessWidget {
  const SubscriptionFeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {'icon': Icons.check_circle, 'text': 'Unlimited access to all features'},
      {'icon': Icons.block, 'text': 'Ad-free experience'},
      {'icon': Icons.headset_mic, 'text': 'Priority customer support'},
      {'icon': Icons.update, 'text': 'Regular updates and new features'},
    ];

    return Column(
      children:
          features.map((feature) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      feature['icon'] as IconData,
                      color: Colors.green.shade600,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      feature['text'] as String,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
