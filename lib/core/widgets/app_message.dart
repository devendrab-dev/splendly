import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/widgets/slide_transition_wrapper.dart';

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

void showBottomMessage(
  BuildContext context,
  String message, {
  bool isSucees = true,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: SlideTransitionWrapper(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSucees ? AppColors.success : AppColors.error,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  isSucees ? Icons.check_circle : Icons.cancel_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);

  Future.delayed(Duration(seconds: 2)).then((_) {
    entry.remove();
  });
}
