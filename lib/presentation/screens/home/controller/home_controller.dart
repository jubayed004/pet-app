

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/home/model/advertisment_model.dart';
import 'package:pet_app/presentation/screens/home/model/home_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class HomeController extends GetxController{

 final TextEditingController searchController = TextEditingController();
  final ApiClient apiClient = serviceLocator();
  RxBool isLoadingMove = false.obs;
  RxInt selectedIndex  = 0.obs;
 RxInt currentIndex = 0.obs;
 RxInt selectedTabIndex = 0.obs;

 final List<Widget> iconList = [
   Assets.icons.petvets.svg(),
   Assets.icons.petshops.svg(),
   Assets.icons.petgrooming.svg(),
   Assets.icons.pethotel.svg(),
   Assets.icons.pettraining.svg(),
   Assets.icons.friendlyplace.svg(),
 ];
 final List<String> stringList = [
   AppStrings.petVets,
   AppStrings.petShops,
   AppStrings.petGrooming,
   AppStrings.petHotels,
   AppStrings.petTraining,
   AppStrings.friendlyPlace,
 ];

 final List<String> imgList = [
   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
 ];

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


 /// ============================= GET Home Header =====================================
 var loading = Status.completed.obs;
 loadingMethod(Status status) => loading.value = status;
 final Rx<HomeHeaderModel> homeHeader = HomeHeaderModel().obs;

 Future<void> userHomeHeader() async{
   loadingMethod(Status.completed);
   try{
     loadingMethod(Status.loading);
     final response = await apiClient.get(url: ApiUrl.getHomeHeader());
     if (response.statusCode == 200) {
       final newData = HomeHeaderModel.fromJson(response.body);
       homeHeader.value = newData;
       loadingMethod(Status.completed);
     } else {
       if (response.statusCode == 503) {
         loadingMethod(Status.internetError);
       } else if (response.statusCode == 404) {
         loadingMethod(Status.noDataFound);
       } else {
         loadingMethod(Status.error);
       }
     }
   }catch(e){
     loadingMethod(Status.error);
   }
 }

 /// ✅ adsPic array from API
 RxList<List<String>> adsPic = <List<String>>[].obs;

 final PagingController<int, Ad> pagingController =
 PagingController(firstPageKey: 1);

 bool isRunning = false;


 Future<void> getAllAdvertisement({required int pageKey}) async {
   if (isRunning) return;
   isRunning = true;
   try {
     final response =
     await apiClient.get(url: ApiUrl.getAllAdvertisement(pageKey: pageKey));

     if (response.statusCode == 200) {
       final newData = AdvertisementModel.fromJson(response.body);

       /// ✅ store adsPic
       if (newData.adsPic != null) {
         adsPic.value = newData.adsPic!
             .map((group) => group.map((e) => e.toString()).toList())
             .toList();
       }

       final newItems = newData.ads ?? [];
       final current = newData.pagination?.currentPage ?? pageKey;
       final totalPages = newData.pagination?.totalPages ?? pageKey;

       final isLast = newItems.isEmpty || current >= totalPages;
       if (isLast) {
         pagingController.appendLastPage(newItems);
       } else {
         pagingController.appendPage(newItems, pageKey + 1);
       }
     } else {
       pagingController.error = 'An error occurred';
     }
   } catch (_) {
     pagingController.error = 'An error occurred';
   } finally {
     isRunning = false;
   }
 }


 @override
 void onInit() {
   super.onInit();
   userHomeHeader();

   pagingController.addPageRequestListener((pageKey) {
     getAllAdvertisement(pageKey: pageKey);
   });

   pagingController.refresh();
 }

 @override
 void onClose() {
   pagingController.dispose();
   super.onClose();
 }
}
