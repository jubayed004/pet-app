import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_loader/custom_loader.dart';
import 'package:pet_app/presentation/widget/custom_loader/custom_loader.dart';

showPopUpLoader({required BuildContext context, Color color = Colors.transparent}) {
  return showDialog(
    barrierColor: color,
    context: context,
    builder: (_) {
      return SizedBox(
        height: 70,
          child: AlertDialog(
            elevation: 0,
            backgroundColor: color,
            content: const CustomLoader(),
          ),
      );
    },
  );
}
