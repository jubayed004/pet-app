

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/service/api_service.dart';

class HomeController extends GetxController{
 final PagingController<int, String> pagingController = PagingController(firstPageKey: 1);
 final TextEditingController searchController = TextEditingController();
  final ApiClient apiClient = serviceLocator();
  RxBool isLoadingMove = false.obs;
  RxInt selectedIndex  = 0.obs;
 RxInt currentIndex = 0.obs;


  Future<void> getProject(int pageKey) async {





/*    if (isLoadingMove.value) return;
    isLoadingMove.value = true;
    try {
       final response = await apiClient.get(url: ApiUrl.getAllPost(pageKey: pageKey,));
      if (response.statusCode == 200) {
        final userServiceAll = HomeModel.fromJson(response.body);
        final newItems = userServiceAll.data?.posts ?? [];
        if (newItems.isEmpty) {
          isLoadingMove.value = false;
        } else {
          isLoadingMove.value = false;
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        isLoadingMove.value = false;
        pagingController.error = 'Error fetching data';
      }
    } catch (e) {
      pagingController.error = 'An error occurred';
    } finally {
      isLoadingMove.value = false;
    }*/
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
    getProject(pageKey);
    });
    super.onInit();
  }
}
