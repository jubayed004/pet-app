import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/home/model/advertisment_model.dart';
import 'package:pet_app/presentation/screens/home/model/home_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final ApiClient apiClient = serviceLocator();
  RxBool isLoadingMove = false.obs;
  RxInt selectedIndex = 0.obs;
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





  /// ============================= GET Home Header =====================================
  var loading = Status.completed.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<HomeHeaderModel> homeHeader = HomeHeaderModel().obs;

  Future<void> userHomeHeader() async {
    loadingMethod(Status.completed);
    try {
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
    } catch (e) {
      loadingMethod(Status.error);
    }
  }

  RxList<String> adsPic = RxList([]);
  RxBool isRunning = false.obs; // <-- now reactive

  Future<void> getAllAdvertisement() async {
    if (isRunning.value) return; // check reactive value
    isRunning.value = true; // set reactive value

    try {
      final response = await apiClient.get(url: ApiUrl.getAllAdvertisement());

      if (response.statusCode == 200) {
        final newData = AdvertisementModel.fromJson(response.body);
        final newItems = newData.ads ?? [];

        adsPic.clear();

        for (final ad in newItems) {
          if (ad.advertisementImg != null && ad.advertisementImg!.isNotEmpty) {
            for (final e in ad.advertisementImg!) {
              final url = "${ApiUrl.imageBase}${e.replaceAll('\\', '/')}";
              if (Uri.tryParse(url)?.isAbsolute ?? false) {
                adsPic.add(url);
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching ads: $e");
    } finally {
      isRunning.value = false; // reset reactive value
    }
  }


  @override
  void onReady() {
    super.onReady();
    Future.wait([
      userHomeHeader(),
      getAllAdvertisement(),
    ]);
  }
}
