import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/auth/model/login_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class AuthController extends GetxController {
  RxBool rememberMe = false.obs;
  final ImagePicker _imagePicker = ImagePicker();
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();


  /// ============================= Login Account =====================================
  RxBool loginLoading = false.obs;
  RxBool isUser = true.obs;
  loginMethod(bool status) => loginLoading.value = status;

  ///Login
  ///yodihe8254@oziere.com
  ///siwonej364@framitag.com
/*  Future<void> login({required Map<String, String> body}) async {
    try {
      loginMethod(true);

      var response = await apiClient.post(body: body, url: ApiUrl.login(), isBasic: true);

      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(response.body);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(loginModel.accessToken ?? '');
        final role = decodedToken['role'] ?? "";

        // Only save if Remember Me is checked
        if (rememberMe.value) {
          await dbHelper.saveUserdata(
            token: loginModel.accessToken ?? '',
            id: decodedToken['id'] ?? "",
            email: loginModel.user?.email ?? "",
            role: role,
          );
        }

        loginMethod(false);

        // Navigate based on role
        if (role == "USER") {
          AppRouter.route.goNamed(RoutePath.navigationPage);
        } else {
          AppRouter.route.goNamed(RoutePath.businessNavigationPage);
        }

      } else {
        loginMethod(false);
        toastMessage(message: response.body?['message'].toString());
      }
    } catch (err) {
      loginMethod(false);
      toastMessage(message: err.toString());
    }
  }*/

  Future<void> login({required Map<String, String> body}) async {
    try {
      loginMethod(true);

      var response = await apiClient.post(body: body, url: ApiUrl.login(), isBasic: true);
      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(response.body);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(loginModel.accessToken??'');
      final role= decodedToken['role']??"";
        dbHelper.saveUserdata(
          token: loginModel.accessToken??'',
          id: decodedToken['id']??"",
          email: loginModel.user?.email ?? "",
          role:  role,
        ).then((value){
          loginMethod(false);
          if(role == "USER"){
            AppRouter.route.goNamed(RoutePath.navigationPage);
          }else{
            AppRouter.route.goNamed(RoutePath.businessNavigationPage);
          }
        }).onError((error,stack){
          loginMethod(false);
          toastMessage(message: error.toString());
        });
      } else {
        loginMethod(false);
        toastMessage(message: response.body?['message'].toString());
      }
    } catch (err) {
      loginMethod(false);
      print(err.toString());

    }
  }

  /// ============================= Forget Password =====================================
  RxBool forgetLoading = false.obs;
  forgetMethod(bool status) => forgetLoading.value = status;

  void forget({required String email}) async {
    try {
      forgetMethod(true);
      var response = await apiClient.post(body: {"email": email}, url: ApiUrl.forget(), isBasic: true);

      if (response.statusCode == 200) {
        forgetMethod(false);
        toastMessage(message: response.body?['message']?.toString());

        AppRouter.route.pushNamed(RoutePath.verifyOtpScreen, extra: email);
      } else {
        forgetMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      forgetMethod(false);
    }
  }

  /// ============================= Verify OTP =====================================
  RxBool otpLoading = false.obs;
  otpMethod(bool status) => otpLoading.value = status;


  void otpVerify({required String email, required String code}) async {
    try {
      otpMethod(true);
      final body = {
        "email": email,
        "code": code,
      };

      var response = await apiClient.post(body: body, url: ApiUrl.forgotOtp(), isBasic: true);

      if (response.statusCode == 200) {
        otpMethod(false);
        AppRouter.route.pushNamed(RoutePath.setNewPassword, extra: body);
        toastMessage(message: response.body?['message']?.toString());
      } else {
        otpMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      otpMethod(false);
    }

  }


  /// ============================= Resend OTP Forget Password =====================================
  RxBool resendOTPLoading = false.obs;
  resendOTPLoadingMethod(bool status) => resendOTPLoading.value = status;

  Future<void> resendOTP({required String email}) async {
    try {
      resendOTPLoadingMethod(true);
      var response = await apiClient.post(body: {"email": email}, url: ApiUrl.forget(), isBasic: true);
      if (response.statusCode == 200) {
        resendOTPLoadingMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      } else {
        resendOTPLoadingMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      resendOTPLoadingMethod(false);
    }
  }

  /// ============================= Reset Password =====================================
  RxBool resetLoading = false.obs;
  resetMethod(bool status) => resetLoading.value = status;


  void reset({ required Map<String, dynamic> body }) async {
    try {
      resetMethod(true);


      var response = await apiClient.post(body: body, url: ApiUrl.reset(), isBasic: true);

      if (response.statusCode == 200) {
        resetMethod(false);
        toastMessage(message: response.body?['message']?.toString());
        AppRouter.route.goNamed(RoutePath.signInScreen);

      } else {
        resetMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      resetMethod(false);
    }
  }

  /// ============================= Sign Up ===========================================
  RxBool signUpLoading = false.obs;
  signUpLoadingMethod(bool status) => signUpLoading.value = status;

  ///Sign Up
  final TextEditingController nameSignUp = TextEditingController();
  final TextEditingController emailSignUp = TextEditingController();
  final TextEditingController passwordSignUp = TextEditingController();
  final TextEditingController confirmPasswordSignUp = TextEditingController();
  final TextEditingController phoneNumberSignUp = TextEditingController();

  Future<void> signUp()  async {
    try{
      signUpLoadingMethod(true);
      final body = {
        "name": nameSignUp.text,
        "email": emailSignUp.text,
        "password": passwordSignUp.text,
        "confirmPassword": confirmPasswordSignUp.text,
        "phone":phoneNumberSignUp.text,
        "role": isUser.value? "user": "owner",
      };

      print(body);

      var response = await apiClient.post(body: body, url: ApiUrl.register(), isBasic: true);

      if (response.statusCode == 201) {
        signUpLoadingMethod(false);
        toastMessage(message: response.body?['message'].toString());
        final body ={
          "email": emailSignUp.text,
          "isSignUp": true,
        };
        AppRouter.route.pushNamed(RoutePath.accountActiveOtpScreen,extra: body);
        nameSignUp.clear();
        emailSignUp.clear();
        passwordSignUp.clear();
        confirmPasswordSignUp.clear();
        phoneNumberSignUp.clear();
      } else {
        signUpLoadingMethod(false);
        toastMessage(message: response.body?['message'].toString());
      }
    }catch (err){
      signUpLoadingMethod(false);
    }
  }

  /// ============================= Active Account Otp =====================================
  RxBool activeLoading = false.obs;
  activeMethod(bool status) => activeLoading.value = status;

  Future<void> activeAccount({required String email, required String code}) async {
    try {
      activeMethod(true);

      final body = {
        "email": email,
        "code":code
      };
      print("verifyOtpScreen1");
      var response = await apiClient.post(body: body, url: ApiUrl.activateOtp(), isBasic: true);
      print("verifyOtpScreen2");
      if (response.statusCode == 200) {
        final accessToken = response.body?['accessToken'];

        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken??'');
        final role = decodedToken['role'] ?? "";
        dbHelper.saveUserdata(
          token: accessToken??'',
          id: decodedToken['userId']??"",
          email: decodedToken['email']??"",
          role:  role,
        ).then((value){
          activeMethod(false);
      /*   AppRouter.route.goNamed(RoutePath.navigationPage,);*/
          if(role == "USER"){
            AppRouter.route.goNamed(RoutePath.petRegistrationScreen);

          }else{
            AppRouter.route.goNamed(RoutePath.petShopRegistrationScreen);
          }
         /* accountVerifyOtp.dispose();*/
        }).onError((error,stack){
          activeMethod(false);
          toastMessage(message: error.toString());
        });
      } else {
        activeMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      activeMethod(false);
    }
  }

  /// ============================= Resend OTP Account Active =====================================
  RxBool resendActiveLoading = false.obs;
  resendActiveLoadingMethod(bool status) => resendActiveLoading.value = status;
  Future<void> resendActiveOTP({required String email}) async {
    try {
      resendActiveLoadingMethod(true);
      var response = await apiClient.post(body: {"email": email}, url: ApiUrl.resendActiveOtp(), isBasic: true);
      if (response.statusCode == 200) {
        resendActiveLoadingMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      } else {
        resendActiveLoadingMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      resendActiveLoadingMethod(false);
    }
  }




  ///======================================Pet Shop Registration=======================================
  RxBool shopRegistrationUpLoading = false.obs;
  Rx<XFile?> selectedLogo = Rx<XFile?>(null);
  Rx<XFile?> selectedPic = Rx<XFile?>(null);
  shopRegistrationUpLoadingMethod(bool status) => shopRegistrationUpLoading.value = status;

  final TextEditingController businessName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController moreInfo = TextEditingController();

  Future<void> shopLogo() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selectedLogo.value = image;
    }
  }


  Future<void> shopPic() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selectedPic.value = image;
    }
  }
  Future<void> petShopRegistration()  async {
    try{
      shopRegistrationUpLoadingMethod(true);
      final body = {
        "businessName": businessName.text,
        "address": address.text,
        "website": website.text,
        "moreInfo": moreInfo.text,
      };
      final List<MultipartBody> multipartBody = [];
      if(selectedLogo.value != null){
        multipartBody.add(MultipartBody("shopLogo", File(selectedLogo.value?.path?? "")));
      }
      if(selectedPic.value != null){
        multipartBody.add(MultipartBody("shopPic", File(selectedPic.value?.path?? "")));
      }
      var response = await apiClient.multipartRequest(body: body, url: ApiUrl.shopRegistration(), reqType: 'POST', multipartBody: multipartBody);

      if (response.statusCode == 201) {
        shopRegistrationUpLoadingMethod(false);
        toastMessage(message: response.body?['message'].toString());

        AppRouter.route.pushNamed(RoutePath.subscriptionScreen,);
        businessName.clear();
        address.clear();
        website.clear();
        moreInfo.clear();
      } else {
        shopRegistrationUpLoadingMethod(false);
        toastMessage(message: response.body?['message'].toString());
      }
    }catch (err){
      shopRegistrationUpLoadingMethod(false);
    }
  }




  ///==========================================Pet Registration================================================

  var genderSelected = Rx<String>("MALE");
  RxBool petRegistrationUpLoading = false.obs;
  Rx<XFile?> selectedPetPhoto = Rx<XFile?>(null);
  petRegistrationUpLoadingMethod(bool status) => petRegistrationUpLoading.value = status;




  Future<void> petPhoto() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selectedPetPhoto.value = image;
    }
  }


  Future<void> petRegistration({required Map<String, String> body})  async {
    try{
      petRegistrationUpLoadingMethod(true);
      print(body);

      final List<MultipartBody> multipartBody = [];

      if(selectedPetPhoto.value != null){
        multipartBody.add(MultipartBody("petPhoto", File(selectedPetPhoto.value?.path?? "")));
      }
      var response = await apiClient.multipartRequest(body: body, url: ApiUrl.petRegistration(), reqType: 'POST', multipartBody: multipartBody);
      if (response.statusCode == 201) {
        petRegistrationUpLoadingMethod(false);
        toastMessage(message: response.body?['message'].toString());

        AppRouter.route.goNamed(RoutePath.navigationPage,);
      } else {
        petRegistrationUpLoadingMethod(false);
        toastMessage(message: response.body?['message'].toString());
      }
    }catch (err){
      petRegistrationUpLoadingMethod(false);
    }
  }

}

