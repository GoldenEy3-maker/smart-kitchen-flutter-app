import "package:flutter/material.dart";

/// Modular type scale: 12 / 14 / 16 / 18 / 24 / 28.
class AppTypography {
  static const TextTheme textTheme = TextTheme(
    displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  );
}
