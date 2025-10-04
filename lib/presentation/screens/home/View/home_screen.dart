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
import 'package:pet_app/presentation/no_internet/more_data_error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myAppointmentController.getSingleAppointmentBooking();
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
            homeController.getAllAdvertisement();
            myAppointmentController.getSingleAppointmentBooking();
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
                      height: 50.h,
                      width: 50.w,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Obx(() {
                        final imageFile = homeController.homeHeader.value.data?.userPic;

                        if (imageFile != null) {
                          return CustomNetworkImage(imageUrl: imageFile, boxShape: BoxShape.circle);
                        } else {
                          return CustomNetworkImage(
                              imageUrl: "https://images.unsplash.com/photo-1548767797-d8c844163c4c?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            height: 50.h,
                            width: 50.w,
                            boxShape: BoxShape.circle,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Obx(() {
          final status = homeController.loading.value; // Rx<Status>
          final item = homeController.homeHeader.value.data?.petList ?? [];

          switch (status) {
            case Status.loading:
              return Center(child: CircularProgressIndicator());

            case Status.error:
              return Center(
                child: ErrorCard(
                  onTap: () {
                    homeController.userHomeHeader(); // Reload
                  },
                ),
              );

            case Status.internetError:
              return Center(
                child: NoInternetCard(
                  onTap: () {
                    homeController.userHomeHeader();
                  },
                ),
              );

            case Status.noDataFound:
              return Center(
                child: MoreDataErrorCard(
                  onTap: () {
                    homeController.userHomeHeader();
                  },
                ),
              );

            case Status.completed:
              if (item.isEmpty) {
                return Center(
                  child: NoDataCard(
                    onTap: () {
                      homeController.userHomeHeader();
                    },
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.activePetProfiles,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),

                  // Carousel
                  CarouselSlider.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index, realIndex) {
                      final pet = item[index];
                      final image = pet.petPhoto ?? "";
                      final imageUrl = image.isEmpty
                          ? "assets/images/default_pet_image.png"
                          : image;

                      return Container(
                        padding: const EdgeInsets.all(16),
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
                                    text: pet.name ?? "Unknown",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                  if (pet.name != null) ...[
                                    const SizedBox(height: 4),
                                    CustomText(
                                      text: pet.name!,
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
                              width: 50,
                              boxShape: BoxShape.circle,
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 8,
                      autoPlay: item.length > 1,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: item.length > 1,
                      viewportFraction: 0.85,
                      scrollPhysics: item.length > 1
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        homeController.currentIndex.value = index % item.length;
                      },
                    ),
                  ),

                  // Dots indicator
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
          }
        }),
      ),
    );
  }


// Updated buildDot method with active parameter
  Widget buildDot(int index, {bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8.h,
      width: active ? 24 : 8,
      decoration: BoxDecoration(
        color: active
            ? AppColors.primaryColor
            : AppColors.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: active
            ? Border.all(
          color: AppColors.primaryColor.withOpacity(0.6),
          width: 0.5.w,
        )
            : null,
      ),
    );
  }

  /// -------------------- Advertisement Section --------------------
  SliverToBoxAdapter _buildAdvertisementSection(HomeController homeController) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Obx(() {
          if (homeController.isRunning.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final adsPic = homeController.adsPic;
          if (adsPic.isEmpty) {
            return Center(
              child: NoDataCard(
                onTap: () => homeController.getAllAdvertisement(),
              ),
            );
          }
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: adsPic.length,
                itemBuilder: (context, index, realIndex) {
                  final imgUrl = adsPic[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image),
                          );
                        },
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 6,
                  enlargeCenterPage: true,
                  autoPlay: adsPic.length > 1,
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    homeController.currentIndex.value = index;
                  },
                ),
              ),
               SizedBox(height: 10.h),
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
      height: 6.h,
      width: active ? 22 : 8,
      decoration: BoxDecoration(
        color: active
            ? Colors.white.withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white.withValues(alpha:  active ? 0.6 : 0.35),
        ),
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

  /// -------------------- Appointment SeeAll --------------------
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
          final status = myAppointmentController.singleAppointmentBookingLoading.value; // Rx<Status>
          final item = myAppointmentController.firstBooking.value;

          switch (status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            case Status.error:
              return Center(
                child: ErrorCard(
                  onTap: () => myAppointmentController.getSingleAppointmentBooking(),
                ),
              );

            case Status.internetError:
              return Center(
                child: NoInternetCard(
                  onTap: () => myAppointmentController.getSingleAppointmentBooking(),
                ),
              );

            case Status.noDataFound:
              return Center(
                child: NoDataCard(
                  onTap: () => myAppointmentController.getSingleAppointmentBooking(),
                ),
              );

            case Status.completed:
              if (item == null) {
                return  Center(
                  child: CustomText(
                    text: "No Appointment Found",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }

              final bookingDate = item.bookingDate != null
                  ? DateFormat("dd MMMM yyyy").format(item.bookingDate!)
                  : "";

              return MyAppointmentContainer(
                id: item.id ?? "",
                petLogo: Assets.images.vet.image(width: 24.w),
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
          }
        }),
      ),
    );
  }

}
