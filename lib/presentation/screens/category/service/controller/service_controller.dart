import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class ServiceController extends GetxController{
  final RxString selectedPet = "".obs;
  final RxString selectedService = "".obs;
  final Rx<TimeOfDay?> openingTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> closingTime = Rx<TimeOfDay?>(null);
  final Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
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

  final ApiClient apiClient = serviceLocator();
  var appointmentLoading = false.obs;
  appointmentLoadingMethod(bool loading) => appointmentLoading.value = loading;

  Future<void> bookingAppointmentService({required Map<String, String> body}) async {
    try{
      appointmentLoadingMethod(true);
      var response = await apiClient.post(url: ApiUrl.bookingAppointment(),body: body,isBasic: false);
      print(body);
      print(body.values);
      if (response.statusCode == 201) {
        appointmentLoadingMethod(false);
        AppRouter.route.pushNamed(RoutePath.congratulationScreen);
       // AppRouter.route.pop();
      } else {
        toastMessage(message: response.body?['message']?.toString());
        appointmentLoadingMethod(false);
      }
    }catch(e){
      toastMessage();
      appointmentLoadingMethod(false);
    }


  }




}