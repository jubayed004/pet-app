import 'package:get/get.dart';

class BookAnAppointmentController extends GetxController {
  RxInt selectedIndex = (-1).obs;
  void selectIndex(int index) {
    selectedIndex.value = index;
  }
}
