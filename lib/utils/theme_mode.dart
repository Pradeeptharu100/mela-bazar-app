import 'package:flutter/material.dart';
import 'package:melebazaar_app/common/pt_colors.dart';

class AppTheme {
  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: PTColor.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
