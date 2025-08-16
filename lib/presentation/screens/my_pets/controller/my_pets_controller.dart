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

class MyPetsProfileController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final ImagePicker _imagePicker = ImagePicker();


  ///===================== Get All Pet====================

  var loading = Status.completed.obs;
  loadingMethod(Status status) => loading.value = status;
  final Rx<MyAllPetModel> profile = MyAllPetModel().obs;

  Future<void> getAllPet() async {
    loadingMethod(Status.completed);
    try {
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getMyAllPet());
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        final newData = MyAllPetModel.fromJson(response.body);
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

  ///======================== myAllPetsDetail======================
  var detailsLoading = Status.completed.obs;
  detailsLoadingMethod(Status status) => loading.value = status;
  final Rx<BusinessAllPetsDetailsModel> details = BusinessAllPetsDetailsModel().obs;

  Future<void> myAllPetDetails({required String id}) async {
    detailsLoadingMethod(Status.completed);
    detailsLoadingMethod(Status.loading);
    final response = await apiClient.get(
      url: ApiUrl.myAllPetDetails(id: id),
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
  }


  /// ============================= Edit My Pet  =====================================
  var genderSelected = Rx<String>("MALE");
  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  RxBool isUpdateLoading = false.obs;
  Future<void> pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> updateMyPet({required Map<String, String> body, required id}) async{
    try{
      isUpdateLoading.value = true;
      final List<MultipartBody> multipartBody = [];
      if(selectedImage.value != null){
        multipartBody.add(MultipartBody("petPhoto", File(selectedImage.value?.path?? "")));
      }
      print(body);
      final response = await apiClient.multipartRequest(url: ApiUrl.updateMyPet(id: id), body: body, multipartBody: multipartBody, reqType: "PUT");

      if(response.statusCode == 200){
        await myAllPetDetails(id: id);
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


  ///=================== Deleted Pet

  Future<void> deletedPet({required String id})async {
    try {
      final response = await apiClient.delete(
        url: ApiUrl.deletedPet(id: id));

      if (response.statusCode == 200) {
        await getAllPet();
        toastMessage(message: response.body?['message']?.toString());
        AppRouter.route.pop();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }


  @override
  void onReady() {
    Future.wait([
      getAllPet()

    ]);
    super.onReady();
  }
}
