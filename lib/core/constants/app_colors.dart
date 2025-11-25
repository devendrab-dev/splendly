import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF7F3DFF);
  static const Color primaryLight = Color(0xFFEAE2FF);
  static const Color primaryDark = Color(0xFF4A22D6);

  static const Color secondary = Color(0xFF00D1FF);

  static const Color inactiveColor = Color.fromARGB(77, 102, 102, 102);
  static const Color iconInactive = Color(0xFFBDBDBD);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color cardBg = Color(0xFFF5F5F5);
  static const Color accentBg = Color(0xFFF0F0FF);
  static Color grey = Colors.grey.shade600;
  static Color? grey300 = Colors.grey[300];
  static Color? grey600 = Colors.grey[600];

  static const Color green = Color.fromRGBO(0, 168, 107, 1);

  static const Color chipBgColor = Color.fromRGBO(252, 238, 212, 1);
  static const Color chipColor = Color.fromRGBO(252, 172, 18, 1);
  static const Color voilet20 = Color.fromRGBO(238, 229, 255, 1);
  static const Color voilet = Color.fromRGBO(127, 61, 255, 1);

  static const Color primaryText = Color(0xFF1A1A1A);
  static const Color secondaryText = Color(0xFF666666);
  static const Color hintText = Color(0xFF999999);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);

  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF5B2DFD), Color(0xFF4A22D6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF00D1FF), Color(0xFF00A8FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
