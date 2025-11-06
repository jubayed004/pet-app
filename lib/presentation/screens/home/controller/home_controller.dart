import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/home/model/advertisment_model.dart';
import 'package:pet_app/presentation/screens/home/model/home_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

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
    "Pet Vets",
    "Pet Shops",
    "Pet Grooming",
    "Pet Hotels",
    "Pet Training",
    "Friendly Place",
  ];

  /// ============================= GET Home Header =====================================

  var loading = Status.completed.obs;

  final Rx<HomeHeaderModel> homeHeader = HomeHeaderModel().obs;

  void loadingMethod(Status status) => loading.value = status;

  Future<void> userHomeHeader() async {
    loadingMethod(Status.loading);
    try {
      final response = await apiClient.get(url: ApiUrl.getHomeHeader());
      log.i('GET ${ApiUrl.getHomeHeader()} → ${response.statusCode}');

      if (response.statusCode == 200) {

        final data = HomeHeaderModel.fromJson(response.body);

        log.d(data.toJson());

        homeHeader.value = data;

        loadingMethod(Status.completed);

      } else if (response.statusCode == 503) {
        loadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        loadingMethod(Status.noDataFound);
      } else {
        loadingMethod(Status.error);
      }
    } catch (e, st) {
      log.e('userHomeHeader() failed', error: e, stackTrace: st);
      loadingMethod(Status.error);
    }
  }

  /// ============================= GET Advertisement =====================================

  RxList<String> adsPic = <String>[].obs;
  RxBool isRunning = false.obs;

  Future<void> getAllAdvertisement() async {
    if (isRunning.value) return;
    isRunning.value = true;

    try {
      final response = await apiClient.get(url: ApiUrl.getAllAdvertisement());
      log.i('GET ${ApiUrl.getAllAdvertisement()} → ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = AdvertisementModel.fromJson(response.body);
        log.d(data.toJson());
        final items = data.ads ?? [];
        adsPic.clear();
        for (final ad in items) {
          final imgs = ad.advertisementImg ?? [];
          for (final path in imgs) {
            final clean = path.replaceAll('\\', '/');
            final fullUrl = "${ApiUrl.imageBase}$clean";
            if (Uri.tryParse(fullUrl)?.isAbsolute ?? false) {
              adsPic.add(fullUrl);
            } else {
              log.w('Invalid image URL skipped: $fullUrl');
            }
          }
        }
      } else {
        log.w('Advertisement request failed (${response.statusCode})');
      }
    } catch (e, st) {
      log.e('getAllAdvertisement() failed', error: e, stackTrace: st);
    } finally {
      isRunning.value = false;
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
