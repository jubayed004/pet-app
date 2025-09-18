import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/category/model/category_item_model.dart';
import 'package:pet_app/presentation/screens/explore/model/map_category_details_model.dart';
import 'package:pet_app/presentation/screens/explore/widgets/category_card_map.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late GoogleMapController mapController;
  late final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final categoryController = GetControllers.instance.getCategoryController();
  final exploreController = GetControllers.instance.getExploreController();

  static const LatLng _center = LatLng(23.804693584341365, 90.41590889596907);

  final List<CategoryItem> categories = [
    CategoryItem(icon: Assets.icons.petvets.svg(), title: AppStrings.petVets, type: "VET"),
    CategoryItem(icon: Assets.icons.petshops.svg(), title: AppStrings.petShops, type: "SHOP"),
    CategoryItem(icon: Assets.icons.petgrooming.svg(), title: AppStrings.petGrooming, type: "GROOMING"),
    CategoryItem(icon: Assets.icons.pethotel.svg(), title: AppStrings.petHotels, type: "HOTEL"),
    CategoryItem(icon: Assets.icons.pettraining.svg(), title: AppStrings.petTraining, type: "TRAINING"),
    CategoryItem(icon: Assets.icons.friendlyplace.svg(), title: AppStrings.friendlyPlace, type: "FRIENDLY"),
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    exploreController.startLocationSharing(type: "VET");
  }

  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }

  // Method to animate camera to show all markers
  void _animateToShowAllMarkers() {
    if (exploreController.markers.isNotEmpty) {
      final cameraPosition = exploreController.getCameraPosition();
      mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.38; // More responsive height calculation

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  return GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(target: _center, zoom: 14),
                    markers: exploreController.getMarkers, // Use controller markers
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    mapToolbarEnabled: true,
                    zoomControlsEnabled: true,
                    onCameraMove: (CameraPosition position) {
                      // Optional: Handle camera movements
                    },
                  );
                }),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: bottomSheetHeight,
              padding: EdgeInsets.all(12.r), // Responsive padding
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
                  // Category selection row with responsive sizing
                  SizedBox(
                    height: 120.h, // Responsive height
                    child: ValueListenableBuilder<int>(
                      valueListenable: selectedIndex,
                      builder: (_, currentIndex, __) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          padding: EdgeInsets.only(left: 16.w, right: 10.w), // Responsive padding
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected = currentIndex == index;
                            return Padding(
                              padding: EdgeInsets.only(right: 10.w), // Responsive margin
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      selectedIndex.value = index;
                                      exploreController.startLocationSharing(type: category.type);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
                                      elevation: 3,
                                      child: CircleAvatar(
                                        backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
                                        radius: 35.r, // Responsive radius
                                        child: category.icon,
                                      ),
                                    ),
                                  ),
                                  Gap(4.h), // Responsive gap
                                  SizedBox(
                                    width: 70.w, // Fixed width to prevent overflow
                                    child: CustomText(
                                      text: category.title,
                                      fontSize: 14.sp, // Responsive font size
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

                  Gap(8.h), // Responsive gap

                  // Services list section
                  Expanded(
                    child: ValueListenableBuilder<int>(
                      valueListenable: selectedIndex,
                      builder: (_, index, __) {
                        return Obx(() {
                          switch (exploreController.loading.value) {
                            case Status.loading:
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 8.h),
                                    Text('Loading locations...', style: TextStyle(fontSize: 14.sp)),
                                  ],
                                ),
                              );

                            case Status.internetError:
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.wifi_off, size: 48.sp, color: Colors.red),
                                    SizedBox(height: 8.h),
                                    Text('Internet connection error', style: TextStyle(fontSize: 14.sp)),
                                    SizedBox(height: 8.h),
                                    ElevatedButton(
                                      onPressed: () {
                                        final currentCategory = categories[selectedIndex.value];
                                        exploreController.startLocationSharing(type: currentCategory.type);
                                      },
                                      child: Text('Retry', style: TextStyle(fontSize: 12.sp)),
                                    ),
                                  ],
                                ),
                              );

                            case Status.noDataFound:
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_off, size: 48.sp, color: Colors.grey),
                                    SizedBox(height: 8.h),
                                    Text('No services found in this area', style: TextStyle(fontSize: 14.sp)),
                                  ],
                                ),
                              );

                            case Status.error:
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error, size: 48.sp, color: Colors.red),
                                    SizedBox(height: 8.h),
                                    Text('An error occurred', style: TextStyle(fontSize: 14.sp)),
                                    SizedBox(height: 8.h),
                                    ElevatedButton(
                                      onPressed: () {
                                        final currentCategory = categories[selectedIndex.value];
                                        exploreController.startLocationSharing(type: currentCategory.type);
                                      },
                                      child: Text('Retry', style: TextStyle(fontSize: 12.sp)),
                                    ),
                                  ],
                                ),
                              );

                            case Status.completed:
                              final services = exploreController.mapDetailsCategory.value.services ?? [];

                              // Auto-animate to show all markers when data is loaded
                              if (services.isNotEmpty && exploreController.markers.isNotEmpty) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  _animateToShowAllMarkers();
                                });
                              }

                              return Column(
                                children: [

                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${services.length} services found',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (services.isNotEmpty)
                                          GestureDetector(
                                            onTap: _animateToShowAllMarkers,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius: BorderRadius.circular(20.r),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.center_focus_strong, color: Colors.white, size: 14.sp),
                                                  SizedBox(width: 4.w),
                                                  Text('Show All', style: TextStyle(color: Colors.white, fontSize: 11.sp)),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Gap(8.h),

                                  Expanded(
                                    child: ExploreCatCard(items: services, itemIndex: index,),
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
            ),
          ),
        ],
      ),
    );
  }
}

class ExploreCatCard extends StatelessWidget {
  const ExploreCatCard({super.key, required this.items, required this.itemIndex});
  final int itemIndex;
  final List<MapCategoryService> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets, size: 48.sp, color: Colors.grey),
            SizedBox(height: 8.h),
            Text(
              'No services available in this category',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 12.w), // Responsive padding
          child: CategoryCard(
            item: items[index],
            index: index,
            showWebsite: itemIndex == 1 || itemIndex ==3,
            isShop: itemIndex ==1? false: true,
          ),
        );
      },
    );
  }
}