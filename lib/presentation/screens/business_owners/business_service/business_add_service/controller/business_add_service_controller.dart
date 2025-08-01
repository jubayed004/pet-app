import 'package:get/get.dart';

class BusinessAddServiceController extends GetxController{


  final selectedAnalystType = ''.obs;

  final List<String> analystType = [
    "Pet Vets",
    "Pet Grooming",
    "Pet Shops",
    "Pet Hotels",
    "Pet Training",
    "Friendly Place",
  ];

  final RxList<String> selectedAnalystTypes = <String>[].obs;

  void toggleSelection(String item) {
    if (selectedAnalystTypes.contains(item)) {
      selectedAnalystTypes.remove(item);
    } else {
      selectedAnalystTypes.add(item);
    }
  }
}