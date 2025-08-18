import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

late GoogleMapController mapController;

const LatLng _center = LatLng(23.804693584341365, 90.41590889596907);

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(
            title: "Track Your App",
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Uncomment this if you need the image
                /*CustomImage(imageSrc: "assets/images/map.png", boxFit: BoxFit.cover),*/
                SizedBox(
                  height: 300,  // Set a fixed height for the map
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14,
                    ),
                  ),
                ),
                const Gap(10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
