import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/business_owners/business_shop_profile/model/business_shop_profile_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessShopProfileController extends GetxController {
  final ApiClient _apiClient = serviceLocator<ApiClient>();
  final ImagePicker _imagePicker = ImagePicker();

  // Observable loading status
  final Rx<Status> _loading = Status.completed.obs;
  Status get loading => _loading.value;

  // Observable shop profile
  final Rx<BusinessShopProfileModel?> _shopProfile =
  Rx<BusinessShopProfileModel?>(null);
  BusinessShopProfileModel? get shopProfile => _shopProfile.value;

  // Error message
  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  // Update loading state
  final RxBool _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;

  // Image pickers for update (private Rx fields)
  final Rx<XFile?> _selectedLogo = Rx<XFile?>(null);
  final Rx<XFile?> _selectedShopPic = Rx<XFile?>(null);

  // Public getters (value + Rx versions)
  XFile? get selectedLogo => _selectedLogo.value;
  XFile? get selectedShopPic => _selectedShopPic.value;

  // <-- expose Rx so widgets can listen reactively
  Rx<XFile?> get selectedLogoRx => _selectedLogo;
  Rx<XFile?> get selectedShopPicRx => _selectedShopPic;

  /// Update loading status
  void _setLoadingStatus(Status status) {
    _loading.value = status;
  }

  /// Get Business Shop Profile
  Future<void> getBusinessShopProfile() async {
    _setLoadingStatus(Status.completed);
    try {
      _setLoadingStatus(Status.loading);
      final response = await _apiClient.get(url: ApiUrl.getBusinessShopProfile());

      if (response.statusCode == 200) {
        final data = BusinessShopProfileModel.fromJson(response.body);
        _shopProfile.value = data;
        _setLoadingStatus(Status.completed);
      } else {
        if (response.statusCode == 503) {
          _setLoadingStatus(Status.internetError);
        } else if (response.statusCode == 404) {
          _setLoadingStatus(Status.noDataFound);
        } else {
          _setLoadingStatus(Status.error);
        }
      }
    } catch (e) {
      _setLoadingStatus(Status.error);
    }
  }

  /// Pick Logo Image
  Future<void> pickLogoImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (image != null) {
        _selectedLogo.value = image;
      }
    } catch (e) {
      toastMessage(message: 'Failed to pick image: ${e.toString()}');
    }
  }

  /// Pick Shop Picture
  Future<void> pickShopPicture() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      if (image != null) {
        _selectedShopPic.value = image;
      }
    } catch (e) {
      toastMessage(message: 'Failed to pick image: ${e.toString()}');
    }
  }

  /// Update Shop Profile
  Future<void> updateShopProfile({
    required String businessName,
    required String address,
    String? website,
  }) async {
    try {
      _isUpdateLoading.value = true;

      final Map<String, String> body = {
        'businessName': businessName.trim(),
        'address': address.trim(),
      };

      if (website != null && website.isNotEmpty) {
        body['website'] = website.trim();
      }

      final List<MultipartBody> multipartBody = [];

      if (_selectedLogo.value != null) {
        multipartBody.add(
          MultipartBody('shopLogo', File(_selectedLogo.value!.path)),
        );
      }

      if (_selectedShopPic.value != null) {
        multipartBody.add(
          MultipartBody('shopPic', File(_selectedShopPic.value!.path)),
        );
      }

      final response = await _apiClient.multipartRequest(
        url: ApiUrl.updateProfile(),
        body: body,
        multipartBody: multipartBody,
        reqType: "PUT",
      );

      if (response.statusCode == 200) {
        toastMessage(message: 'Profile updated successfully');
        await getBusinessShopProfile();
        clearSelectedImages();
        AppRouter.route.pop();
      } else {
        final errorMsg =
            response.body?['message']?.toString() ?? 'Failed to update profile';
        toastMessage(message: errorMsg);
      }
    } catch (error) {
      toastMessage(message: 'Error updating profile: ${error.toString()}');
    } finally {
      _isUpdateLoading.value = false;
    }
  }

  void clearSelectedImages() {
    _selectedLogo.value = null;
    _selectedShopPic.value = null;
  }

  Future<void> refreshProfile() async {
    await getBusinessShopProfile();
  }

  void updateLocalProfile(BusinessShopProfileModel updatedProfile) {
    _shopProfile.value = updatedProfile;
  }

  void clearError() {
    _errorMessage.value = '';
  }

  Business? get currentBusiness {
    final businesses = _shopProfile.value?.business;
    if (businesses != null && businesses.isNotEmpty) {
      return businesses.first;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    getBusinessShopProfile();
  }

  @override
  void onClose() {
    _loading.close();
    _shopProfile.close();
    _errorMessage.close();
    _isUpdateLoading.close();
    _selectedLogo.close();
    _selectedShopPic.close();
    super.onClose();
  }
}
