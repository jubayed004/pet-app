import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';

class BusinessAllPetsScreen extends StatelessWidget {
  const BusinessAllPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(
            title: "All Pets",
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                leading: Assets.icons.rocky.svg(width: 30), // Correct way to use SVGs
                title: Text("Bella"),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
