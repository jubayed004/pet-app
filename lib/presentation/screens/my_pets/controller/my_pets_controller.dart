import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/my_pets/model/my_all_pet_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

import '../../business_owners/business_all_pets/model/business_all_pets_details_model.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/my_pets/model/my_all_pet_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

import '../../business_owners/business_all_pets/model/business_all_pets_details_model.dart';

class MyPetsProfileController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final ImagePicker _imagePicker = ImagePicker();

  /// Loading State
  var loading = Status.completed.obs;
  var detailsLoading = Status.completed.obs;
  var isUpdateLoading = false.obs;

  /// Data Holders
  final Rx<MyAllPetModel> profile = MyAllPetModel().obs;
  final Rx<BusinessAllPetsDetailsModel> details = BusinessAllPetsDetailsModel().obs;

  /// Image + Gender
  var genderSelected = "MALE".obs;
  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  /// ================= Get All Pets =================
  Future<void> getAllPet() async {
    try {
      loading.value = Status.loading;

      final response = await apiClient.get(url: ApiUrl.getMyAllPet());
      final statusCode = response.statusCode ?? 0; // null safe

      if (statusCode == 200) {
        profile.value = MyAllPetModel.fromJson(response.body);
        loading.value = Status.completed;
      } else {
        handleError(statusCode, isDetails: false);
      }
    } catch (e) {
      loading.value = Status.error;
    }
  }

  /// ================= Get Pet Details =================
  Future<void> myAllPetDetails({required String id}) async {
    try {
      detailsLoading.value = Status.loading;

      final response = await apiClient.get(url: ApiUrl.myAllPetDetails(id: id));
      final statusCode = response.statusCode ?? 0; // null safe

      if (statusCode == 200) {
        details.value = BusinessAllPetsDetailsModel.fromJson(response.body);
        detailsLoading.value = Status.completed;
      } else {
        handleError(statusCode, isDetails: true);
      }
    } catch (e) {
      detailsLoading.value = Status.error;
    }
  }

  /// ================= Update Pet =================
  Future<void> updateMyPet({required Map<String, String> body, required String id}) async {
    try {
      isUpdateLoading.value = true;
      final List<MultipartBody> multipartBody = [];

      if (selectedImage.value != null) {
        multipartBody.add(MultipartBody("petPhoto", File(selectedImage.value!.path)));
      }

      final response = await apiClient.multipartRequest(
        url: ApiUrl.updateMyPet(id: id),
        body: body,
        multipartBody: multipartBody,
        reqType: "PUT",
      );

      final statusCode = response.statusCode ?? 0; // null safe

      if (statusCode == 200) {
        await myAllPetDetails(id: id); // refresh details
        await getAllPet(); // refresh list
        toastMessage(message: response.body?['message']?.toString() ?? "Pet updated!");
        AppRouter.route.pop();
      } else {
        toastMessage(message: response.body?['message']?.toString() ?? "Update failed!");
      }
    } catch (error) {
      toastMessage(message: "Something went wrong!");
      if (kDebugMode) print(error);
    } finally {
      isUpdateLoading.value = false;
    }
  }

  /// ================= Delete Pet =================
  Future<void> deletedPet({required String id}) async {
    try {
      final response = await apiClient.delete(url: ApiUrl.deletedPet(id: id));
      final statusCode = response.statusCode ?? 0; // null safe

      if (statusCode == 200) {
        await getAllPet(); // refresh list
        toastMessage(message: response.body?['message']?.toString() ?? "Pet deleted!");
        AppRouter.route.pop();
      } else {
        toastMessage(message: "Delete failed!");
      }
    } catch (error) {
      toastMessage(message: "Something went wrong!");
      if (kDebugMode) print(error);
    }
  }

  /// ================= Pick Image =================
  Future<void> pickImage() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      toastMessage(message: "Image pick failed!");
    }
  }

  /// ================= Error Handler =================
  void handleError(int statusCode, {bool isDetails = false}) {
    if (statusCode == 503) {
      isDetails ? detailsLoading.value = Status.internetError : loading.value = Status.internetError;
    } else if (statusCode == 404) {
      isDetails ? detailsLoading.value = Status.noDataFound : loading.value = Status.noDataFound;
    } else {
      isDetails ? detailsLoading.value = Status.error : loading.value = Status.error;
    }
  }

  @override
  void onReady() {
    getAllPet();
    super.onReady();
  }
}

