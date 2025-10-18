import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class BusinessAdvertisementScreen extends StatelessWidget {
  BusinessAdvertisementScreen({super.key});

  final controller = GetControllers.instance.getBusinessAdvertisementController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getDetailsAdvertisement();
        },
        child: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(title: "Advertisement"),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Modern Header Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.purple500, AppColors.purple500.withOpacity(0.8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.purple500.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.campaign, color: Colors.white, size: 24.sp),
                              Gap(8.w),
                              CustomText(
                                text: "Manage Promotions",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Gap(8.h),
                          CustomText(
                            text: "Create and manage your business advertisements",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ],
                      ),
                    ),
                    Gap(20.h),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => controller.pickImage(),
                            icon: Icon(Icons.add_photo_alternate, size: 20.sp),
                            label: CustomText(
                              text: "Add Images",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.purple500,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              elevation: 2,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                side: BorderSide(color: AppColors.purple500.withOpacity(0.3)),
                              ),
                            ),
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              AppRouter.route.pushNamed(RoutePath.businessDetailsAdvertisementScreen);
                            },
                            icon: Icon(Icons.list_alt, size: 20.sp),
                            label: CustomText(
                              text: "View All",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.purple500,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              elevation: 2,
                              shadowColor: AppColors.purple500.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(24.h),

                    // Selected Images Section
                    Obx(() {
                      if (controller.selectedImages.isEmpty) {
                        return Container(
                          padding: EdgeInsets.all(32.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: Colors.grey[300]!, width: 2),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 64.sp,
                                color: Colors.grey[400],
                              ),
                              Gap(16.h),
                              CustomText(
                                text: "No images selected",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600]!,
                              ),
                              Gap(8.h),
                              CustomText(
                                text: "Tap 'Add Images' to select up to 5 promotional images",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[500]!,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Selected Images",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800]!,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: AppColors.purple500.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: CustomText(
                                  text: "${controller.selectedImages.length}/5",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.purple500,
                                ),
                              ),
                            ],
                          ),
                          Gap(12.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.selectedImages.length,
                            itemBuilder: (context, index) {
                              final image = controller.selectedImages[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16.r),
                                        child: Image.file(
                                          File(image.path),
                                          width: double.infinity,
                                          height: 200.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Gradient Overlay
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.r),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.3),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Delete Button
                                      Positioned(
                                        top: 12.h,
                                        right: 12.w,
                                        child: GestureDetector(
                                          onTap: () => controller.deleteImage(index),
                                          child: Container(
                                            padding: EdgeInsets.all(8.w),
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade500,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red.withOpacity(0.4),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Colors.white,
                                              size: 20.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Image Number Badge
                                      Positioned(
                                        top: 12.h,
                                        left: 12.w,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.6),
                                            borderRadius: BorderRadius.circular(20.r),
                                          ),
                                          child: CustomText(
                                            text: "Image ${index + 1}",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }),

                    // Save Button
                    Obx(() {
                      if (controller.selectedImages.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        children: [
                          Gap(8.h),
                          CustomButton(
                            isLoading: controller.isLoading.value,
                            onTap: () => controller.addAdvertisement(),
                            title: "Publish Advertisements",
                          ),
                        ],
                      );
                    }),
                    Gap(32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}