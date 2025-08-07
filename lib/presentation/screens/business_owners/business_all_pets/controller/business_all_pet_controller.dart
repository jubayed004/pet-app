import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_all_pet_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessAllPetController extends GetxController{
  final ApiClient apiClient = serviceLocator();
  var loading = Status.completed.obs;
  loadingMethod(Status status) => loading.value = status;
  final Rx<BusinessAllPetsModel> profile = BusinessAllPetsModel().obs;

  Future<void> getBusinessProfile() async{
    loadingMethod(Status.completed);
    try{
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getBusinessAllPets());
      if (response.statusCode == 200) {
        final newData = BusinessAllPetsModel.fromJson(response.body);
        profile.value = newData;
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
    }catch(e){
      loadingMethod(Status.error);
    }


  }

  @override
  void onReady() {
    getBusinessProfile();
    super.onReady();
  }
}