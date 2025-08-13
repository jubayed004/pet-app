import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

Future<void> defaultDeletedYesNoDialog({
  required BuildContext context,
  required VoidCallback onYes,
  required String title
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogCtx) =>
        AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title:  Text(title),
          content: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            borderRadius: 8.r,
                            onTap: onYes,
                            title: "Yes",
                            borderColor: AppColors.kPrimaryDarkColor,
                            textColor: AppColors.kPrimaryDarkColor,

                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            borderRadius: 8.r,
                            onTap: () => Navigator.of(dialogCtx).pop(),
                            title: "No",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
  );
}
