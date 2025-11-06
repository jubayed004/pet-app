import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/category/model/category_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

import 'package:flutter/foundation.dart';

class CategoryController extends GetxController {
  final ApiClient apiClient = serviceLocator<ApiClient>();
  final Rx<CategoryModel> service = CategoryModel().obs;

  Future<void> getCategoryService({
    required String type,
    required int page,
    required PagingController<int, CategoryServiceItem> pagingController,
  }) async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getService(page: page, type: type),
      );

      if (response.statusCode == 200) {
        final newData = CategoryModel.fromJson(response.body);
        final newItems = newData.services ?? [];

        if (kDebugMode) {
          print('Loaded ${newItems.length} items for $type, page $page');
        }

        if (newItems.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, page + 1);
        }
      } else {
        final statusCode = response.statusCode ?? 0;
        final errorMessage = _getErrorMessage(statusCode);
        pagingController.error = errorMessage;

        if (kDebugMode) {
          print('API Error - Status: $statusCode, Type: $type, Page: $page');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in getCategoryService: $e');
      }
      pagingController.error = 'An error occurred. Please try again.';
    }
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please try again.';
      case 401:
        return 'Unauthorized. Please log in again.';
      case 404:
        return 'Service not found.';
      case 500:
        return 'Server error. Please try again later.';
      case 503:
        return 'No Internet Connection';
      default:
        return 'An error occurred. Please try again.';
    }
  }


  // Future<void> getMyAppointment({
  //   required int pageKey,
  //   required PagingController<int, String> controller,
  // }) async {
  //   try {
  //     await Future.delayed(Duration(seconds: 1));
  //
  //     if (pageKey == 3) {
  //       controller.appendLastPage([]);
  //     } else {
  //       final item = ["Apple", "Orange", "Bird", "Lemon", "Mango", "banana"];
  //       controller.appendPage(item, pageKey + 1);
  //     }
  //   } catch (_) {
  //     controller.error = "error";
  //   }
  // }
}
