import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/category/model/category_item_model.dart';
import 'package:pet_app/presentation/screens/explore/widgets/category_card_map.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

late GoogleMapController mapController;

const LatLng _center = LatLng(23.804693584341365, 90.41590889596907);

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  final categoryController = GetControllers.instance.getCategoryController();
  final List<CategoryItem> categories = [
    CategoryItem(icon: Assets.icons.petvets.svg(), title: AppStrings.petVets, type: "VET"),
    CategoryItem(icon: Assets.icons.petshops.svg(), title: AppStrings.petShops, type: "SHOP"),
    CategoryItem(icon: Assets.icons.petgrooming.svg(), title: AppStrings.petGrooming, type: "GROOMING"),
    CategoryItem(icon: Assets.icons.pethotel.svg(), title: AppStrings.petHotels, type: "HOTEL"),
    CategoryItem(icon: Assets.icons.pettraining.svg(), title: AppStrings.petTraining, type: "TRAINING"),
    CategoryItem(icon: Assets.icons.friendlyplace.svg(), title: AppStrings.friendlyPlace, type: "FRIENDLY"),
  ];

  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 14,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 4 + 50,
              padding: const EdgeInsets.all(8),
              color: Colors.green.shade50,
              child: Column(
                children: [
                  // Horizontal scrolling for category selection
                  SizedBox(
                    height: 130.h, // Adjusted height for category icons
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
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      elevation: 3,
                                      child: CircleAvatar(
                                        backgroundColor: isSelected
                                            ? AppColors.primaryColor
                                            : Colors.white,
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
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Horizontal scrolling for category-specific content
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child: ValueListenableBuilder<int>(
                      valueListenable: selectedIndex,
                      builder: (_, index, __) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: _getCategoryContent(index),
                        );
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

  // Custom method to return content for each category
  List<Widget> _getCategoryContent(int index) {
    switch (index) {
      case 0:
        return [
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 1', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Food, Accessories, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 2', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Toys, Beds, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
        ];
      case 1:
        return [
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 1', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Food, Accessories, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 2', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Toys, Beds, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
        ];
      case 2:
        return [
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 1', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Food, Accessories, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 2', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Toys, Beds, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
        ];
      case 3:
        return [
          CategoryCard(),
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 2', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Toys, Beds, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
        ];
      case 4:
        return [
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 1', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Food, Accessories, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 2', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Toys, Beds, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
        ];
      case 5:
        return [
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 1', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Food, Accessories, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 2', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Toys, Beds, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
        ];
      case 6:
        return [
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 1', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Food, Accessories, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            width: 120.w,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Pet Shop 2', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text('Toys, Beds, etc.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
        ];

      default:
        return [];
    }
  }
}
