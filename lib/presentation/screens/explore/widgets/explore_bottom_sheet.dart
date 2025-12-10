import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_loader/custom_loader.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/category/model/category_item_model.dart';
import 'package:pet_app/presentation/screens/explore/controller/explore_controller.dart';
import 'package:pet_app/presentation/screens/explore/widgets/explore_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class ExploreBottomSheet extends StatefulWidget {
  final ExploreController exploreController;
  final VoidCallback onShowAll;

  const ExploreBottomSheet({
    super.key,
    required this.exploreController,
    required this.onShowAll,
  });

  @override
  State<ExploreBottomSheet> createState() => _ExploreBottomSheetState();
}

class _ExploreBottomSheetState extends State<ExploreBottomSheet> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  final List<CategoryItem> categories = [
    CategoryItem(
      icon: Assets.icons.petvets.svg(),
      title: AppStrings.petVets,
      type: "VET",
    ),
    CategoryItem(
      icon: Assets.icons.petshops.svg(),
      title: AppStrings.petShops,
      type: "SHOP",
    ),
    CategoryItem(
      icon: Assets.icons.petgrooming.svg(),
      title: AppStrings.petGrooming,
      type: "GROOMING",
    ),
    CategoryItem(
      icon: Assets.icons.pethotel.svg(),
      title: AppStrings.petHotels,
      type: "HOTEL",
    ),
    CategoryItem(
      icon: Assets.icons.pettraining.svg(),
      title: AppStrings.petTraining,
      type: "TRAINING",
    ),
    CategoryItem(
      icon: Assets.icons.friendlyplace.svg(),
      title: AppStrings.friendlyPlace,
      type: "FRIENDLY",
    ),
  ];

  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.45, // Slightly increased height for better view
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10.r,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          ///========================== Handle Bar ==================
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          ///========================== Service Category selection ==================
          SizedBox(
            height: screenHeight / 8, // Keep explicit height as in original
            child: ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (_, currentIndex, __) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = currentIndex == index;
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectedIndex.value = index;
                              widget.exploreController.startLocationSharing(
                                type: category.type,
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              elevation: 3,
                              child: CircleAvatar(
                                backgroundColor:
                                    isSelected
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                radius: 35.r,
                                child: category.icon,
                              ),
                            ),
                          ),
                          Gap(4.h),
                          SizedBox(
                            child: CustomText(
                              text: category.title,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Gap(8.h),

          ///============================Services List Section ======================
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (_, index, __) {
                return Obx(() {
                  switch (widget.exploreController.loading.value) {
                    case Status.loading:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomLoader(),
                            SizedBox(height: 8.h),
                            Text(
                              'Loading locations...',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      );

                    case Status.internetError:
                      return _errorWidget(
                        'Internet connection error',
                        Icons.wifi_off,
                        index,
                      );

                    case Status.noDataFound:
                      return _errorWidget(
                        'No services found in this area',
                        Icons.location_off,
                        index,
                      );

                    case Status.error:
                      return _errorWidget(
                        'An error occurred',
                        Icons.error,
                        index,
                      );

                    case Status.completed:
                      final allServices =
                          widget
                              .exploreController
                              .mapDetailsCategory
                              .value
                              .services ??
                          [];

                      // Filter for 10km radius
                      final services =
                          allServices
                              .where((s) => (s.distanceKm ?? 999) <= 10.0)
                              .toList();

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${services.length} services found within 10km',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (services.isNotEmpty)
                                  GestureDetector(
                                    onTap: widget.onShowAll,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.center_focus_strong,
                                            color: Colors.white,
                                            size: 14.sp,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'Show All',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Gap(8.h),
                          Expanded(
                            child:
                                services.isEmpty
                                    ? Center(
                                      child: Text(
                                        "No services found within 10km",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                    : ExploreCatCard(
                                      items: services,
                                      itemIndex: index,
                                    ),
                          ),
                        ],
                      );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorWidget(String message, IconData icon, int index) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48.sp, color: Colors.red),
          SizedBox(height: 8.h),
          Text(message, style: TextStyle(fontSize: 14.sp)),
          SizedBox(height: 8.h),
          ElevatedButton(
            onPressed: () {
              final currentCategory = categories[selectedIndex.value];
              widget.exploreController.startLocationSharing(
                type: currentCategory.type,
              );
            },
            child: Text('Retry', style: TextStyle(fontSize: 12.sp)),
          ),
        ],
      ),
    );
  }
}
