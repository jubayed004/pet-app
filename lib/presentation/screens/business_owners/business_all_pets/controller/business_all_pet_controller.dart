
import 'package:flutter/foundation.dart';
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
  RxInt currentIndex = 0.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<BusinessAllPetsModel> profile = BusinessAllPetsModel().obs;

  /// Get Business All Pets
  Future<void> getBusinessAllPets() async {
    loadingMethod(Status.loading);
    try {
      final response = await apiClient.get(url: ApiUrl.getBusinessAllPets());
          log.d(response);
      if (response.statusCode == 200) {
        final newData = BusinessAllPetsModel.fromJson(response.body);
        log.d(newData.toJson());
        profile.value = newData;
        profile.refresh();
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
      log.e(e.toString());
      if (kDebugMode) {
        print('Error in getBusinessAllPets: $e');
      }
      loadingMethod(Status.error);
    }
  }

  /// Business Pet Details
  var detailsLoading = Status.completed.obs;

  detailsLoadingMethod(Status status) => detailsLoading.value = status;
  final Rx<BusinessAllPetsDetailsModel> details = BusinessAllPetsDetailsModel().obs;

  Future<void> businessPetDetails({required String id}) async {
    try {
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
    } catch (e) {
      if (kDebugMode) {
        print('Error in businessPetDetails: $e');
      }
      detailsLoadingMethod(Status.error);
    }
  }

  /// Get Health History (Completed)
  final Rx<BusinessMedicalHistoryModel> healthHistory = BusinessMedicalHistoryModel().obs;

  Future<void> getHealthHistoryUpdate({
    required String id,
    required String status,
    required int page,
    required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController,
  }) async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getHealthHistory(id: id, status: status, page: page),
      );

      if (response.statusCode == 200) {
        final newData = BusinessMedicalHistoryModel.fromJson(response.body);
        final newItems = newData.petMedicalHistory ?? [];

        final isLastPage = newItems.isEmpty || newItems.length < 10;

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, page + 1);
        }
      } else {
        pagingController.error = 'Failed to load data';
      }
    } catch (e) {
      print('Error in getHealthHistoryUpdate: $e');
      pagingController.error = 'An error occurred';
    }
  }

  /// Get Health History (Pending)
  Future<void> getHealthHistoryUpdate1({
    required String id,
    required String status,
    required int page,
    required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController1,
  }) async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getHealthHistory(id: id, status: status, page: page),
      );

      if (response.statusCode == 200) {
        final newData = BusinessMedicalHistoryModel.fromJson(response.body);
        final newItems = newData.petMedicalHistory ?? [];

        final isLastPage = newItems.isEmpty || newItems.length < 10;

        if (isLastPage) {
          pagingController1.appendLastPage(newItems);
        } else {
          pagingController1.appendPage(newItems, page + 1);
        }
      } else {
        pagingController1.error = 'Failed to load data';
      }
    } catch (e) {
      print('Error in getHealthHistoryUpdate1: $e');
      pagingController1.error = 'An error occurred';
    }
  }

  /// Add Health Update
  RxBool isUpdateLoading = false.obs;
  RxString statusValue = "COMPLETED".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> addHealth({
    required Map<String, String> body,
    required String id,
    required String status,
    required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController1,
    required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController,
  }) async {
    try {
      isUpdateLoading.value = true;

      final response = await apiClient.post(
        url: ApiUrl.healthHistoryCreate(id: id),
        body: body,
      );

      if (response.statusCode == 201) {
        // Refresh both controllers to update the lists
        pagingController1.refresh();
        pagingController.refresh();

        isUpdateLoading.value = false;
        toastMessage(message: 'Health record added successfully');
        AppRouter.route.pop();
      } else {
        isUpdateLoading.value = false;
        toastMessage(
          message: response.body?['message']?.toString() ?? 'Failed to add record',
        );
      }
    } catch (error) {
      print('Error in addHealth: $error');
      isUpdateLoading.value = false;
      toastMessage(message: 'An error occurred while adding record');
    }
  }

  /// Edit Health Update
  RxBool isEditLoading = false.obs;

  Future<void> editHealth({
    required Map<String, String> body,
    required String id,
    required String status,
    required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController1,
    required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController,
  }) async {
    try {
      isEditLoading.value = true;

      final response = await apiClient.put(
        url: ApiUrl.healthHistoryUpdate(id: id),
        body: body,
      );

      if (response.statusCode == 200) {
        // Refresh both controllers
        pagingController1.refresh();
        pagingController.refresh();

        isEditLoading.value = false;
        toastMessage(message: 'Health record updated successfully');
        AppRouter.route.pop();
      } else {
        isEditLoading.value = false;
        toastMessage(
          message: response.body?['message']?.toString() ?? 'Failed to update record',
        );
      }
    } catch (error) {
      print('Error in editHealth: $error');
      isEditLoading.value = false;
      toastMessage(message: 'An error occurred while updating record');
    }
  }

  /// Delete Health History
  Future<void> deletedHealthHistory({
    required String id,
    required String status,
    required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController1,
    required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController,
  }) async {
    try {
      final response = await apiClient.delete(
        url: ApiUrl.deleteHealthHistory(id: id),
        body: {},
      );

      if (response.statusCode == 200) {
        // Refresh both controllers
        pagingController1.refresh();
        pagingController.refresh();

        toastMessage(
          message: response.body?['message']?.toString() ?? 'Record deleted successfully',
        );
        AppRouter.route.pop();
      } else {
        toastMessage(
          message: response.body?['message']?.toString() ?? 'Failed to delete record',
        );
      }
    } catch (error) {
      print('Error in deletedHealthHistory: $error');
      toastMessage(message: 'An error occurred while deleting record');
    }
  }

  @override
  void onReady() {
    getBusinessAllPets();
    super.onReady();
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}