import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/star_rating_widget.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/widgets/review_card_item_widget.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/widgets/view_all_row_widgets.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class ReviewScreen extends StatelessWidget {
  static const String routeName = "/review";

  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Customer Review"),
          SliverPadding(
            padding: padding12H,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        color: AppColors.kPrimaryColor,
                        text: "4.0",
                       fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      CustomText(
                        color: AppColors.kPrimaryColor,
                        text: "(234 Ratings)",
                        fontSize: 14,
                      ),
                    ],
                  ),
                  StarRating(
                    rating: 4,
                    size: 30.sp,
                    filledColor: AppColors.kPrimaryDarkColor,
                    borderColor: AppColors.kPrimaryDarkColor,
                  ),
                /*  ViewAllRow(
                    title: "Customer Reviews",
                    titleColor: Colors.black,
                    onPressed: () {},
                  ),*/
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ReviewCardItem();
            }, childCount: 10),
          ),
        ],
      ),
    );
  }
}