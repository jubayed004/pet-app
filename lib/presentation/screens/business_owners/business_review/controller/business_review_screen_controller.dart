import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/business_owners/business_review/model/business_review_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class BusinessReviewController extends GetxController {
  final ApiClient apiClient = serviceLocator<ApiClient>();

  final PagingController<int, ReviewItem> pagingController =
  PagingController(firstPageKey: 1);

  RxDouble avgRating = 0.0.obs;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getReviews(page: pageKey);
    });

    super.onInit();
  }

  Future<void> getReviews({required int page}) async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getOwnerServiceReviews(page: page),
      );
      if (response.statusCode == 200) {
        final data = BusinessReviewModel.fromJson(response.body);
        final newItems = data.reviews ?? [];
        if (newItems.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          avgRating.value = (data.avgRating ?? 0.0).toDouble();
          pagingController.appendPage(newItems, page + 1);
        }
      } else {

        pagingController.error = 'Failed to load data';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in getReviews: $e');
      }
      pagingController.error = 'An error occurred';
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
