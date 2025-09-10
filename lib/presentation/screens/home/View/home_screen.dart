import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
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
  final controller = GetControllers.instance.getProfileController();
  final _controller = GetControllers.instance.getOnboardingController();
  final navController = GetControllers.instance.getNavigationControllerMain();
  final myAppointmentController = GetControllers.instance.getMyAppointmentController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myAppointmentController.pagingController1.refresh();
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
          },
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              _buildOnboardingSection(),
              const SliverGap(8),
              _buildFindWhatYouNeedTitle(),
              const SliverGap(8),
              SliverToBoxAdapter(child: CategoryList(controller: homeController)),
              _buildAdsSection(), // Ads Section
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: badges.Badge(
                      onTap: () => AppRouter.route.pushNamed(RoutePath.notifyScreen),
                      badgeContent: const Text('3', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: AppColors.purple500,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        borderRadius: BorderRadius.circular(50),
                        elevation: 2,
                      ),
                      position: badges.BadgePosition.topStart(start: 10, top: -20),
                      child: const Icon(CupertinoIcons.bell, size: 24, color: AppColors.purple500),
                    ),
                  ),
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
  }

  /// -------------------- Dots Indicator --------------------
  Widget buildDot(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Obx(() {
        return Container(
          height: 6,
          width: homeController.currentIndex.value == index ? 24 : 6, // Use the correct controller
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: homeController.currentIndex.value == index ? AppColors.primaryColor : AppColors.lightGray,
          ),
        );
      }),
    );
  }

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
  }

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
              defaultDeletedYesNoDialog(
                context: context,
                title: "Cancel Appointment Confirmation",
                onYes: () => myAppointmentController.deletedBookingAppointment(id: item.id ?? ""),
              );
            },
          );
        }),
      ),
    );
  }
}
