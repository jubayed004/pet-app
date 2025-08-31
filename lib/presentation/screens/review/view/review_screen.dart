import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/star_rating_widget.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/presentation/screens/review/widgets/custom_add_review_dialog.dart';
import 'package:pet_app/presentation/screens/review/widgets/review_card_item_widget.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class ReviewScreen extends StatelessWidget {

  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Customer Reviews"),
          SliverPadding(
            padding: padding12H,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  ListTile(
                    title:Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          color: Colors.amber,
                          text: "4.0",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        CustomText(
                          color: Colors.amber,
                          text: "(234 Ratings)",
                          fontSize: 14,
                        ),
                      ],
                    ),
                    subtitle:   StarRating(
                      rating: 4,
                      size: 30.sp,
                      filledColor: Colors.amber,
                      borderColor: Colors.amber,
                    ),
                    trailing: IconButton(onPressed: (){
                      showAddReviewDialog(context,"","","" );
                    }, icon: Icon(Iconsax.add5,color: Colors.green,size: 34,)),
                  ),

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