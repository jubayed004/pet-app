import 'package:flutter/material.dart';
import 'package:pet_app/controller/get_controllers.dart';

class TextScreen extends StatelessWidget {
   TextScreen({super.key});
  final controller = GetControllers.instance.getTestController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.name.value),
      ),
    );
  }
}
