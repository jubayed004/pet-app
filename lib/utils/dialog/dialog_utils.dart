import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
class DialogUtils {
  static Future<void> showYesNoDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onYes,
    RxBool? isLoading, // optional loading observable
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.whiteColor,
        title: CustomText(
          text: title,
          maxLines: 2,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        content: Obx(() {
          final loading = isLoading?.value ?? false;

          if (loading) {
            return const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return SizedBox(
            height: 100.h,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 45.h,
                    borderRadius: 8.r,
                    onTap: onYes,
                    title: "Yes",
                    fillColor: Colors.white,
                    borderColor: Colors.black,
                    isBorder: true,
                    textColor: AppColors.blackColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    height: 45.h,
                    borderRadius: 8.r,
                    onTap: () => Navigator.of(dialogCtx).pop(),
                    title: "No",
                    textColor: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
