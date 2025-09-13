import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/custom_tab_bar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
import 'package:pet_app/presentation/screens/home/controller/home_controller.dart';
import 'package:pet_app/presentation/screens/home/widget/category_iist_widget.dart';
import 'package:pet_app/presentation/screens/home/widget/top_brands_carousel_widget.dart';
import 'package:pet_app/presentation/screens/my_appointment/widgets/my_appointment_container.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/app_images/app_images.dart' show AppImages;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = GetControllers.instance.getHomeController();
  final navController = GetControllers.instance.getNavigationControllerMain();
  final myAppointmentController = GetControllers.instance.getMyAppointmentController();

  @override
  void initState() {
    super.initState();
    homeController.userHomeHeader();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      myAppointmentController.pagingController1.refresh();

      homeController.pagingController.addPageRequestListener((pageKey) {
        homeController.getAllAdvertisement(pageKey: pageKey);
      });


    });

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: RefreshIndicator(
          onRefresh: ()async{
            homeController.userHomeHeader();

            homeController.pagingController.refresh();
          },
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              _buildOnboardingSection(),
              const SliverGap(8),
              _buildFindWhatYouNeedTitle(),
              const SliverGap(8),
              SliverToBoxAdapter(child: CategoryList(controller: homeController)),
             /* _buildAdsSection(), */// Ads Section'
              _buildAdvertisementSection(homeController),
              _buildAppointmentsHeader(),
              _buildAppointmentsSection(),
              const SliverGap(16),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [CustomText(text: AppStrings.topBrands, fontWeight: FontWeight.w400, fontSize: 18), TopBrandsCarousel()],
                  ),
                ),
              ),
              const SliverGap(24),
            ],
          ),
        ),
      ),
    );
  }

  /// -------------------- AppBar --------------------
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: AppColors.appBackgroundColor,
      elevation: 0,
      toolbarHeight: 56,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.only(left: 16, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Obx(() {
                        final imageFile = homeController.homeHeader.value.data?.userPic;

                        if (imageFile != null) {
                          return CustomNetworkImage(imageUrl: "${ApiUrl.imageBase}$imageFile", boxShape: BoxShape.circle);
                        } else {
                          return Shimmer.fromColors(
                            baseColor: AppColors.blackColor.withAlpha(50),
                            highlightColor: AppColors.blackColor.withAlpha(100),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => AppRouter.route.pushNamed(RoutePath.searchScreen),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.kWhiteColor,
                          border: Border.all(color: AppColors.purple500),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(child: CustomText(textAlign: TextAlign.start, text: AppStrings.searchForServices)),
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){ AppRouter.route.pushNamed(RoutePath.notifyScreen);}, icon: Icon(Iconsax.notification_bing)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// -------------------- Onboarding Section --------------------
  SliverToBoxAdapter _buildOnboardingSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
        child: Obx(() {
          final item = homeController.homeHeader.value.data?.petList ?? [];

          // If no pets, don't show the section
          if (item.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.activePetProfiles,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),

              // Carousel
              CarouselSlider.builder(
                itemCount: item.length,
                itemBuilder: (context, index, realIndex) {
                  final petName = item[index];
                  final image = petName.petPhoto ?? "";
                  final imageUrl = image.isEmpty
                      ? "assets/images/default_pet_image.png"
                      : "${ApiUrl.imageBase}$image";

                  return Container(

                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: petName.name ?? "Unknown",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                              if (petName.name != null) ...[
                                const SizedBox(height: 4),
                                CustomText(
                                  text: petName.name!,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        CustomNetworkImage(
                          imageUrl: imageUrl,
                          height: 50,
                          width: 50, // Make it square for circular image
                          boxShape: BoxShape.circle,
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 8,
                  autoPlay: item.length > 1, // Only auto-play if multiple items
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  enableInfiniteScroll: item.length > 1, // Only infinite scroll if multiple items
                  viewportFraction: 0.85,
                  scrollPhysics: item.length > 1
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  onPageChanged: (index, reason) {
                    // 🔥 FIX: Use modulo to handle infinite scroll properly
                    homeController.currentIndex.value = index % item.length;
                  },
                ),
              ),

              // Dots indicator (only show if multiple items)
              if (item.length > 1) ...[
                const Gap(12),
                Obx(() {
                  final activeIdx = homeController.currentIndex.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      item.length,
                          (index) => buildDot(index, active: index == activeIdx),
                    ),
                  );
                }),
              ],
            ],
          );
        }),
      ),
    );
  }

// Updated buildDot method with active parameter
  Widget buildDot(int index, {bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 24 : 8,
      decoration: BoxDecoration(
        color: active
            ? AppColors.primaryColor
            : AppColors.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: active
            ? Border.all(
          color: AppColors.primaryColor.withOpacity(0.6),
          width: 0.5,
        )
            : null,
      ),
    );
  }

  /// -------------------- Onboarding (Ads) Section - All Images --------------------
  SliverToBoxAdapter _buildAdvertisementSection(HomeController homeController) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Obx(() {
          final adsPic = homeController.adsPic;

          if (adsPic.isEmpty) {
            return const SizedBox(height: 120); // loader / empty state
          }

          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: adsPic.length,
                itemBuilder: (context, adIndex, realIndex) {
                  final adImages = adsPic[adIndex]
                      .map((e) => "${ApiUrl.imageBase}${e.replaceAll('\\', '/')}")
                      .toList();

                  return PageView.builder(
                    itemCount: adImages.length,
                    itemBuilder: (context, imgIdx) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            adImages[imgIdx],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      );
                    },
                  );
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 8,
                  enlargeCenterPage: true,
                  autoPlay: adsPic.length > 1,
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    homeController.currentIndex.value = index;
                  },
                ),
              ),

              // Dots indicator
              const SizedBox(height: 10),
              Obx(() {
                final activeIdx = homeController.currentIndex.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    adsPic.length,
                        (i) => buildDot1(i, active: i == activeIdx),
                  ),
                );
              }),
            ],
          );
        }),
      ),
    );
  }

  Widget buildDot1(int index, {bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 22 : 8,
      decoration: BoxDecoration(
        color: active
            ? Colors.white.withOpacity(0.95)
            : Colors.white.withOpacity(0.45),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white.withOpacity(active ? 0.6 : 0.35),
        ),
      ),
    );
  }


/*
  /// -------------------- Ads Section --------------------
  SliverToBoxAdapter _buildAdsSection() {
    final List<String> ads = [
      "assets/images/adshome.png",
      "assets/images/adshome.png",
      "assets/images/adshome.png",
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          final item = homeController.homeHeader.value.data?.petList ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.activePetProfiles, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Gap(16),
              item.isNotEmpty
                  ? CarouselSlider.builder(
                itemCount: item.length,
                itemBuilder: (context, index, realIndex) {
                  final petName = item[index];
                  final image = petName.petPhoto ?? "";
                  final imageUrl = image.isEmpty ? "assets/images/default_pet_image.png" : "${ApiUrl.imageBase}$image";
                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: petName.name ?? "Unknown", fontWeight: FontWeight.w600, fontSize: 16.sp),
                        CustomNetworkImage(imageUrl: imageUrl, height: 50, width: 100, boxShape: BoxShape.circle),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 8,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index, reason) {
                    homeController.currentIndex.value = index; // Update the index here
                  },
                ),
              )
                  : SizedBox(),
              const Gap(10),
              // Dots indicator based on currentIndex
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(item.length, (index) => buildDot(index)),
              ),
            ],
          );
        }),
      ),
    );
  }*/

  /// -------------------- Find What You Need --------------------
  SliverToBoxAdapter _buildFindWhatYouNeedTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: CustomText(text: AppStrings.findWhatYouNeed, textAlign: TextAlign.start, fontWeight: FontWeight.w400, fontSize: 18.sp),
      ),
    );
  }

  /// -------------------- Appointment Header --------------------
  SliverToBoxAdapter _buildAppointmentsHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: AppStrings.upcomingAppointments, fontWeight: FontWeight.w400, fontSize: 18.sp),
            TextButton(
              onPressed: () => AppRouter.route.pushNamed(RoutePath.myAppointmentScreen),
              child: CustomText(text: AppStrings.seeAll, fontWeight: FontWeight.w400, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }

  /// -------------------- Appointment Section --------------------
  SliverToBoxAdapter _buildAppointmentsSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          final item = myAppointmentController.appointmentBookingDetails.value.booking;
          if (item == null) {
            return const Center(child: CustomText(text: "No Appointment Found", fontSize: 16, fontWeight: FontWeight.w400));
          }
          final bookingDate = DateFormat("dd MMMM yyyy").format(item.bookingDate ?? DateTime.now());
          return MyAppointmentContainer(
            id: item.id ?? "",
            petLogo: Assets.images.vet.image(width: 24),
            serviceType: item.serviceId?.serviceType ?? "",
            shopLogo: item.serviceId?.shopLogo ?? "",
            serviceImage: item.serviceId?.servicesImages ?? "",
            bookingDate: bookingDate,
            bookingTime: item.bookingTime ?? "",
            bookingStatus: item.bookingStatus ?? "",
            selectedService: item.selectedService ?? "",
            address: item.serviceId?.location ?? "",
            phone: item.serviceId?.phone ?? "",
            deletedOnTab: () {
              defaultDeletedYesNoCencelDialog(
                context: context,
                title: 'Are you sure you want to Cancel this Appointment?',
                id: item.id ?? "",
                controller: myAppointmentController,
              );
            },
          );
        }),
      ),
    );
  }
}
