import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/core/route/routes.dart';
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
    return showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.black54,
          child: Center(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Obx(() {
                final loading = isLoading?.value ?? false;

                if (loading) {
                  return SizedBox(
                    height: 120.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      maxLines: 2,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),

                    SizedBox(height: 20.h),

                    SizedBox(
                      height: 45.h,
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
                              onTap: () => AppRouter.route.pop(),
                              title: "No",
                              textColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
