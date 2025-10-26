import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF7F3DFF);
  static const Color primaryLight = Color(0xFFEAE2FF);
  static const Color primaryDark = Color(0xFF4A22D6);

  // Secondary Colors
  static const Color secondary = Color(0xFF00D1FF);

  // Background Colors
  static const Color inactiveColor = Color.fromARGB(77, 102, 102, 102);
  static const Color iconInactive = Color(0xFFBDBDBD); 
  static const Color whiteColor = Colors.white;
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color cardBg = Color(0xFFF5F5F5);
  static const Color accentBg = Color(0xFFF0F0FF);

  // Text Colors
  static const Color primaryText = Color(0xFF1A1A1A);
  static const Color secondaryText = Color(0xFF666666);
  static const Color hintText = Color(0xFF999999);

  // Optional: success, error, warning
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);

  // Gradients (example)
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
