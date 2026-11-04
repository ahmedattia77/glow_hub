import 'package:flutter/material.dart';

class AppColors {
  // --- Light Mode Colors ---
  static const Color primaryLight = Color(0xFFB87378); // Rose Gold
  static const Color secondaryLight = Color(0xFF008080); // Deep Teal
  static const Color backgroundLight = Color(0xFFFAF7F5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF222222);
  static const Color textSecondaryLight = Color(0xFF777777);

  // Button Gradient (Light)
  static const LinearGradient buttonGradientLight = LinearGradient(
    colors: [Color(0xFFC98A90), Color(0xFFA35F64)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Rose Gold Gradients
  static const LinearGradient roseGoldGradient = LinearGradient(
    colors: [Color(0xFFE8B7B0), Color(0xFFD89B92), Color(0xFFC7847B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient roseGoldHeaderGradient = LinearGradient(
    colors: [Color(0xFFE5AAA0), Color(0xFFD6948A), Color(0xFFC77E73)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Admin Cards & Form Colors (Light)
  static const Color cardBgLight = Color(0xFFFBF1EC);
  static const Color cardBgInputLight = Color(0xFFF6E7DE);
  static const Color cardBorderLight = Color(0xFFF2DFD7);
  static const Color cardBorderInputLight = Color(0xFFEBD4C7);
  static const Color cardDividerLight = Color(0xFFDFCCC2);
  static const Color accentDark = Color(0xFF382320);
  static const Color accentDarkBrown = Color(0xFF4A3531);
  static const Color textHeaderDark = Color(0xFF2C1E1C);
  static const Color textSecondaryWarm = Color(0xFF88736E);
  static const Color hintTextWarm = Color(0xFF9E8A84);
  static const Color successGreen = Color(0xFF2E7D32);
  static const Color errorRed = Color(0xFFE53935);

  // --- Dark Mode Colors ---
  static const Color primaryDark = Color(0xFFD4959A);
  static const Color secondaryDark = Color(0xFF00A3A3);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1A1A);
  static const Color textPrimaryDark = Color(0xFFF3F0EE);
  static const Color textSecondaryDark = Color(0xFFA09898);

  // Button Gradient (Dark)
  static const LinearGradient buttonGradientDark = LinearGradient(
    colors: [Color(0xFFA35F64), primaryDark, Color(0xFFA35F64)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
