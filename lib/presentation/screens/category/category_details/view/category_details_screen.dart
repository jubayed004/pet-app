import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: CustomScrollView(
         slivers: [
           CustomDefaultAppbar(
             title: "Category Details ",
           )
         ],
       ),
    );
  }
}
