import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class BusinessAddServiceController extends GetxController{
  final businessServiceController =
  GetControllers.instance.getBusinessServiceController();
  ///===============Service Type ==============
  final selectedAnalystType = ''.obs;
  final List<String> analystType = [
    "Vet",
    "Grooming",
    "Shop",
    "Hotel",
    "Training",
    "Friendly ",
  ];

  
  final RxList<String> selectedAnalystTypes = <String>[].obs;
  void toggleSelection(String item) {
    if (selectedAnalystTypes.contains(item)) {
      selectedAnalystTypes.remove(item);
    } else {
      selectedAnalystTypes.add(item);
    }
  }
  
  /// ===================== Time ============
  final selectedWeek= ''.obs;
  final List<String> weekly = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  final Rx<TimeOfDay?> openingTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> closingTime = Rx<TimeOfDay?>(null);
  Future<void> pickOpeningTime(BuildContext context) async {
    final initial = openingTime.value ?? TimeOfDay.now();
    final result = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (result != null) openingTime.value = result;
  }
  Future<void> pickClosingTime(BuildContext context) async {
    final initial = closingTime.value ?? TimeOfDay.now();
    final result = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (result != null) closingTime.value = result;
  }
  
  
  ///===================Add Service Api Function

  final ImagePicker _imagePicker = ImagePicker();
  final ApiClient apiClient = serviceLocator();
  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  RxBool isLoading = false.obs;
  Future<void> pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selectedImage.value = image;
    }
  }
  Future<void> addService({required Map<String, String> body}) async{
    try{
      isLoading.value = true;
      final List<MultipartBody> multipartBody = [];
      if(selectedImage.value != null){
        multipartBody.add(MultipartBody("servicesImages", File(selectedImage.value?.path?? "")));
      }
      print("weiurterit ertioyertoguiopdrtdrthporthndrtpgrtphnrth");
      print(body);
      final response = await apiClient.multipartRequest(url: ApiUrl.addService(), body: body, multipartBody: multipartBody, reqType: "POST");
      if(response.statusCode == 201){
        await businessServiceController.getBusinessService();
        isLoading.value = false;
        AppRouter.route.pop();
      }else{
        isLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    }catch(error){
      isLoading.value = false;
    }
  }

  ///================================= Edit Health Update==============
  Rx<XFile?> selecteImage = Rx<XFile?>(null);
  RxBool isEditLoading = false.obs;
  Future<void> editPickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selecteImage.value = image;
    }
  }

  Future<void> editService({required Map<String, String> body, required String id,}) async {
    try {
  print("index 5");
      isEditLoading.value = true;
      final List<MultipartBody> multipartBody = [];
      if(selecteImage.value != null){
        multipartBody.add(MultipartBody("servicesImages", File(selecteImage.value?.path?? "")));
      }
  print("index 6");
      print("weiurterit ertioyertoguiopdrtdrthporthndrtpgrtphnrth");
      print(body);
    /*  print(multipartBody.first.file);
      print(multipartBody.first.key);*/
      final response = await apiClient.multipartRequest(url: ApiUrl.updateService(id: id), body: body, multipartBody: multipartBody, reqType: "PUT");
  print("index 7");
      if (response.statusCode == 200) {
  print("index 8");
        await businessServiceController.getBusinessService();
        isEditLoading.value = false;
        AppRouter.route.pop();
      } else {
  print("index 9");
        isEditLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (error) {
      isEditLoading.value = false;
    }
  }




}