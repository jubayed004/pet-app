import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_loader/custom_loader.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/no_internet/more_data_error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_app/presentation/widget/custom_loader/custom_loader.dart';
import 'package:pet_app/presentation/widget/loading/loading_widget.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetControllers.instance.getBusinessHomeController();

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Top Brands",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            Obx(() {
              final brands = controller.brand.value.topBrands ?? [];
              final status = controller.loading.value;

              switch (status) {
                case Status.loading:
                  return  Center(child: CustomLoader());
                case Status.error:
                  return Center(
                      child: ErrorCard(onTap: () => controller.getBusinessHomeBrand()));
                case Status.internetError:
                  return Center(
                      child: NoInternetCard(onTap: () => controller.getBusinessHomeBrand()));
                case Status.noDataFound:
                  return Center(
                      child: MoreDataErrorCard(
                          onTap: () => controller.getBusinessHomeBrand()));
                case Status.completed:
                  if (brands.isEmpty) {
                    return Center(
                        child: NoDataCard(
                            onTap: () => controller.getBusinessHomeBrand()));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        itemCount: brands.length,
                        itemBuilder: (context, index, realIndex) {
                          final brand = brands[index];
                          final logos = brand.logo;
                          final imageUrl = (logos != null && logos.isNotEmpty)
                              ? logos.first
                              : "assets/images/default_pet_image.png";

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: CustomNetworkImage(
                              imageUrl:  imageUrl,
                              height: 80.h,
                              width: double.infinity,

                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 140.h,
                          autoPlay: brands.length > 1,
                          autoPlayInterval: const Duration(seconds: 3),
                          enlargeCenterPage: true,
                          enableInfiniteScroll: brands.length > 1,
                          viewportFraction: 0.9,
                          scrollPhysics: brands.length > 1
                              ? const BouncingScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          onPageChanged: (index, reason) {
                            controller.currentIndex.value = index % brands.length;
                          },
                        ),
                      ),
                    ],
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}
