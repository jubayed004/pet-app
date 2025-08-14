import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_all_pet_model.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_all_pets_details_model.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessAllPetController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  var loading = Status.completed.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<BusinessAllPetsModel> profile = BusinessAllPetsModel().obs;

  ///=====================
  Future<void> getBusinessProfile() async {
    loadingMethod(Status.completed);
    try {
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
    } catch (e) {
      loadingMethod(Status.error);
    }
  }

  ///======================== BusinessAllPetsDetail
  var detailsLoading = Status.completed.obs;

  detailsLoadingMethod(Status status) => loading.value = status;
  final Rx<BusinessAllPetsDetailsModel> details =
      BusinessAllPetsDetailsModel().obs;

  Future<void> businessPetDetails({required String id}) async {
    detailsLoadingMethod(Status.completed);
    try {
      detailsLoadingMethod(Status.loading);
      final response = await apiClient.get(
        url: ApiUrl.businessPetDetails(id: id),
      );
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
    } catch (e) {
      detailsLoadingMethod(Status.error);
    }
  }

  ///========================BusinessMedicalHistory
  final PagingController<int, PetMedicalHistoryByTreatmentStatus>
  pagingController = PagingController(firstPageKey: 1);

  /*  final Rx<BusinessMedicalHistoryModel> healthHistory = BusinessMedicalHistoryModel().obs;*/
  Future<void> getHealthHistoryUpdate({
    required String id,
    required String status,
    required int page,
  }) async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getHealthHistory(id: id, status: status, page: page),
      );
      if (response.statusCode == 200) {
        final newData = BusinessMedicalHistoryModel.fromJson(response.body);
        final newItems = newData.petMedicalHistoryByTreatmentStatus ?? [];
        if (newItems.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, page + 1);
        }
      } else {
        pagingController.error = 'An error occurred';
      }
    } catch (e) {
      pagingController.error = 'An error occurred';
    }
  }

  ///========================BusinessMedicalHistory

  final PagingController<int, PetMedicalHistoryByTreatmentStatus>
  pagingController1 = PagingController(firstPageKey: 1);

  Future<void> getHealthHistoryUpdate1({
    required String id,
    required String status,
    required int page,
  }) async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getHealthHistory(id: id, status: status, page: page),
      );
      if (response.statusCode == 200) {
        final newData = BusinessMedicalHistoryModel.fromJson(response.body);
        final newItems = newData.petMedicalHistoryByTreatmentStatus ?? [];
        if (newItems.isEmpty) {
          pagingController1.appendLastPage(newItems);
        } else {
          pagingController1.appendPage(newItems, page + 1);
        }
      } else {
        pagingController1.error = 'An error occurred';
      }
    } catch (e) {
      pagingController1.error = 'An error occurred';
    }
  }
  ///================================= AddHealth Update

  RxBool isUpdateLoading = false.obs;
  RxString statusValue = "COMPLETED".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> addHealth({required Map<String, String> body, required String id, required String status,}) async {
    try {
      isUpdateLoading.value = true;

      final response = await apiClient.post(
        url: ApiUrl.healthHistoryCreate(id: id),
        body: body,
      );

      if (response.statusCode == 201) {
        if (status == "PENDING"){
          pagingController1.refresh();
        }else{
          pagingController.refresh();
        }
        isUpdateLoading.value = false;
        AppRouter.route.pop();
      } else {
        isUpdateLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (error) {
      isUpdateLoading.value = false;
    }
  }
  ///================================= Edit Health Update==============

  RxBool isEditLoading = false.obs;


  Future<void> editHealth({required Map<String, String> body, required String id, required String status,}) async {
    try {
      isEditLoading.value = true;

      final response = await apiClient.put(
        url: ApiUrl.healthHistoryUpdate(id: id),
        body: body,
      );

      if (response.statusCode == 200) {
        pagingController1.refresh();
        pagingController.refresh();
        isEditLoading.value = false;
        AppRouter.route.pop();
      } else {
        isEditLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (error) {
      isEditLoading.value = false;
    }
  }
  ///================================= DeletedHealthHistory

  Future<void> deletedHealthHistory ({ required String id, required String status})async {
 try{
   final response = await apiClient.delete(url: ApiUrl.deleteHealthHistory(id: id), body: {}, );

   if(response.statusCode == 200){
     if (status == "PENDING"){
       pagingController1.refresh();
     }else{
       pagingController.refresh();
     }
     toastMessage(message: response.body?['message']?.toString());
     AppRouter.route.pop();
   }
 }catch(error){
   print(error);
 }
  }

  @override
  void onReady() {
    getBusinessProfile();
    super.onReady();
  }
}
