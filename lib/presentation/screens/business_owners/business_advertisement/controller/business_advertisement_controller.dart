import 'dart:io';
import 'package:flutter/foundation.dart';
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

  final RxList<XFile> selectedImages = <XFile>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> pickImage() async {
    try {
      final images = await _imagePicker.pickMultiImage(imageQuality: 80);
      if (images.isEmpty) return;
      final remaining = 5 - selectedImages.length;
      if (remaining <= 0) {
        toastMessage(message: "You can only select up to 5 images.");
        return;
      }
      selectedImages.addAll(images.take(remaining));
      if (images.length > remaining) {
        toastMessage(message: "Only $remaining more images added (max 5).");
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('pickImage error: $e\n$s');
      }
      toastMessage(message: "Could not pick images.");
    }
  }

  Future<void> addAdvertisement() async {
    if (selectedImages.isEmpty) {
      toastMessage(message: "Please add at least one image.");
      return;
    }

    try {
      isLoading.value = true;

      final List<MultipartBody> multipartBody = [];
      for (final x in selectedImages) {
        if (x.path.isNotEmpty) {
          multipartBody.add(MultipartBody("advertisementImg", File(x.path)));
        }
      }

      if (kDebugMode) {
        print('multipartBody length: ${multipartBody.length}');
      }

      final response = await apiClient.multipartRequest(
        url: ApiUrl.addAdvertisement(),
        body: {},
        multipartBody: multipartBody,
        reqType: "POST",
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        AppRouter.route.pop();
      } else {
        isLoading.value = false;
        toastMessage(
          message: response.body?['message']?.toString() ?? "Failed",
        );
      }
    } catch (error, s) {
      if (kDebugMode) {
        print('addAdvertisement error: $error\n$s');
      }
      isLoading.value = false;
      toastMessage(message: "Something went wrong.");
    }
  }

  void deleteImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }
}
