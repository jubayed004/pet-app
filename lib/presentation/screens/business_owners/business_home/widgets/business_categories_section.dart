import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';

class BusinessCategoriesSection extends StatelessWidget {
  const BusinessCategoriesSection({super.key});

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
    final List<String> labelList = [
      "Pet Vets",
      "Pet Shops",
      "Pet Grooming",
      "Pet Hotels",
      "Pet Training",
      "Friendly Place",
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
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r)),
                  elevation: 3,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.r,
                    child: iconList[index],
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
}
