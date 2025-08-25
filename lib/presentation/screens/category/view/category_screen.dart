import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/category/model/category_item_model.dart';
import 'package:pet_app/presentation/screens/category/widgets/category_card_widget.dart';
import 'package:pet_app/presentation/screens/category/widgets/grooming_widget.dart';
import 'package:pet_app/presentation/screens/category/widgets/hotel_widget.dart';
import 'package:pet_app/presentation/screens/category/widgets/vet_widget.dart';
import 'package:pet_app/presentation/screens/category/widgets/place_widget.dart';
import 'package:pet_app/presentation/screens/category/widgets/shop_widget.dart';
import 'package:pet_app/presentation/screens/category/widgets/training_widget.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import '../model/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categoryController = GetControllers.instance.getCategoryController();
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
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
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Category"),
        ),
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [

            /// Category Header (Horizontal List)
            SizedBox(
              height: 130,
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
                                if (index == 5) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return Container(
                                        padding: padding16,
                                        width: double.infinity,
                                        height: MediaQuery.of(context).size.height / 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            CustomText(text: 'Standard Boarding', fontSize: 14, fontWeight: FontWeight.w500),
                                            CustomText(text: 'Luxury Suites', fontSize: 14, fontWeight: FontWeight.w500),
                                            CustomText(text: 'Daycare', fontSize: 14, fontWeight: FontWeight.w500),
                                            CustomText(text: 'Specialized Care', fontSize: 14, fontWeight: FontWeight.w500),
                                            CustomText(text: 'Extras', fontSize: 14, fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 3,
                                child: CircleAvatar(
                                  backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
                                  radius: 40,
                                  child: category.icon,
                                ),
                              ),
                            ),
                            const Gap(4),
                            CustomText(
                              text: category.title,
                              fontSize: 16,
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

            /// PagedSliverList - changes with category
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: selectedIndex,
                builder: (_, index, __) {
                  return IndexedStack(
                    index: index,
                    children: [
                      VetWidget(
                        controller: categoryController,
                        index: index,
                      ),
                      ShopWidget(
                        controller: categoryController,
                        index: index,
                      ),
                      GroomingWidget(
                        controller: categoryController,
                        index: index,
                      ),
                      HotelWidget(
                        controller: categoryController,
                        index: index,
                      ),
                      TrainingWidget(
                        controller: categoryController,
                        index: index,
                      ),
                      PlaceWidget(
                        controller: categoryController,
                        index: index,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
