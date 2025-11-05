import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/screens/explore/model/map_category_details_model.dart';
import 'package:pet_app/presentation/screens/explore/widgets/category_card_map.dart';

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
          padding: EdgeInsets.only(right: 12.w),
          child: CategoryCard(
            item: items[index],
            index: index,
            showWebsite: itemIndex == 1 || itemIndex == 3,
            isShop: itemIndex == 1 ? false : true,
          ),
        );
      },
    );
  }
}