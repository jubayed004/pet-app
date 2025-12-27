

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/review/search/model/country_city_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class SearchScreenController extends GetxController{
  final ApiClient apiClient = serviceLocator();

  final TextEditingController searchController = TextEditingController();

  final PagingController<int, ServiceItem> pagingController = PagingController(firstPageKey: 1);
  final RxString search = "".obs;
  RxBool isLoadingMove = false.obs;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getAllSearch(pageKey);
    });
  }


  Future<void> getAllSearch( int pageKey ) async {


  if (isLoadingMove.value) return;
    isLoadingMove.value = true;

    try {
      final response = await apiClient.get(url: ApiUrl.getAllSearch(
        pageKey: pageKey,
      ));

      if (response.statusCode == 200) {
        final SearchHomeModel searchHomeModel = SearchHomeModel.fromJson(response.body);

        final newItems = searchHomeModel.services ?? [];

        final isLastPage = newItems.length < pageKey;

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error = 'Failed to load notifications';
      }
    } catch (e) {
      pagingController.error = 'Something went wrong';
    } finally {
      isLoadingMove.value = false;
    }

  }
/*
  Rx<Status> countryCity = Status.loading.obs;
  Rx<CountryCityModel> countryCityModel = CountryCityModel().obs;

  void getCountryCity() async {
    try {
      countryCity(Status.loading);
      var response = await apiClient.get(url: ApiUrl.getCountryCity());
      print(response);
      if (response.statusCode == 200) {
        countryCityModel.value = CountryCityModel.fromJson(response.body);
        countryCity(Status.completed);
      } else {
        countryCity(Status.error);
      }
    } catch (err) {
      countryCity(Status.error);
    }
  }
*/





  @override
  void onReady() {

    super.onReady();

   // getCountryCity();
  }

}
