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
  final ApiClient apiClient = serviceLocator<ApiClient>();
  final DBHelper dbHelper = serviceLocator<DBHelper>();
  var loading = Status.completed.obs;
  final RxSet<Marker> markers = <Marker>{}.obs;
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  Future<void> startLocationSharing({required String type}) async {
    try {
      loadingMethod(Status.loading);
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("Location service is disabled.");
        await Geolocator.openLocationSettings();
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
        await openAppSettings();
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      final latLng = LatLng(position.latitude, position.longitude);
      currentLocation.value = latLng;
      getMapDetailsCategory(
        type: type,
        lat: latLng.latitude.toString(),
        long: latLng.longitude.toString(),
      );
    } catch (e) {
      debugPrint("Location fetch error: $e");
    }
  }


  /// ============================= GET Home Header =====================================

  loadingMethod(Status status) => loading.value = status;
  final Rx<MapCategoryDetailsModel> mapDetailsCategory = MapCategoryDetailsModel().obs;
  Future<void> getMapDetailsCategory({required String type, required String lat, required String long}) async {
    try {
      final response = await apiClient.get(url: ApiUrl.getMapDetailsCategory(type: type, lat: lat, long: long));
      if (response.statusCode == 200) {
        loadingMethod(Status.completed);
        mapDetailsCategory.value = MapCategoryDetailsModel.fromJson(response.body);
        _createMarkersFromServices();
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
      debugPrint("API Error: $e");
      loadingMethod(Status.error);
    }
  }
  void _createMarkersFromServices() {
    final services = mapDetailsCategory.value.services ?? [];
    markers.clear();
    for (var service in services) {
      final lat = double.tryParse(service.latitude ?? "0.0") ?? 0.0;
      final lng = double.tryParse(service.longitude ?? "0.0") ?? 0.0;
      if (lat == 0.0 && lng == 0.0) {
        debugPrint("Skipping service ${service.serviceName} due to invalid coordinates");
        continue;
      }
      final markerId = service.id?.toString() ??
          service.serviceName ??
          "marker_${markers.length}";
      final marker = Marker(
        markerId: MarkerId(markerId),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: service.serviceName ?? "Unknown Service",
          snippet: service.location ?? "No location info",
        ),
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          debugPrint("Tapped on ${service.serviceName}");
        },
      );
      markers.add(marker);
    }
    debugPrint("Created ${markers.length} markers for ${services.length} services");
  }
  Set<Marker> get getMarkers => markers;
  void clearMarkers() {
    markers.clear();
  }
  void addMarker(Marker marker) {
    markers.add(marker);
  }
  void removeMarker(String markerId) {
    markers.removeWhere((marker) => marker.markerId.value == markerId);
  }
  CameraPosition getCameraPosition() {
    if (markers.isNotEmpty) {
      double minLat = markers.first.position.latitude;
      double maxLat = markers.first.position.latitude;
      double minLng = markers.first.position.longitude;
      double maxLng = markers.first.position.longitude;

      for (var marker in markers) {
        if (marker.position.latitude < minLat) minLat = marker.position.latitude;
        if (marker.position.latitude > maxLat) maxLat = marker.position.latitude;
        if (marker.position.longitude < minLng) minLng = marker.position.longitude;
        if (marker.position.longitude > maxLng) maxLng = marker.position.longitude;
      }
      double centerLat = (minLat + maxLat) / 2;
      double centerLng = (minLng + maxLng) / 2;
      centerLat -= 0.015;

      return CameraPosition(
        target: LatLng(centerLat, centerLng),
        zoom: _calculateZoomLevel(minLat, maxLat, minLng, maxLng),
      );
    }

    return CameraPosition(
      target: currentLocation.value ??
          const LatLng(23.804693584341365, 90.41590889596907),
      zoom: 8,
    );
  }
  double _calculateZoomLevel(
      double minLat, double maxLat, double minLng, double maxLng) {
    double latDiff = maxLat - minLat;
    double lngDiff = maxLng - minLng;
    double maxDiff = latDiff > lngDiff ? latDiff : lngDiff;
    if (maxDiff < 0.01) return 14;
    if (maxDiff < 0.05) return 12;
    if (maxDiff < 0.1) return 10;
    if (maxDiff < 0.5) return 8;
    return 6;
  }
}