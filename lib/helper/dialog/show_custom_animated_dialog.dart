
import 'package:flutter/material.dart';
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
    barrierColor: Colors.black.withOpacity(0.5),
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
                      width: 100,
                      height: 100,
                      boxFit: BoxFit.contain,
                    ),
                  if (title != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (subtitle != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff475569),
                      ),
                    ),
                  ],
                  if (contentWidget != null) ...[
                    const SizedBox(height: 12),
                    contentWidget,
                  ],
                  const SizedBox(height: 24),
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
