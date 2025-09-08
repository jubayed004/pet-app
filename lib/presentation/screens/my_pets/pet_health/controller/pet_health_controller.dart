import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

import '../model/pet_health_model.dart';

class PetHealthController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final PagingController<int, HealthHistoryItem> pagingController1 = PagingController(firstPageKey: 1);

  Future<void> getHealth({
    required String id,
    required String status,
    required int page,
    required PagingController<int, HealthHistoryItem> pagingController,
  }) async {
    final response = await apiClient.get(
      url: ApiUrl.getPetHealth(id: id, status: status, page: page),
    );
    if (response.statusCode == 200) {
      final newData = PetHealthModel.fromJson(response.body);
      final newItems = newData.data ?? [];
      if (newItems.isEmpty) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, page + 1);
      }
    } else {
      pagingController.error = 'An error occurred';
    }
  }
}
