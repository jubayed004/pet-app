import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

import '../model/pet_health_model.dart';
class PetHealthController extends GetxController {
  final ApiClient apiClient = serviceLocator();

  Future<void> getHealth({
    required String id,
    required String status,
    required int page,
    required PagingController<int, HealthHistoryItem> pagingController,
  }) async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getPetHealth(id: id, status: status, page: page),
      );

      final statusCode = response.statusCode ?? 0;

      if (statusCode == 200) {
        final newData = PetHealthModel.fromJson(response.body);
        final newItems = newData.data ?? [];

        if (newItems.isEmpty) {
          pagingController.appendLastPage([]);
        } else {
          pagingController.appendPage(newItems, page + 1);
        }
      } else if (statusCode == 404) {
        // Backend বলছে ডেটা নাই
        pagingController.appendLastPage([]);
        pagingController.error = response.body?['message'] ?? "No medical history found";
      } else if (statusCode == 503) {
        pagingController.error = "No internet connection. Please try again.";
      } else {
        pagingController.error = response.body?['message'] ?? "Something went wrong!";
      }
    } catch (e) {
      pagingController.error = "Unexpected error. Please try again.";
    }
  }
}

