import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
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
  const BusinessHomeScreen({super.key});

  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();
  final businessProfileController = GetControllers.instance.getBusinessProfileController();
  final businessHomeBrandController = GetControllers.instance.getBusinessHomeController();
  final businessAdvertisementController= GetControllers.instance.getBusinessAdvertisementController();

  @override
  void initState() {
    businessHomeBrandController.getBusinessHomeBrand();
    businessAdvertisementController.getDetailsAdvertisement();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> iconList = [
      Assets.icons.petvets.svg(),
      Assets.icons.petshops.svg(),
      Assets.icons.petgrooming.svg(),
      Assets.icons.pethotel.svg(),
      Assets.icons.pettraining.svg(),
      Assets.icons.friendlyplace.svg(),
    ];
    final List<String> stringList = [
      AppStrings.petVets,
      AppStrings.petShops,
      AppStrings.petGrooming,
      AppStrings.petHotels,
      AppStrings.petTraining,
      AppStrings.friendlyPlace,
    ];

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          businessAllPetController.getBusinessAllPets();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: AppColors.appBackgroundColor,
              elevation: 0,
              toolbarHeight: 56,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                centerTitle: false,
                title: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    final images = businessProfileController.profile.value.ownerDetails?.business?.shopPic;
                                    if (images != null && images.isNotEmpty) {
                                      final imageUrl = images[0].replaceAll('\\', '/'); // Ensure proper URL format
                                      return CustomNetworkImage(
                                        imageUrl: imageUrl,
                                        width: 50.w,
                                        height: 50.h,
                                        fit: BoxFit.cover,
                                        boxShape: BoxShape.circle,
                                      );
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

                              CustomText(text: 'Welcome To Pet Shops', fontSize: 14, fontWeight: FontWeight.w600),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              AppRouter.route.pushNamed(RoutePath.notifyScreen);
                            },
                            icon: Icon(Iconsax.notification_bing),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildOnboardingSection(),
            SliverGap(8),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: CustomText(text: " Your All Business ", textAlign: TextAlign.start, fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ),
            SliverGap(8),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 130.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  padding: EdgeInsets.only(left: 16, right: 10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              /*   //homeController.selectedIndex.value = index;
                              AppRouter.route.pushNamed(RoutePath.categoryScreen);*/
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              elevation: 3,
                              child: CircleAvatar(
                                backgroundColor: /* isSelected ? AppColors.primaryColor :*/ Colors.white,
                                radius: 40,
                                child: iconList[index],
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          CustomText(text: stringList[index], fontSize: 16, fontWeight: FontWeight.w400),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverGap(16),
            _buildBrandSection(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: AppStrings.activePromotions, fontWeight: FontWeight.w400, fontSize: 18),
                    TextButton(
                      onPressed: () {
                        AppRouter.route.pushNamed(RoutePath.businessDetailsAdvertisementScreen);
                      },
                      child: CustomText(text: AppStrings.seeAll, fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            _buildActivePromotion(),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    ///===============reviewScreen===========
                     GestureDetector(
                        onTap: (){
                          AppRouter.route.pushNamed(RoutePath.businessReviewScreen);
                        },
                        child: Card(
                          color: Colors.white,
                          child: Container(
                            padding: padding12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(text: "Rating & Reviews",fontWeight: FontWeight.w800,fontSize: 18,),
                                       Row(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           ...List.generate(5, (index){
                                             return Icon(Icons.star,color: AppColors.purple500,);
                                           })
                                         ],
                                       )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(text: "4.5",fontSize: 24,fontWeight: FontWeight.w700,),
                                        CustomText(text: "234 Ratings",fontSize: 10,fontWeight: FontWeight.w500,),

                                      ],
                                    )
                                  ],
                                ),
                                 Gap(12),
                                 Divider(height: 2,color: Color(0xffCFCFCF),),
                                Gap(12),
                                CustomText(text: "View Customer Reviews",fontWeight: FontWeight.w600,fontSize: 14,color: AppColors.purple500,decoration: TextDecoration.underline,decorationColor: AppColors.purple500,)
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),

            SliverGap(24),
          ],
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
          final item = businessAllPetController.profile.value.pets ?? [];
          final status = businessAllPetController.loading.value; // Rx<Status>
          switch (status) {
            case Status.loading:
              return Center(child: CircularProgressIndicator());

            case Status.error:
              return Center(
                child: ErrorCard(
                  onTap: () {
                    businessAllPetController.getBusinessAllPets(); // Reload
                  },
                ),
              );

            case Status.internetError:
              return Center(
                child: NoInternetCard(
                  onTap: () {
                    businessAllPetController.getBusinessAllPets();
                  },
                ),
              );

            case Status.noDataFound:
              return Center(
                child: MoreDataErrorCard(
                  onTap: () {
                    businessAllPetController.getBusinessAllPets();
                  },
                ),
              );

            case Status.completed:
              if (item.isEmpty) {
                return Center(
                  child: NoDataCard(
                    onTap: () {
                      businessAllPetController.getBusinessAllPets();
                    },
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("All Booking Pets", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  const Gap(16),

                  // Carousel
                  CarouselSlider.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index, realIndex) {
                      final petName = item[index];
                      final image = petName.petPhoto ?? "";
                      final imageUrl = image.isEmpty ? "assets/images/default_pet_image.png" : image;

                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8.r, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(text: petName.name ?? "Unknown", fontWeight: FontWeight.w600, fontSize: 16.sp, color: Colors.white),
                                  if (petName.name != null) ...[
                                    SizedBox(height: 4.h),
                                    CustomText(
                                      text: petName.name!,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      color: Colors.white.withValues(alpha: 0.8),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            CustomNetworkImage(
                              imageUrl: imageUrl,
                              height: 50.h,
                              width: 50.w, // Make it square for circular image
                              boxShape: BoxShape.circle,
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 8,
                      autoPlay: item.length > 1,
                      // Only auto-play if multiple items
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: item.length > 1,
                      // Only infinite scroll if multiple items
                      viewportFraction: 0.85,
                      scrollPhysics: item.length > 1 ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        // 🔥 FIX: Use modulo to handle infinite scroll properly
                        businessAllPetController.currentIndex.value = index % item.length;
                      },
                    ),
                  ),

                  // Dots indicator (only show if multiple items)
                  if (item.length > 1) ...[
                    const Gap(12),
                    Obx(() {
                      final activeIdx = businessAllPetController.currentIndex.value;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(item.length, (index) => buildDot(index, active: index == activeIdx)),
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
      height: 8,
      width: active ? 24 : 8,
      decoration: BoxDecoration(
        color: active ? AppColors.primaryColor : AppColors.primaryColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: active ? Border.all(color: AppColors.primaryColor.withValues(alpha: 0.6), width: 0.5) : null,
      ),
    );
  }
  /// -------------------- Brand Section --------------------
  SliverToBoxAdapter _buildBrandSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
        child: Obx(() {
          final item = businessHomeBrandController.brand.value.topBrands ?? [];
          final status = businessHomeBrandController.loading.value;

          switch (status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            case Status.error:
              return Center(
                child: ErrorCard(
                  onTap: () => businessHomeBrandController.getBusinessHomeBrand(),
                ),
              );

            case Status.internetError:
              return Center(
                child: NoInternetCard(
                  onTap: () => businessHomeBrandController.getBusinessHomeBrand(),
                ),
              );

            case Status.noDataFound:
              return Center(
                child: MoreDataErrorCard(
                  onTap: () => businessHomeBrandController.getBusinessHomeBrand(),
                ),
              );

            case Status.completed:
              if (item.isEmpty) {
                return Center(
                  child: NoDataCard(
                    onTap: () => businessHomeBrandController.getBusinessHomeBrand(),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All Booking Pets",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  CarouselSlider.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index, realIndex) {
                      final brand = item[index];
                      final logoList = brand.logo;
                      final imageUrl = (logoList != null && logoList.isNotEmpty)
                          ? logoList.first
                          : "assets/images/default_pet_image.png";

                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8.r,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: CustomNetworkImage(
                          imageUrl: imageUrl,
                          height: 80.h,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 6,
                      autoPlay: item.length > 1,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: item.length > 1,
                      viewportFraction: 0.98,
                      scrollPhysics: item.length > 1
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        businessAllPetController.currentIndex.value =
                            index % item.length;
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
  SliverToBoxAdapter _buildActivePromotion() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Obx(() {
          final allAds = businessAdvertisementController.profile.value.advertisement ?? [];

          final activeAds = allAds.where((ad) => ad.status == "ACTIVE").toList(); // ✅ FIXED

          final status = businessAdvertisementController.loading.value;

          switch (status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            case Status.error:
              return Center(
                child: ErrorCard(
                  onTap: () => businessAdvertisementController.getDetailsAdvertisement(),
                ),
              );

            case Status.internetError:
              return Center(
                child: NoInternetCard(
                  onTap: () => businessAdvertisementController.getDetailsAdvertisement(),
                ),
              );

            case Status.noDataFound:
              return Center(
                child: MoreDataErrorCard(
                  onTap: () => businessAdvertisementController.getDetailsAdvertisement(),
                ),
              );

            case Status.completed:
              if (activeAds.isEmpty) {
                return Center(
                  child: NoDataCard(
                    onTap: () => businessAdvertisementController.getDetailsAdvertisement(),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: activeAds.length,
                    itemBuilder: (context, index, realIndex) {
                      final ad = activeAds[index];
                      final imgList = ad.advertisementImg ?? [];
                      final imageUrl = imgList.isNotEmpty
                          ? imgList.first
                          : "assets/images/default_promotion_image.png";

                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8.r,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: CustomNetworkImage(
                          imageUrl: imageUrl,
                          height: 80.h,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 6,
                      autoPlay: activeAds.length > 1,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: activeAds.length > 1,
                      viewportFraction: 0.98,
                      scrollPhysics: activeAds.length > 1
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        businessAllPetController.currentIndex.value = index % activeAds.length;
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




}
