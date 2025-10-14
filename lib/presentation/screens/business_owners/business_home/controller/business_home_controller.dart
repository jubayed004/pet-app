import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/model/business_home_brand_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessHomeController extends GetxController{
  final ApiClient apiClient = serviceLocator();
  var loading = Status.completed.obs;
  RxInt currentIndex = 0.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<BusinessHomeBrandModel> brand = BusinessHomeBrandModel().obs;

  ///================================ Get Business Home Controller=======================
  Future<void> getBusinessHomeBrand() async {
    loadingMethod(Status.loading);
    try {
      final response = await apiClient.get(url: ApiUrl.getBusinessHomeBrand());
      if (response.statusCode == 200) {
        final newData = BusinessHomeBrandModel.fromJson(response.body);
        brand.value = newData;
        brand.refresh();
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
      if (kDebugMode) {
        print('Error in getBusinessHomeBrand: $e');
      }
      loadingMethod(Status.error);
    }
  }


}