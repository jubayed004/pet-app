import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/see_more_text.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_review/model/business_review_model.dart';

class BusinessReviewScreen extends StatelessWidget {
  BusinessReviewScreen({super.key});
  final businessReviewController =
      GetControllers.instance.getBusinessReviewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Reviews",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          businessReviewController.pagingController.refresh();
        },

        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          businessReviewController.avgRating.value
                              .toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        RatingBarIndicator(
                          rating: businessReviewController.avgRating.value,
                          itemBuilder:
                              (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 24,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Based on user reviews",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Divider(thickness: 1, color: Colors.grey.shade300),
              ),

              /// Review list
              PagedSliverList<int, ReviewItem>(
                pagingController: businessReviewController.pagingController,
                builderDelegate: PagedChildBuilderDelegate<ReviewItem>(
                  itemBuilder: (context, item, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// User info
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: SizedBox(
                                  width: 48.w,
                                  height: 48.h,
                                  child: CustomNetworkImage(
                                    imageUrl: item.userId?.profilePic ?? '',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.userId?.name ?? "Unknown",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    item.createdAt != null
                                        ? _formatTimeAgo(item.createdAt!)
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          /// Rating
                          Row(
                            children: [
                              Text(
                                item.rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              RatingBarIndicator(
                                rating: item.rating?.toDouble() ?? 0.0,
                                itemBuilder:
                                    (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                itemCount: 5,
                                itemSize: 18,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          /// Comment
                          ExpandableText(text: item.comment ?? ""),
                          const SizedBox(height: 10),
                          Divider(thickness: 1, color: Colors.grey.shade200),
                        ],
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder:
                      (_) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("No reviews yet."),
                        ),
                      ),
                  firstPageProgressIndicatorBuilder:
                      (_) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  newPageProgressIndicatorBuilder:
                      (_) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return '${diff.inDays} days ago';
  }
}
