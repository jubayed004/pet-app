
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';


void showCustomAnimatedDialog({
  required BuildContext context,
  bool isDismissible = true,
  String? title,
  String? subtitle,
  Widget? contentWidget, // <-- New optional widget (TextField, etc.)
  List<Widget>? actionButton,
  String? animationSrc, // Dynamically change the animation source
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: isDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) {
      return Center(
        child: Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 8,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 300,
              minWidth: 200,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (animationSrc != null && animationSrc.isNotEmpty)
                    CustomImage(
                      imageSrc: animationSrc,
                      width: 100.w,
                      height: 100.h,
                      boxFit: BoxFit.contain,
                    ),
                  if (title != null) ...[
                     SizedBox(height: 10.h),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (subtitle != null) ...[
                     SizedBox(height: 10.h),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff475569),
                      ),
                    ),
                  ],
                  if (contentWidget != null) ...[
                     SizedBox(height: 12.h),
                    contentWidget,
                  ],
                   SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: actionButton?.map((button) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: button,
                        ),
                      );
                    }).toList() ??
                        [],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      );
    },
  );
}
