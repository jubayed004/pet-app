import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/business_owners/business_advertisement/model/details_advertisement_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessAdvertisementController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final ImagePicker _imagePicker = ImagePicker();

  // Observables
  final RxList<XFile> selectedImages = <XFile>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<Status> loading = Status.completed.obs;
  final Rx<DetailsAdvertisementModel> profile = DetailsAdvertisementModel().obs;

  // Constants
  static const int maxImageCount = 5;
  static const int imageQuality = 80;

  /// Pick images from gallery
  Future<void> pickImage() async {
    try {
      final images = await _imagePicker.pickMultiImage(
        imageQuality: imageQuality,
      );

      if (images.isEmpty) {
        if (kDebugMode) {
          print('No images selected');
        }
        return;
      }

      final remaining = maxImageCount - selectedImages.length;

      if (remaining <= 0) {
        toastMessage(message: "Maximum $maxImageCount images allowed");
        return;
      }

      final imagesToAdd = images.take(remaining).toList();
      selectedImages.addAll(imagesToAdd);

      if (images.length > remaining) {
        toastMessage(
          message: "Added $remaining image${remaining > 1 ? 's' : ''} (max $maxImageCount)",
        );
      } else {
        toastMessage(
          message: "${imagesToAdd.length} image${imagesToAdd.length > 1 ? 's' : ''} selected",
        );
      }

      if (kDebugMode) {
        print('Total images selected: ${selectedImages.length}');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('pickImage error: $e\n$stackTrace');
      }
      toastMessage(message: "Failed to select images. Please try again.");
    }
  }

  /// Delete image at specific index
  void deleteImage(int index) {
    try {
      if (index >= 0 && index < selectedImages.length) {
        selectedImages.removeAt(index);
        toastMessage(message: "Image removed");

        if (kDebugMode) {
          print('Image deleted at index: $index');
          print('Remaining images: ${selectedImages.length}');
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('deleteImage error: $e\n$stackTrace');
      }
      toastMessage(message: "Failed to remove image");
    }
  }

  /// Clear all selected images
  void clearAllImages() {
    try {
      selectedImages.clear();
      toastMessage(message: "All images cleared");

      if (kDebugMode) {
        print('All images cleared');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('clearAllImages error: $e\n$stackTrace');
      }
    }
  }

  /// Add Advertisement
  Future<void> addAdvertisement() async {
    // Validation
    if (selectedImages.isEmpty) {
      toastMessage(message: "Please select at least one image");
      return;
    }

    // Prevent double submission
    if (isLoading.value) {
      if (kDebugMode) {
        print('Already submitting, ignoring duplicate request');
      }
      return;
    }

    try {
      isLoading.value = true;

      // Prepare multipart body
      final List<MultipartBody> multipartBody = [];

      for (int i = 0; i < selectedImages.length; i++) {
        final imagePath = selectedImages[i].path;

        if (imagePath.isEmpty) {
          if (kDebugMode) {
            print('Skipping empty path at index $i');
          }
          continue;
        }

        final file = File(imagePath);

        // Check if file exists
        if (!await file.exists()) {
          if (kDebugMode) {
            print('File does not exist at path: $imagePath');
          }
          continue;
        }

        multipartBody.add(MultipartBody("advertisementImg", file));
      }

      if (multipartBody.isEmpty) {
        isLoading.value = false;
        toastMessage(message: "No valid images to upload");
        return;
      }

      if (kDebugMode) {
        print('Uploading ${multipartBody.length} images');
      }

      // Make API request
      final response = await apiClient.multipartRequest(
        url: ApiUrl.addAdvertisement(),
        body: {},
        multipartBody: multipartBody,
        reqType: "POST",
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Success
        toastMessage(message: "Advertisement published successfully!");

        // Clear selected images
        selectedImages.clear();

        // Navigate to details screen
        await AppRouter.route.pushNamed(
          RoutePath.businessDetailsAdvertisementScreen,
        );

        if (kDebugMode) {
          print('Advertisement added successfully');
        }
      } else {
        // Handle error response
        final errorMessage = response.body?['message']?.toString() ??
            "Failed to publish advertisement";
        toastMessage(message: errorMessage);

        if (kDebugMode) {
          print('API Error: ${response.statusCode} - $errorMessage');
        }
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('addAdvertisement error: $error\n$stackTrace');
      }
      toastMessage(message: "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Update loading status
  void loadingMethod(Status status) {
    loading.value = status;

    if (kDebugMode) {
      print('Loading status changed to: $status');
    }
  }

  /// Get Advertisement Details
  Future<void> getDetailsAdvertisement() async {
    loadingMethod(Status.loading);

    try {
      final response = await apiClient.get(
        url: ApiUrl.getAdvertisement(),
      );

      if (kDebugMode) {
        print('Get Advertisement Response: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        // Parse response
        try {
          final newData = DetailsAdvertisementModel.fromJson(response.body);
          profile.value = newData;

          final adCount = newData.advertisement?.length ?? 0;

          if (adCount == 0) {
            loadingMethod(Status.noDataFound);
          } else {
            loadingMethod(Status.completed);
          }

          if (kDebugMode) {
            print('Loaded $adCount advertisements');
          }
        } catch (parseError) {
          if (kDebugMode) {
            print('JSON parsing error: $parseError');
          }
          loadingMethod(Status.error);
        }
      } else if (response.statusCode == 503) {
        loadingMethod(Status.internetError);
        toastMessage(message: "Service unavailable. Please try again.");
      } else if (response.statusCode == 404) {
        loadingMethod(Status.noDataFound);
      } else if (response.statusCode == 401) {
        loadingMethod(Status.error);
        toastMessage(message: "Unauthorized. Please login again.");
      } else {
        loadingMethod(Status.error);
        final errorMsg = response.body?['message']?.toString() ??
            "Failed to load advertisements";
        toastMessage(message: errorMsg);
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('getDetailsAdvertisement error: $error\n$stackTrace');
      }

      // Check if it's a network error
      if (error.toString().contains('SocketException') ||
          error.toString().contains('TimeoutException')) {
        loadingMethod(Status.internetError);
        toastMessage(message: "No internet connection");
      } else {
        loadingMethod(Status.error);
        toastMessage(message: "Failed to load data");
      }
    }
  }

  /// Refresh advertisements
  Future<void> refreshAdvertisements() async {
    try {
      await getDetailsAdvertisement();
    } catch (e) {
      if (kDebugMode) {
        print('Refresh error: $e');
      }
    }
  }

  /// Get active advertisements count
  int get activeAdvertisementsCount {
    final advertisements = profile.value.advertisement ?? [];
    return advertisements.where((ad) => ad.status == "ACTIVE").length;
  }

  /// Get inactive advertisements count
  int get inactiveAdvertisementsCount {
    final advertisements = profile.value.advertisement ?? [];
    return advertisements.where((ad) => ad.status == "INACTIVE").length;
  }

  /// Get total advertisements count
  int get totalAdvertisementsCount {
    return profile.value.advertisement?.length ?? 0;
  }

  @override
  void onClose() {
    // Clean up resources
    selectedImages.clear();
    if (kDebugMode) {
      print('BusinessAdvertisementController disposed');
    }
    super.onClose();
  }
}