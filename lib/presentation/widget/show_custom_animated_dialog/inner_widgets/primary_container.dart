import 'package:flutter/material.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  const PrimaryContainer({
    super.key,
    this.radius,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF8F9F9),
        borderRadius: BorderRadius.circular(radius ?? 30),
        border: Border.all(color: AppColors.secondTextColor,width: 1)
      ),
      child: child,
    );
  }
}
