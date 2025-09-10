import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/screens/explore/model/map_category_details_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
class ExploreController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();

  Future<void> _startLocationSharing() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("Location service is disabled.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint("Location permission denied by user.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint("Location permission permanently denied.");
        openAppSettings();
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        )
      );

      final latLng = LatLng(
        position.latitude,
        position.longitude,
      );
      getMapDetailsCategory(type: '', lat: latLng.latitude.toString(), long: latLng.longitude.toString());
    } catch (e) {
      debugPrint("Location fetch error: $e");
    }
  }

  /// ============================= GET Home Header =====================================
  var loading = Status.completed.obs;
  loadingMethod(Status status) => loading.value = status;
  final Rx<MapCategoryDetailsModel> mapDetailsCategory = MapCategoryDetailsModel().obs;

  Future<void> getMapDetailsCategory({required String type,required String lat,required String long,}) async{
    loadingMethod(Status.completed);
    try{
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getMapDetailsCategory(type: type, lat: lat, long: long));
      if (response.statusCode == 200) {
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



}