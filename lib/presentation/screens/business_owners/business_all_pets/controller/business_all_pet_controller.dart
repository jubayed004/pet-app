import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_all_pet_model.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_all_pets_details_model.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessAllPetController extends GetxController{
  final ApiClient apiClient = serviceLocator();
  var loading = Status.completed.obs;
  loadingMethod(Status status) => loading.value = status;
  final Rx<BusinessAllPetsModel> profile = BusinessAllPetsModel().obs;
///=====================
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

  ///========================
   var detailsLoading = Status.completed.obs;
  detailsLoadingMethod(Status status) => loading.value = status;
  final Rx<BusinessAllPetsDetailsModel> details = BusinessAllPetsDetailsModel().obs;
  Future<void> businessPetDetails({required String id}) async{
    detailsLoadingMethod(Status.completed);
    try{
      detailsLoadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.businessPetDetails(id: id));
      if (response.statusCode == 200) {
        final newData = BusinessAllPetsDetailsModel.fromJson(response.body);
        details.value = newData;
        detailsLoadingMethod(Status.completed);
      } else {
        if (response.statusCode == 503) {
          detailsLoadingMethod(Status.internetError);
        } else if (response.statusCode == 404) {
          detailsLoadingMethod(Status.noDataFound);
        } else {
          detailsLoadingMethod(Status.error);
        }
      }
    }catch(e){
      detailsLoadingMethod(Status.error);
    }


  }
  ///========================
   var healthHistoryLoading = Status.completed.obs;
  healthHistoryMethod(Status status) => loading.value = status;
  final Rx<BusinessMedicalHistoryModel> healthHistory = BusinessMedicalHistoryModel().obs;
  Future<void> getHealthHistoryUpdate({required String id}) async{
    healthHistoryMethod(Status.completed);
    try{
      healthHistoryMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getHealthHistory(id: id));
      if (response.statusCode == 200) {
        final newData = BusinessMedicalHistoryModel.fromJson(response.body);
        healthHistory.value = newData;
        healthHistoryMethod(Status.completed);
      } else {
        if (response.statusCode == 503) {
          healthHistoryMethod(Status.internetError);
        } else if (response.statusCode == 404) {
          healthHistoryMethod(Status.noDataFound);
        } else {
          healthHistoryMethod(Status.error);
        }
      }
    }catch(e){
      healthHistoryMethod(Status.error);
    }


  }

  @override
  void onReady() {
    getBusinessProfile();
    super.onReady();
  }
}