
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class BusinessAdvertisementController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final ImagePicker _imagePicker = ImagePicker();
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
    /*    await businessServiceController.getBusinessService();
        isLoading.value = false;
        AppRouter.route.pop();*/
      }else{
        isLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    }catch(error){
      isLoading.value = false;
    }
  }


/*
  void deleteImage(int index) {
    selectedImage.removeAt(index);
  }*/
}
