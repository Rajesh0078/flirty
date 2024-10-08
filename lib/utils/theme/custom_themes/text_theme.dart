import 'package:flirty/constants/colors.dart';
import 'package:flutter/material.dart';

class CTextTheme {
  CTextTheme._();

  static TextTheme textTheme = TextTheme(
    headlineLarge: const TextStyle(
      color: CColors.primary,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: "Gazpacho",
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3,
      fontFamily: "Gazpacho",
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: CColors.textColor,
    ),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black.withOpacity(0.5)),
  );
}
