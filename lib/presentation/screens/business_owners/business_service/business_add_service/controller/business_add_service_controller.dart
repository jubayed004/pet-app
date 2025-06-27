import 'package:get/get.dart';

class BusinessAddServiceController extends GetxController{
  final List<String> analystType = [
    "Pet Vets",
    "Pet Grooming",
    "Pet Shops",
    "Pet Hotels",
    "Pet Training",
    "Friendly Place",
  ];

  final selectedAnalystType = ''.obs;
}