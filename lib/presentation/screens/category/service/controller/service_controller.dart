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
  final Rx<TimeOfDay?> bookingTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> checkingTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> checkoutTime = Rx<TimeOfDay?>(null);
  final Rx<DateTime> bookingDate = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> checkingDate = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> checkoutDate = Rx<DateTime>(DateTime.now());
  Future<void> pickBookingTime(BuildContext context) async {
    final initial = bookingTime.value ?? TimeOfDay.now();
    final result = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (result != null) bookingTime.value = result;
  }
  Future<void> pickCheckingTime(BuildContext context) async {
    final initial = checkingTime.value ?? TimeOfDay.now();
    final result = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (result != null) checkingTime.value = result;
  }
  Future<void> pickCheckoutTime(BuildContext context) async {
    final initial = checkoutTime.value ?? TimeOfDay.now();
    final result = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (result != null) checkoutTime.value = result;
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