import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomImage(imageSrc: "assets/images/map.png")
        ],
      ),
    );
  }
}
