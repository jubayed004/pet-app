
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/no_internet/more_data_error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class ActivePromotionSection extends StatelessWidget {
  const ActivePromotionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetControllers.instance.getBusinessAdvertisementController();

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Obx(() {
          final ads = controller.profile.value.advertisement ?? [];
          final activeAds = ads.where((ad) => ad.status == "ACTIVE").toList();
          final status = controller.loading.value;
          switch (status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(
                  child: ErrorCard(
                    onTap: () => controller.getDetailsAdvertisement(),
                  ));
            case Status.internetError:
              return Center(
                  child: NoInternetCard(
                    onTap: () => controller.getDetailsAdvertisement(),
                  ));
            case Status.noDataFound:
              return Center(
                  child: MoreDataErrorCard(
                    onTap: () => controller.getDetailsAdvertisement(),
                  ));
            case Status.completed:
              if (activeAds.isEmpty) {
                return Center(
                    child: NoDataCard(
                      onTap: () => controller.getDetailsAdvertisement(),
                    ));
              }
              return CarouselSlider.builder(
                itemCount: activeAds.length,
                itemBuilder: (context, index, realIndex) {
                  final ad = activeAds[index];
                  final imgs = ad.advertisementImg ?? [];
                  final imageUrl = imgs.isNotEmpty
                      ? imgs.first
                      : "assets/images/default_promotion_image.png";
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      imageUrl,
                      height: 100.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 120.h,
                  autoPlay: activeAds.length > 1,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  enableInfiniteScroll: activeAds.length > 1,
                  viewportFraction: 0.9,
                  scrollPhysics: activeAds.length > 1
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                ),
              );
          }
        }),
      ),
    );
  }
}
