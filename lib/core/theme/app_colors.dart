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

  // --- Dark Mode Colors ---
  static const Color primaryDark = Color(0xFFD4959A);
  static const Color secondaryDark = Color(0xFF00A3A3);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1A1A);
  static const Color textPrimaryDark = Color(0xFFF3F0EE);
  static const Color textSecondaryDark = Color(0xFFA09898);

  // Button Gradient (Dark)
  static const LinearGradient buttonGradientDark = LinearGradient(
    colors: [Color(0xFFD4959A), Color(0xFFB87378)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
