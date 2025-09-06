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
import 'package:pet_app/utils/app_const/padding_constant.dart';

class BusinessAdvertisementScreen extends StatelessWidget {
  BusinessAdvertisementScreen({super.key});

  final controller = GetControllers.instance
      .getBusinessAdvertisementController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.addAdvertisement();
        },
        child: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(
              title: "Advertisement",
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            controller.pickImage();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.black),
                              CustomText(
                                text: "Add promotional",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ],
                          ),),
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                            AppRouter.route.pushNamed(RoutePath.businessDetailsAdvertisementScreen);
                          }, child: CustomText(
                            text: "All Advertisement", fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,)),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    /// =======================Image List View
                    Obx(() =>
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.selectedImages.value.length,
                          itemBuilder: (context, imageIndex) {
                            final image = controller.selectedImages
                                .value[imageIndex];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(image?.path ?? ""),
                                      width: double.infinity,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.deleteImage(imageIndex),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        )),
                    Obx(() {
                      return CustomButton(
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            controller.addAdvertisement();
                          }, title: "Save"
                      );
                    }),
                    Gap(26),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

