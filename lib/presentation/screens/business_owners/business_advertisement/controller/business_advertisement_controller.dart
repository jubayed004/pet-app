import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



class BusinessAdvertisementController extends GetxController {
  final RxList<File> images = <File>[].obs;
  final ImagePicker picker = ImagePicker();

  Future<void> pickMultipleImages() async {
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      images.addAll(pickedFiles.map((xfile) => File(xfile.path)).toList());
    }
  }

  void deleteImage(int index) {
    images.removeAt(index);
  }
}
