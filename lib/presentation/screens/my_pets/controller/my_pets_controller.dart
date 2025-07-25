import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class MyPetsProfileController extends GetxController {

  final ImagePicker _imagePicker = ImagePicker();
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();

  /// ============================= GET Profile Info =====================================
  var loading = Status.completed.obs;
  loadingMethod(Status status) => loading.value = status;
  //final Rx<ProfileModel> profile = ProfileModel().obs;
  final RxBool isAdmin = false.obs;

  Future<void> getProfile() async{
/*    loadingMethod(Status.completed);
    try{
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.profile());
      if (response.statusCode == 200) {
        final newData = ProfileModel.fromJson(response.body);
        profile.value = newData;
        name = TextEditingController(text: newData.data?.name??"");
        email = TextEditingController(text: newData.data?.email?? "");
        number = TextEditingController(text: newData.data?.phoneNumber?? "");

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
    }*/

  }

  /// ============================= PUT Profile Update =====================================

  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  RxBool isUpdateLoading = false.obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();

  Future<void> pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> updateProfile() async{
/*    try{
      isUpdateLoading.value = true;

      final body = {
        "name": name.text,
        "phoneNumber": number.text,

      };

      final List<MultipartBody> multipartBody = [];
      if(selectedImage.value != null){
        multipartBody.add(MultipartBody("profile_image", File(selectedImage.value?.path?? "")));
      }

      print(body);
      final response = await apiClient.multipartRequest(url: ApiUrl.updateProfile(), body: body, multipartBody: multipartBody, reqType: "PATCH");

      if(response.statusCode == 200){
        await getProfile();
        isUpdateLoading.value = false;
        AppRouter.route.pop();
      }else{
        isUpdateLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    }catch(error){
      isUpdateLoading.value = false;
    }*/
  }
  ///=================================give feedback=======================///
  TextEditingController subject = TextEditingController();
  TextEditingController feedback = TextEditingController();

  Future<void> giveFeedback() async{
/*    try{
      isUpdateLoading.value = true;
      final body = {
        "subject": subject.text,
        "feedback": feedback.text,

      };
      final response = await apiClient.post(url: ApiUrl.giveFeedbacks(), body: body,);
      if(response.statusCode == 200){
        isUpdateLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
        subject.clear();
        feedback.clear();
        AppRouter.route.pop();



      }else{
        toastMessage(message: response.body?['message']?.toString());
        isUpdateLoading.value = false;

      }
    }catch(error){
      isUpdateLoading.value = false;
    }*/
  }

  var petList = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPets();
  }

  void loadPets() {
    petList.value = [
      {
        "name": "Bella",
        "image": "https://images.unsplash.com/photo-1558788353-f76d92427f16"
      },
      {
        "name": "Rocky",
        "image": "https://images.unsplash.com/photo-1518717758536-85ae29035b6d"
      },

      {
        "name": "Champ",
        "image": "https://images.unsplash.com/photo-1560807707-8cc77767d783"
      },
      {
        "name": "Champ",
        "image": "https://images.unsplash.com/photo-1574158622682-e40e69881006"
      },
    ];
  }

  void onPetTap(int index) {
    print("Tapped: ${petList[index]['name']}");
  }



  Future<void> getAdmin() async{
    final role = await dbHelper.getUserRole();
    print(role);
    if(role == "superAdmin"){
      isAdmin.value = true;
    }
  }

  @override
  void onReady() {
    Future.wait([
      getAdmin(),
      getProfile(),
    ]);
    super.onReady();
  }
}
