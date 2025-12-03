import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/category/model/category_item_model.dart';
import 'package:pet_app/presentation/screens/explore/model/map_category_details_model.dart';
import 'package:pet_app/presentation/screens/explore/widgets/category_card_map.dart';
import 'package:pet_app/presentation/screens/explore/widgets/explore_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late GoogleMapController mapController;
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
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

  void _animateToShowAllMarkers() {
    if (exploreController.markers.isNotEmpty) {
      final cameraPosition = exploreController.getCameraPosition();
      mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.38;

    return Scaffold(
      body: Stack(
        children: [
          // Full screen Google Map
          Obx(() {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: _center, zoom: 14),
              markers: exploreController.getMarkers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              mapToolbarEnabled: true,
              zoomControlsEnabled: true,
            );
          }),

          // Bottom Sheet Overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(

              height: bottomSheetHeight,
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
                  ///========================== Service Category selection ==================
                  SizedBox(
                    height:screenHeight/8,
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
                                      exploreController.startLocationSharing(type: category.type);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
                                      elevation: 3,
                                      child: CircleAvatar(
                                        backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
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
                              return _errorWidget('Internet connection error', Icons.wifi_off, index);

                            case Status.noDataFound:
                              return _errorWidget('No services found in this area', Icons.location_off, index);

                            case Status.error:
                              return _errorWidget('An error occurred', Icons.error, index);

                            case Status.completed:
                              final services = exploreController.mapDetailsCategory.value.services ?? [];

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
                                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
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
                                    child: ExploreCatCard(items: services, itemIndex: index),
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
              exploreController.startLocationSharing(type: currentCategory.type);
            },
            child: Text('Retry', style: TextStyle(fontSize: 12.sp)),
          ),
        ],
      ),
    );
  }
}

