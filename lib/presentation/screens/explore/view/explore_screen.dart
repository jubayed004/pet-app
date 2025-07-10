import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
                CustomImage(imageSrc: "assets/images/map.png", boxFit: BoxFit.cover),
                const Gap(10),
              ],
            ),
          )
        ],
      )
    );

  }
}
