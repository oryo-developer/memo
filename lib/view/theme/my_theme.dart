import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get themeData {
    return ThemeData(
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        bodySmall: TextStyle(fontSize: 12),
      ),
    );
  }
}
