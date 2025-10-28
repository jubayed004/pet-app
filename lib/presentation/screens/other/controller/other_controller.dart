import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/other/model/other_model.dart';
import 'package:pet_app/presentation/screens/other/model/trams&condition_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class OtherController extends GetxController{
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();
  final bool isSubscription = false;

  /// ============================= GET Terms Condition =====================================

  final Rx<TermsConditionsModel> termsData = TermsConditionsModel().obs;
  var termsLoading = Status.completed.obs;
  termsLoadingMethod(Status status) => termsLoading.value = status;
  Future<void> getTermsCondition() async {
    try{
      termsLoadingMethod(Status.loading);
      var response = await apiClient.get(url: ApiUrl.getTerms());
      if (response.statusCode == 200) {
        termsData.value = TermsConditionsModel.fromJson(response.body);
        termsLoadingMethod(Status.completed);
      } else {
        if (response.statusCode == 503) {
          termsLoadingMethod(Status.internetError);
        } else if (response.statusCode == 404) {
          termsLoadingMethod(Status.noDataFound);
        } else {
          termsLoadingMethod(Status.error);
        }
      }
    }catch(e){
      termsLoadingMethod(Status.error);
    }

  }

  /// ============================= GET Privacy Policy =====================================

  final Rx<OtherModel> privacyData = OtherModel().obs;
  var privacyLoading = Status.completed.obs;
  privacyLoadingMethod(Status status) => privacyLoading.value = status;
  Future<void> getPrivacyPolicy() async {
    try{
      privacyLoadingMethod(Status.loading);
      var response = await apiClient.get(url: ApiUrl.privacyPolicy());
      if (response.statusCode == 200) {
        privacyData.value = OtherModel.fromJson(response.body);
        privacyLoadingMethod(Status.completed);
      } else {
        if (response.statusCode == 503) {
          privacyLoadingMethod(Status.internetError);
        } else if (response.statusCode == 404) {
          privacyLoadingMethod(Status.noDataFound);
        } else {
          privacyLoadingMethod(Status.error);
        }
      }
    }catch(e){
      privacyLoadingMethod(Status.error);
    }

  }



  /// ============================= POST Change Password =====================================
  var changePasswordLoading = false.obs;
  changePasswordLoadingMethod(bool loading) => changePasswordLoading.value = loading;

  Future<void> changePassword({required Map<String, String> body}) async {
   try{
      changePasswordLoadingMethod(true);
      var response = await apiClient.put(url: ApiUrl.changePassword(),body: body,isBasic: false);
      print(body);
      print(body.values);
      if (response.statusCode == 200) {
        changePasswordLoadingMethod(false);

        AppRouter.route.pop();
      } else {
        toastMessage(message: response.body?['message']?.toString());
        changePasswordLoadingMethod(false);
      }
    }catch(e){
      toastMessage();
      changePasswordLoadingMethod(false);
    }



  }

  /// ============================= DELETE Delete Account =====================================
  RxBool deleteLoading = false.obs;
  deleteMethod(bool status) => deleteLoading.value = status;
  final deletePassword = TextEditingController();

  void deleteAccount() async {
/*
    try{
      deleteMethod(true);
      final body = {
        "password": deletePassword.text
      };
      var response = await apiClient.post(body: body, url: ApiUrl.deleteUser());

      if (response.statusCode == 200) {
        deleteMethod(false);
        toastMessage(message: response.body?['message'].toString()??"something want wrong");
        await dbHelper.logOut();
      } else {
        deleteMethod(false);
        toastMessage(message: response.body?['message'].toString()??"something want wrong");
      }
    }catch (err){
      deleteMethod(false);
    }
*/



  }
  @override
  void onReady() {
    getPrivacyPolicy();
    getTermsCondition();
    super.onReady();
  }

}

