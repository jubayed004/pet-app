import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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
            /*    CustomImage(imageSrc: "assets/images/map.png", boxFit: BoxFit.cover),*/
                GoogleMap(


                    initialCameraPosition: CameraPosition(target: LatLng(23.804693584341365, 90.41590889596907, ),zoom: 14)),
                const Gap(10),
              ],
            ),
          )
        ],
      )
    );

  }
}
