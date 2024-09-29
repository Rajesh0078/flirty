import 'package:flirty/constants/colors.dart';
import 'package:flirty/utils/theme/custom_themes/text_field_theme.dart';
import 'package:flirty/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class CAppTheme {
  CAppTheme._();

  static final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Gazpacho',
    textTheme: CTextTheme.textTheme,
    inputDecorationTheme: CTextFieldTheme.inputDecorationTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: CColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 30),
        splashFactory: NoSplash.splashFactory,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
          fontFamily: 'Gazpacho',
        ),
      ),
    ),
  );
}
