import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class AuthController extends GetxController {
  RxBool rememberMe = false.obs;
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();


  /// ============================= Login Account =====================================
  RxBool loginLoading = false.obs;
  RxBool isUser = true.obs;
  loginMethod(bool status) => loginLoading.value = status;

  ///Login
  ///yodihe8254@oziere.com
  ///siwonej364@framitag.com
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> login() async {
/*    try {
      loginMethod(true);
      final body = {
        "email": email.text.trim(),
        "password": password.text
      };

      var response = await apiClient.post(body: body, url: ApiUrl.login(), isBasic: true);

      if (response.statusCode == 200) {

        final loginModel = LoginModel.fromJson(response.body);

        Map<String, dynamic> decodedToken = JwtDecoder.decode(loginModel.data?.accessToken??'');

        dbHelper.saveUserdata(
          token: loginModel.data?.accessToken??'',
          id: loginModel.data?.profileId??"",
          email: decodedToken['email']??"",
          role:  decodedToken['role']??"",
        ).then((value){
          loginMethod(false);
          AppRouter.route.goNamed(RoutePath.navigationPage);
          email.clear();
          password.clear();
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
    }*/
  }

  /// ============================= Forget Password =====================================
  RxBool forgetLoading = false.obs;
  forgetMethod(bool status) => forgetLoading.value = status;
  final TextEditingController forgetEmail = TextEditingController();

  void forget() async {
/*    try {
      forgetMethod(true);
      var response = await apiClient.post(body: {"email": forgetEmail.text}, url: ApiUrl.forget(), isBasic: true);

      if (response.statusCode == 200) {
        forgetMethod(false);
        toastMessage(message: response.body?['message']?.toString());
        final body = {
          "email":forgetEmail.text,
          "isSignUp": false,
        };
        AppRouter.route.pushNamed(RoutePath.verifyOtpScreen, extra: body);
        forgetEmail.clear();
      } else {
        forgetMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      forgetMethod(false);
    }*/
  }

  /// ============================= Verify OTP =====================================
  RxBool otpLoading = false.obs;
  otpMethod(bool status) => otpLoading.value = status;
  final TextEditingController verifyOtp = TextEditingController();

  void otpVerify({required String email}) async {
/*    try {
      otpMethod(true);
      final body = {
        "email": email,

      };

      var response = await apiClient.post(body: body, url: ApiUrl.forgotOtp(), isBasic: true);

      if (response.statusCode == 200) {

        otpMethod(false);
        AppRouter.route.pushNamed(RoutePath.setNewPassword, extra: email);
        verifyOtp.clear();
        toastMessage(message: response.body?['message']?.toString());
      } else {
        otpMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      otpMethod(false);
    }*/

  }


  /// ============================= Resend OTP Forget Password =====================================
  RxBool resendOTPLoading = false.obs;
  resendOTPLoadingMethod(bool status) => resendOTPLoading.value = status;

  Future<void> resendOTP({required String email}) async {
/*    try {
      resendOTPLoadingMethod(true);
      var response = await apiClient.post(body: {"email": forgetEmail.text}, url: ApiUrl.forget(), isBasic: true);
      if (response.statusCode == 200) {
        resendOTPLoadingMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      } else {
        resendOTPLoadingMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      resendOTPLoadingMethod(false);
    }*/
  }

  /// ============================= Reset Password =====================================
  RxBool resetLoading = false.obs;
  resetMethod(bool status) => resetLoading.value = status;
  final TextEditingController resetPassword = TextEditingController();
  final TextEditingController resetConfirmPassword = TextEditingController();

  void reset({required String email}) async {
/*    try {
      resetMethod(true);
      final body = {
        "email": email,
        "password": resetPassword.text,
        "confirmPassword": resetConfirmPassword.text
      };

      var response = await apiClient.post(body: body, url: ApiUrl.reset(), isBasic: true);

      if (response.statusCode == 200) {
        resetMethod(false);
        toastMessage(message: response.body?['message']?.toString());
        AppRouter.route.goNamed(RoutePath.signInScreen);
        resetPassword.clear();
        resetConfirmPassword.clear();
      } else {
        resetMethod(false);
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (err) {
      resetMethod(false);
    }*/
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
/*    try{
      signUpLoadingMethod(true);
      final body = {
        "name": nameSignUp.text,
        "email": emailSignUp.text,
        "password": passwordSignUp.text,
        "confirmPassword": confirmPasswordSignUp.text,
        "phoneNumber":phoneNumberSignUp.text,
        "role": "USER"

      };

      var response = await apiClient.post(body: body, url: ApiUrl.register(),isBasic: true);

      if (response.statusCode == 200) {
        signUpLoadingMethod(false);
        toastMessage(message: response.body?['message'].toString());
        final body ={
          "email": emailSignUp.text,
          "isSignUp": true,
        };
        AppRouter.route.pushNamed(RoutePath.verifyOtpScreen, extra: body);
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
    }*/
  }

  /// ============================= Active Account Otp =====================================
  RxBool activeLoading = false.obs;
  activeMethod(bool status) => activeLoading.value = status;

  ///Active Account
  final TextEditingController accountVerifyOtp = TextEditingController();

  Future<void> activeAccount({required String email}) async {
/*    try {
      activeMethod(true);

      final body = {
        "email": email,
        "activationCode": accountVerifyOtp.text.trim()
      };
      print("verifyOtpScreen1");
      var response = await apiClient.post(body: body, url: ApiUrl.activateOtp(), isBasic: true);
      print("verifyOtpScreen2");
      if (response.statusCode == 201) {
        final accessToken = response.body?['data']?['accessToken'];

        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken??'');

        dbHelper.saveUserdata(
          token: accessToken??'',
          id: decodedToken['userId']??"",
          email: decodedToken['email']??"",
          role:  decodedToken['role']??"",
        ).then((value){
          activeMethod(false);
         AppRouter.route.goNamed(RoutePath.navigationPage,);
          accountVerifyOtp.clear();
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
    }*/
  }

  /// ============================= Resend OTP Account Active =====================================
  RxBool resendActiveLoading = false.obs;
  resendActiveLoadingMethod(bool status) => resendActiveLoading.value = status;
  Future<void> resendActiveOTP({required String email}) async {
/*    try {
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
    }*/
  }

}
