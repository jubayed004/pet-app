import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/business_owners/dashboard/model/dashboard_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

import '../../../../../utils/variable/variable.dart';


class DashBoardController extends GetxController {
  final ApiClient apiClient = serviceLocator();

  var loading = Status.completed.obs;
  final RxString selectedView = 'monthly'.obs;
  final Rx<DashboardModel> dashboard = DashboardModel().obs;

  void loadingMethod(Status status) => loading.value = status;

  Future<void> getDashboard({required String statuse}) async {
    loadingMethod(Status.loading);
    try {
      final response = await apiClient.get(url: ApiUrl.getBusinessDashboard(status: statuse));
      logger.d(response.body);
      if (response.statusCode == 200) {
        dashboard.value = DashboardModel.fromJson(response.body);
        loadingMethod(Status.completed);

      } else if (response.statusCode == 503) {
        loadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        loadingMethod(Status.noDataFound);
      } else {
        loadingMethod(Status.error);
      }
    } catch (e) {
      loadingMethod(Status.error);
      print("❌ Dashboard fetch error: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Initial fetch
    getDashboard(statuse: selectedView.value.toLowerCase());

    // Auto-fetch when view is changed
    ever<String>(selectedView, (newView) {
      getDashboard(statuse: newView.toLowerCase());
    });
  }
}
