import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/no_internet/more_data_error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:shimmer/shimmer.dart';

class BusinessHomeScreen extends StatefulWidget {
  const BusinessHomeScreen({Key? key}) : super(key: key);

  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();
  final businessProfileController = GetControllers.instance.getBusinessProfileController();
  final businessHomeBrandController = GetControllers.instance.getBusinessHomeController();
  final businessAdvertisementController = GetControllers.instance.getBusinessAdvertisementController();

  @override
  void initState() {
    super.initState();
    businessHomeBrandController.getBusinessHomeBrand();
    businessAdvertisementController.getDetailsAdvertisement();
    businessAllPetController.getBusinessAllPets();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure ScreenUtil is initialized higher up (e.g. in main)
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await businessAllPetController.getBusinessAllPets();
          await businessHomeBrandController.getBusinessHomeBrand();
          await businessAdvertisementController.getDetailsAdvertisement();
        },
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(child: const Gap(8)),
            _buildOnboardingSection(),
            SliverToBoxAdapter(child: const Gap(8)),
            _buildBusinessCategories(),
            SliverToBoxAdapter(child: const Gap(16)),
            _buildBrandSection(),
            SliverToBoxAdapter(child: const Gap(16)),
            _buildActivePromotionHeader(),
            _buildActivePromotion(),
            SliverToBoxAdapter(child: const Gap(16)),
            _buildReviewSection(),
            SliverToBoxAdapter(child: const Gap(24)),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: AppColors.appBackgroundColor,
      elevation: 0,
      toolbarHeight: 56.h,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Obx(() {
                    final images = businessProfileController.profile.value
                        .ownerDetails
                        ?.business
                        ?.shopPic;
                    if (images != null && images.isNotEmpty) {
                      final imageUrl = images[0].replaceAll('\\', '/');
                      return ClipOval(
                        child: CustomNetworkImage(
                          imageUrl: imageUrl,
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Shimmer.fromColors(
                        baseColor: AppColors.blackColor.withAlpha(50),
                        highlightColor: AppColors.blackColor.withAlpha(100),
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    }
                  }),
                  SizedBox(width: 12.w),
                  CustomText(
                    text: 'Welcome To Pet Shops',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      AppRouter.route.pushNamed(RoutePath.notifyScreen);
                    },
                    icon: const Icon(Iconsax.notification_bing),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildBusinessCategories() {
    final List<Widget> iconList = [
      Assets.icons.petvets.svg(),
      Assets.icons.petshops.svg(),
      Assets.icons.petgrooming.svg(),
      Assets.icons.pethotel.svg(),
      Assets.icons.pettraining.svg(),
      Assets.icons.friendlyplace.svg(),
    ];
    final List<String> labelList = [
      AppStrings.petVets,
      AppStrings.petShops,
      AppStrings.petGrooming,
      AppStrings.petHotels,
      AppStrings.petTraining,
      AppStrings.friendlyPlace,
    ];

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110.h,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          scrollDirection: Axis.horizontal,
          itemCount: iconList.length,
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: navigate to respective category
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r)),
                    elevation: 3,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.r,
                      child: iconList[index],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: labelList[index],
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildOnboardingSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Obx(() {
          final pets = businessAllPetController.profile.value.pets ?? [];
          final status = businessAllPetController.loading.value;

          switch (status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(
                  child: ErrorCard(
                    onTap: () => businessAllPetController.getBusinessAllPets(),
                  ));
            case Status.internetError:
              return Center(
                  child: NoInternetCard(
                    onTap: () => businessAllPetController.getBusinessAllPets(),
                  ));
            case Status.noDataFound:
              return Center(
                  child: MoreDataErrorCard(
                    onTap: () => businessAllPetController.getBusinessAllPets(),
                  ));
            case Status.completed:
              if (pets.isEmpty) {
                return Center(
                    child: NoDataCard(
                      onTap: () => businessAllPetController.getBusinessAllPets(),
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
                      final imageUrl =
                      image.isNotEmpty ? image : "assets/images/default_pet_image.png";

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
                            CustomNetworkImage(
                              imageUrl: imageUrl,
                              width: 50.w,
                              height: 50.h,
                              boxShape: BoxShape.circle,
                              fit: BoxFit.cover,
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
                        businessAllPetController.currentIndex.value = index % pets.length;
                      },
                    ),
                  ),
                  if (pets.length > 1) ...[
                    Gap(12.h),
                    Obx(() {
                      final active = businessAllPetController.currentIndex.value;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(pets.length,
                                (i) => _buildDot(i, active: i == active)),
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

  Widget _buildDot(int index, {required bool active}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8.h,
      width: active ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: active
            ? AppColors.primaryColor
            : AppColors.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: active
            ? Border.all(
            color: AppColors.primaryColor.withOpacity(0.6), width: 0.5)
            : null,
      ),
    );
  }

  SliverToBoxAdapter _buildBrandSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Obx(() {
          final brands = businessHomeBrandController.brand.value.topBrands ?? [];
          final status = businessHomeBrandController.loading.value;

          switch (status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(
                  child: ErrorCard(
                    onTap: () => businessHomeBrandController.getBusinessHomeBrand(),
                  ));
            case Status.internetError:
              return Center(
                  child: NoInternetCard(
                    onTap: () => businessHomeBrandController.getBusinessHomeBrand(),
                  ));
            case Status.noDataFound:
              return Center(
                  child: MoreDataErrorCard(
                    onTap: () => businessHomeBrandController.getBusinessHomeBrand(),
                  ));
            case Status.completed:
              if (brands.isEmpty) {
                return Center(
                    child: NoDataCard(
                      onTap: () => businessHomeBrandController.getBusinessHomeBrand(),
                    ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Top Brands",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(12.h),
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
                          imageUrl: imageUrl,
                          height: 80.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 100.h,
                      autoPlay: brands.length > 1,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: brands.length > 1,
                      viewportFraction: 0.9,
                      scrollPhysics: brands.length > 1
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        businessHomeBrandController.currentIndex.value =
                            index % brands.length;
                      },
                    ),
                  ),
                ],
              );
          }
        }),
      ),
    );
  }

  SliverToBoxAdapter _buildActivePromotionHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: AppStrings.activePromotions,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
            TextButton(
              onPressed: () {
                AppRouter.route.pushNamed(RoutePath.businessDetailsAdvertisementScreen);
              },
              child: CustomText(
                text: AppStrings.seeAll,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildActivePromotion() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Obx(() {
          final ads = businessAdvertisementController.profile.value.advertisement ?? [];
          final activeAds = ads.where((ad) => ad.status == "ACTIVE").toList();
          final status = businessAdvertisementController.loading.value;

          switch (status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(
                  child: ErrorCard(
                    onTap: () => businessAdvertisementController.getDetailsAdvertisement(),
                  ));
            case Status.internetError:
              return Center(
                  child: NoInternetCard(
                    onTap: () => businessAdvertisementController.getDetailsAdvertisement(),
                  ));
            case Status.noDataFound:
              return Center(
                  child: MoreDataErrorCard(
                    onTap: () => businessAdvertisementController.getDetailsAdvertisement(),
                  ));
            case Status.completed:
              if (activeAds.isEmpty) {
                return Center(
                    child: NoDataCard(
                      onTap: () => businessAdvertisementController.getDetailsAdvertisement(),
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
                    child: CustomNetworkImage(
                      imageUrl: imageUrl,
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
                  onPageChanged: (index, reason) {
                    businessAllPetController.currentIndex.value =
                        index % activeAds.length;
                  },
                ),
              );
          }
        }),
      ),
    );
  }

  SliverToBoxAdapter _buildReviewSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GestureDetector(
          onTap: () {
            AppRouter.route.pushNamed(RoutePath.businessReviewScreen);
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: padding12, // from your constants
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Rating & Reviews",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          Gap(8.h),
                          Row(
                            children: List.generate(
                              5,
                                  (i) => const Icon(
                                Icons.star,
                                color: AppColors.purple500,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            text: "4.5",
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          CustomText(
                            text: "234 Ratings",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(12.h),
                  Divider(color: const Color(0xffCFCFCF)),
                  Gap(12.h),
                  Center(
                    child: CustomText(
                      text: "View Customer Reviews",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.purple500,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.purple500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
