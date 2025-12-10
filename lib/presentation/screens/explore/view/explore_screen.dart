import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/screens/explore/widgets/explore_bottom_sheet.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  GoogleMapController? mapController;
  Worker? _markerWorker;
  final exploreController = GetControllers.instance.getExploreController();
  static const LatLng _center = LatLng(23.804693584341365, 90.41590889596907);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (exploreController.markers.isNotEmpty) {
      _animateToShowAllMarkers();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      exploreController.startLocationSharing(type: "VET");
      _showExploreBottomSheet();
    });
    // Listen to marker changes to animate camera
    _markerWorker = ever(exploreController.markers, (_) {
      if (exploreController.markers.isNotEmpty) {
        _animateToShowAllMarkers();
      }
    });
  }

  void _showExploreBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black12, // Subtle barrier
      enableDrag: true,
      isDismissible:
          false, // Prevent dismissing by tapping outside if you want it persistent
      builder:
          (context) => ExploreBottomSheet(
            exploreController: exploreController,
            onShowAll: _animateToShowAllMarkers,
          ),
    );
  }

  @override
  void dispose() {
    _markerWorker?.dispose();
    mapController?.dispose();
    super.dispose();
  }

  void _animateToShowAllMarkers() {
    if (exploreController.markers.isNotEmpty && mapController != null) {
      final cameraPosition = exploreController.getCameraPosition();
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 14,
            ),
            markers: exploreController.getMarkers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            mapToolbarEnabled: true,
            zoomControlsEnabled: true,
            padding: const EdgeInsets.only(
              bottom: 100,
            ), // Add padding so Google logo etc aren't hidden
          ),

          // Floating action button to re-open sheet if dismissed (optional but good ux)
          Positioned(
            right: 16,
            bottom: 30,
            child: FloatingActionButton(
              onPressed: _showExploreBottomSheet,
              child: const Icon(Icons.list),
            ),
          ),
        ],
      ),
    );
  }
}
