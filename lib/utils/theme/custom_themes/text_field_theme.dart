import 'package:flirty/constants/colors.dart';
import 'package:flutter/material.dart';

class CTextFieldTheme {
  static final inputDecorationTheme = InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      labelStyle: const TextStyle(
        color: CColors.accent,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.4,
      ),
      floatingLabelStyle: const TextStyle(
        fontSize: 18,
        color: Color.fromARGB(255, 162, 159, 164),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFE8E6EA), width: 1.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: CColors.primary,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFE8E6EA),
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      errorStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300));
}
