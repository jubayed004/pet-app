import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';

class AddPetScreen extends StatelessWidget {
  const AddPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [

            CustomDefaultAppbar(
              title: "Add Pet",
            )
          ],
        )
    );
  }
}
