import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/star_rating_widget.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/review/widgets/custom_add_review_dialog.dart';
import 'package:pet_app/presentation/screens/review/widgets/review_card_item_widget.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class ReviewScreen extends StatefulWidget {
  final String businessId;
  final String ownerId;
  final String serviceId;

  const ReviewScreen({super.key, required this.businessId, required this.ownerId, required this.serviceId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final controller = GetControllers.instance.getReviewController();

  @override
  void initState() {
    controller.getReviewByService(id: widget.serviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getReviewByService(id: widget.serviceId);
        },
        child: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(title: "Customer Reviews"),
            SliverPadding(
              padding: padding12H,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    ListTile(
                      title: Obx(() {
                        return Row(
                          spacing: 6,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              color: Colors.amber,
                              text: controller.review.value.avgRating?.toStringAsFixed(2) ?? "",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            CustomText(color: Colors.amber, text: "(${controller.review.value.totalReviews.toString()} Ratings)", fontSize: 14),
                          ],
                        );
                      }),
                      subtitle: Obx(() {
                        return StarRating(
                          rating: controller.review.value.avgRating?.toInt() ?? 0,
                          size: 30.sp,
                          filledColor: Colors.amber,
                          borderColor: Colors.amber,
                        );
                      }),
                      trailing: IconButton(
                        onPressed: () {
                          showAddReviewDialog(context, widget.businessId, widget.ownerId, widget.serviceId);
                        },
                        icon: Icon(Iconsax.add5, color: Colors.green, size: 34),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = controller.review.value.reviews?[index];
                  return ReviewCardItem(item: item);
                }, childCount: controller.review.value.reviews?.length),
              );
            }),
          ],
        ),
      ),
    );
  }
}
