import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/no_internet/more_data_error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_app/presentation/widget/loading/loading_widget.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class OnboardingSection extends StatelessWidget {
  const OnboardingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetControllers.instance.getBusinessAllPetController();

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Obx(() {
          final pets = controller.profile.value.pets ?? [];
          final status = controller.loading.value;

          switch (status) {
            case Status.loading:
              return Center(child:LoadingWidget(color: Colors.pink,) );
            case Status.error:
              return Center(
                  child: ErrorCard(
                    onTap: () => controller.getBusinessAllPets(),
                  ));
            case Status.internetError:
              return Center(
                  child: NoInternetCard(
                    onTap: () => controller.getBusinessAllPets(),
                  ));
            case Status.noDataFound:
              return Center(
                  child: MoreDataErrorCard(
                    onTap: () => controller.getBusinessAllPets(),
                  ));
            case Status.completed:
              if (pets.isEmpty) {
                return Center(
                    child: NoDataCard(
                      onTap: () => controller.getBusinessAllPets(),
                    ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "All Booking Pets",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(12.h),
                  CarouselSlider.builder(
                    itemCount: pets.length,
                    itemBuilder: (context, index, realIndex) {
                      final pet = pets[index];
                      final image = pet.petPhoto ?? "";
                      final imageUrl = image.isNotEmpty
                          ? image
                          : "assets/images/default_pet_image.png";

                      return Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6.r,
                              offset: Offset(0, 3.r),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: pet.name ?? "Unknown",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  if (pet.name != null) ...[
                                    Gap(4.h),
                                    CustomText(
                                      text: pet.name!,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CustomNetworkImage(
                                imageUrl: imageUrl,
                                width: 50.w,
                                height: 50.h,
                                fit: BoxFit.cover,
                              )
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 120.h,
                      autoPlay: pets.length > 1,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: pets.length > 1,
                      viewportFraction: 0.85,
                      scrollPhysics: pets.length > 1
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        controller.currentIndex.value = index % pets.length;
                      },
                    ),
                  ),
                  if (pets.length > 1) ...[
                    Gap(12.h),
                    Obx(() {
                      final active = controller.currentIndex.value;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            pets.length,
                                (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin:
                              const EdgeInsets.symmetric(horizontal: 4),
                              height: 8.h,
                              width: i == active ? 24.w : 8.w,
                              decoration: BoxDecoration(
                                color: i == active
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.r),
                                border: i == active
                                    ? Border.all(
                                    color: AppColors.primaryColor
                                        .withOpacity(0.6),
                                    width: 0.5)
                                    : null,
                              ),
                            )),
                      );
                    }),
                  ],
                ],
              );
          }
        }),
      ),
    );
  }
}
