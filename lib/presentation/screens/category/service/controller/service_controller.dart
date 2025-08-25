import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController{


  final Rx<TimeOfDay?> openingTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> closingTime = Rx<TimeOfDay?>(null);
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

}