import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/see_more_text.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/see_more_text.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/star_rating_widget.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/review/model/review_model.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/variable/variable.dart';

class ReviewCardItem extends StatelessWidget {
  final ReviewItem? item;
  ReviewCardItem({super.key, required this.item,});

  final reviewController = GetControllers.instance.getReviewController();

  @override
  Widget build(BuildContext context) {
    final userId = item?.userId;
    final image = userId?.profilePic;
    final userImage = image != null && image.isNotEmpty ? image : "";
    final name = userId?.name;
    final comment = item?.comment;
    final rate = item?.rating;
   final date= DateFormat(
      "dd MMMM yyyy",
    ).format(item?.createdAt ?? DateTime.now());
    print("==================Rating 1111===========${int.tryParse(rate.toString()) ?? 0}");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.w),
      child: Row(
        spacing: 12.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            imageUrl: "${ApiUrl.imageBase}$image",
            boxShape: BoxShape.circle,
            height: 40.w,
            width: 40.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8.w,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: name ?? "",
                      fontWeight: FontWeight.w600,
                      color: AppColors.kPrimaryColor,
                    ),
                    CustomText(
                      text: date, fontWeight: FontWeight.w600,)
                  ],
                ),
                StarRating(rating: int.tryParse(rate.toString()) ?? 0, size: 15.sp,),

                ExpandableText(text: comment ?? ""),



              ],
            ),
          ),
        ],
      ),
    );
  }
}
