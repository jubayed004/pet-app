import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_all_pet_model.dart';
import 'package:pet_app/presentation/screens/business_owners/business_shop_profile/model/business_shop_profile_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessShopProfileController extends GetxController{

  final ApiClient apiClient = serviceLocator();
  var loading = Status.completed.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<BusinessShopProfileModel> shopProfile = BusinessShopProfileModel().obs;

  ///===================== Business Shop Profile ====================
  Future<void> getBusinessShopProfile() async {
    loadingMethod(Status.completed);
    try {
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getBusinessShopProfile());
      if (response.statusCode == 200) {
        final newData = BusinessShopProfileModel.fromJson(response.body);
        shopProfile.value = newData;
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
  @override
  void onReady() {
    getBusinessShopProfile();
    super.onReady();
  }

}