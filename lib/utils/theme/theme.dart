import 'package:flirty/constants/colors.dart';
import 'package:flirty/utils/theme/custom_themes/text_field_theme.dart';
import 'package:flirty/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class CAppTheme {
  CAppTheme._();

  static final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    // fontFamily: 'Gazpacho',
    fontFamily: 'Geologica',
    appBarTheme: const AppBarTheme(
      elevation: 4,
      centerTitle: false,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
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
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
