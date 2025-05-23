import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastMessage({String? message,Color color = Colors.green}) {
  Fluttertoast.showToast(
    msg: message??"something_went_wrong",
    backgroundColor: color,
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}