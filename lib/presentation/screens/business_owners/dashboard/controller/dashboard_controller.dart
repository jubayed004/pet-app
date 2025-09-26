import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/business_owners/dashboard/model/dashboard_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class DashBoardController extends GetxController{
  final ApiClient apiClient = serviceLocator();
  var loading = Status.completed.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<DashboardModel> dashboard = DashboardModel().obs;

  ///===================== Business Shop Profile ====================
  Future<void> getBusinessShopProfile({required String month, required String week}) async {
    loadingMethod(Status.completed);
    try {
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getBusinessDashboard(month: month, week: week));
      if (response.statusCode == 200) {
        final newData = DashboardModel.fromJson(response.body);
        dashboard.value = newData;
        loadingMethod(Status.completed);
      } else {
        if (response.statusCode == 503) {
          loadingMethod(Status.internetError);
        } else if (response.statusCode == 404) {
          loadingMethod(Status.noDataFound);
        } else {
          loadingMethod(Status.error);
        }
      }
    } catch (e) {
      loadingMethod(Status.error);
    }
  }
/*  @override
  void onReady() {
    getBusinessShopProfile(month: month, week: week);
    super.onReady();
  }*/


}