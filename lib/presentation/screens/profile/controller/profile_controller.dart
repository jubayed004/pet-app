
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/profile/model/profile_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/variable/variable.dart';

class ProfileController extends GetxController {
  final controller = GetControllers.instance.getNavigationControllerMain();
  final myPetsController = GetControllers.instance.getMyPetsProfileController();
  RxString selectedCountryCode = "+880".obs;
  final ImagePicker _imagePicker = ImagePicker();
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();

  /// ============================= GET Profile Info =====================================
  var loading = Status.completed.obs;
  loadingMethod(Status status) => loading.value = status;
  final Rx<ProfileModel> profile = ProfileModel().obs;
  /*final RxBool isAdmin = false.obs;*/

  Future<void> userProfile() async {
    final log = logger;

    loadingMethod(Status.completed);
    try {
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getProfile());
      log.i('API call: ${ApiUrl.getProfile()}');
      log.d('Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final newData = ProfileModel.fromJson(response.body);
        log.d(newData.toJson()             );
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
        log.w('Bad status: ${response.statusCode}');
      }
    } catch (e, st) {
      log.e('Profile load failed', error: e, stackTrace: st);
      loadingMethod(Status.error);
    }
  }


  /// ============================= PUT Profile Update =====================================

  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  RxBool isUpdateLoading = false.obs;
  Future<void> pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selectedImage.value = image;
    }
  }
  Future<void> updateProfile({required Map<String, String> body}) async{
    try{
      isUpdateLoading.value = true;
      final List<MultipartBody> multipartBody = [];
      if(selectedImage.value != null){
        multipartBody.add(MultipartBody("profilePic", File(selectedImage.value?.path?? "")));
      }
      print(body);
      final response = await apiClient.multipartRequest(url: ApiUrl.updateProfile(), body: body, multipartBody: multipartBody, reqType: "PUT");
      if(response.statusCode == 200){
        await userProfile();
        isUpdateLoading.value = false;
        AppRouter.route.pop();
      }else{
        isUpdateLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    }catch(error){
      isUpdateLoading.value = false;
    }
  }

  /// ============================= Add Pet  =====================================
  var genderSelected = Rx<String>("MALE");
  Rx<XFile?> selecteImage = Rx<XFile?>(null);
  RxBool isAddPetLoading = false.obs;
  Future<void> addPickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selecteImage.value = image;
    }
  }
  Future<void> addPet({required Map<String, String> body}) async{
    try{
      isAddPetLoading.value = true;
      final List<MultipartBody> multipartBody = [];
      if(selecteImage.value != null){
        multipartBody.add(MultipartBody("petPhoto", File(selecteImage.value?.path?? "")));
      }
      print(body);
      final response = await apiClient.multipartRequest(url: ApiUrl.addPet(), body: body, multipartBody: multipartBody, reqType: "POST");
      if(response.statusCode == 201){
        await myPetsController.getAllPet();
        isAddPetLoading.value = false;
        controller.selectedNavIndex.value = 3;
        AppRouter.route.goNamed(RoutePath.navigationPage);
      /*  AppRouter.route.pop();*/
      }else{
        isAddPetLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    }catch(error){
      isAddPetLoading.value = false;
    }
  }

  ///================================= Give Feedback =======================///

  RxBool feedbackLoading = false.obs;

  Future<void> giveFeedback({required Map<String, String> body}) async {
    try {
      feedbackLoading.value = true;

      final response = await apiClient.post(
        url: ApiUrl.giveFeedbacks(),
        body: body,
      );

      feedbackLoading.value = false;

      if (response.statusCode == 201) {
        // Show success message
        toastMessage(message: response.body?['message']?.toString() ?? "Feedback submitted successfully");
        // Pop the screen after showing toast
        AppRouter.route.pop();
      } else {
        // Show error message from API
        toastMessage(message: response.body?['message']?.toString() ?? "Something went wrong");
      }
    } catch (error) {
      feedbackLoading.value = false;
      toastMessage(message: "An error occurred. Please try again."); // Show error on exception
    }
  }




@override
  void onReady() {
  super.onReady();
  userProfile();

  }

}
