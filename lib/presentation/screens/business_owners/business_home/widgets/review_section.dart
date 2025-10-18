import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class ReviewSection extends StatelessWidget {
   ReviewSection({super.key});
  final businessReviewController =
  GetControllers.instance.getBusinessReviewController();
  @override
  Widget build(BuildContext context) {


    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GestureDetector(
          onTap: () {
            AppRouter.route.pushNamed(RoutePath.businessReviewScreen);
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Rating & Reviews",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                            ),
                            Gap(8.h),
                            RatingBarIndicator(
                              rating: businessReviewController.avgRating.value,
                              itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 24,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: businessReviewController.avgRating.value.toStringAsFixed(1),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            CustomText(
                              text:
                              "${businessReviewController.pagingController.itemList?.length ?? 0} Ratings",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(12.h),
                    Divider(color: const Color(0xffCFCFCF)),
                    Gap(12.h),
                    Center(
                      child: CustomText(
                        text: "View Customer Reviews",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purple500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.purple500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
