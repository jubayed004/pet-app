import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/widgets/active_promotion_section.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/widgets/brand_section.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/widgets/business_categories_section.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/widgets/onboarding_section.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/widgets/review_section.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
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
  final businessAdvertisementController = GetControllers.instance.getBusinessAdvertisementController();
  final businessReviewController = GetControllers.instance.getBusinessReviewController();

  @override
  void initState() {
    super.initState();
    businessHomeBrandController.getBusinessHomeBrand();
    businessAdvertisementController.getDetailsAdvertisement();
    businessAllPetController.getBusinessAllPets();

    businessReviewController.pagingController.addPageRequestListener((pageKey) {
      businessReviewController.getReviews(page: pageKey);
    });

    // fetch first page immediately
    businessReviewController.getReviews(page: 1); // <-- important
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

          businessReviewController.pagingController.refresh();
          businessReviewController.getReviews(page: 1);
        },
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            const OnboardingSection(),
            const BusinessCategoriesSection(),
            const BrandSection(),
            const ActivePromotionSection(),
            ReviewSection(),
          ],
        ),
      )

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

}
