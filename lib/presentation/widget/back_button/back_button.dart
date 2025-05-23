import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;

  final Icon icon;

  const CustomBackButton({
    Key? key,
    required this.onTap,
    this.backgroundColor = Colors.green,
    this.borderColor = Colors.black,
    this.borderRadius = 50.0,
// Default height
    this.icon = const Icon(Icons.arrow_back_ios_new_rounded,size: 18,),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.1),  // Adjust opacity for background color
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius),  // Circular border
          ),
          child: icon
        ),
      ),
    );
  }
}
