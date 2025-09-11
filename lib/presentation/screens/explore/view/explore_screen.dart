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
              height: MediaQuery.of(context).size.height / 3,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Category selection row
                  SizedBox(
                    height: 130.h,
                    child: ValueListenableBuilder<int>(
                      valueListenable: selectedIndex,
                      builder: (_, currentIndex, __) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          padding: const EdgeInsets.only(left: 16, right: 10),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected = currentIndex == index;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      selectedIndex.value = index;
                                      exploreController.startLocationSharing(type: category.type);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                      elevation: 3,
                                      child: CircleAvatar(
                                        backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
                                        radius: 40.r,
                                        child: category.icon,
                                      ),
                                    ),
                                  ),
                                  const Gap(4),
                                  CustomText(
                                    text: category.title,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Services list section
                  Expanded(
                    child: ValueListenableBuilder<int>(
                      valueListenable: selectedIndex,
                      builder: (_, index, __) {
                        return Obx(() {
                          switch (exploreController.loading.value) {
                            case Status.loading:
                              return  Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 8.h),
                                    Text('Loading locations...'),
                                  ],
                                ),
                              );

                            case Status.internetError:
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.wifi_off, size: 48, color: Colors.red),
                                    const SizedBox(height: 8),
                                    const Text('Internet connection error'),
                                    ElevatedButton(
                                      onPressed: () {
                                        final currentCategory = categories[selectedIndex.value];
                                        exploreController.startLocationSharing(type: currentCategory.type);
                                      },
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              );

                            case Status.noDataFound:
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_off, size: 48, color: Colors.grey),
                                    SizedBox(height: 8),
                                    Text('No services found in this area'),
                                  ],
                                ),
                              );

                            case Status.error:
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.error, size: 48, color: Colors.red),
                                    const SizedBox(height: 8),
                                    const Text('An error occurred'),
                                    ElevatedButton(
                                      onPressed: () {
                                        final currentCategory = categories[selectedIndex.value];
                                        exploreController.startLocationSharing(type: currentCategory.type);
                                      },
                                      child: const Text('Retry'),
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
                                  // Header with markers count
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${services.length} services found',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (services.isNotEmpty)
                                          GestureDetector(
                                            onTap: _animateToShowAllMarkers,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.center_focus_strong, color: Colors.white, size: 16),
                                                  SizedBox(width: 4),
                                                  Text('Show All', style: TextStyle(color: Colors.white, fontSize: 12)),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),

                                  // Services horizontal list
                                  Expanded(
                                    child: ExploreCatCard(items: services),
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
  const ExploreCatCard({super.key, required this.items});

  final List<MapCategoryService> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'No services available in this category',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CategoryCard(item: items[index]),
        );
      },
    );
  }
}