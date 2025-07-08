import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class CategoryController extends GetxController{
  final List<PagingController<int, String>> pagingController = [
    PagingController(firstPageKey: 1),
    PagingController(firstPageKey: 1),
    PagingController(firstPageKey: 1),
    PagingController(firstPageKey: 1),
    PagingController(firstPageKey: 1),
    PagingController(firstPageKey: 1),
  ];

  Future<void> getMyAppointment({required int pageKey, required PagingController<int, String> controller}) async {
    try{
      await Future.delayed(Duration(seconds: 1));

      if(pageKey == 3){
        controller.appendLastPage([]);
      }else{
        final item = [
          "Apple",
          "Orange",
          "Bird",
          "Lemon",
          "Mango",
          "banana"
        ];
        controller.appendPage(item, pageKey + 1);
      }
    }catch(_){
      controller.error = "error";
    }
  }

  @override
  void onInit() {
    super.onInit();
    for (var action in pagingController) {
      action.addPageRequestListener((pageKey){
        getMyAppointment(pageKey: pageKey, controller: action);
      });
    }
  }
}