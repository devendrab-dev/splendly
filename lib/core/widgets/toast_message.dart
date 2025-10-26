import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String message,
  Color backgroundColor = Colors.black87,
  Color textColor = Colors.white,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int duration = 2,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: duration > 2 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: gravity,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 14.0,
  );
}
