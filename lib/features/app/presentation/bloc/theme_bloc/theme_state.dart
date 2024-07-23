import 'package:flutter/material.dart';

class ThemeState {
  ThemeMode themeMode;
  String? appTheme;

  ThemeState({
    this.themeMode = ThemeMode.light,
    required this.appTheme,
  }) {
    if (appTheme != null) {
      if (appTheme == 'light') {
        themeMode = ThemeMode.light;
      } else if (appTheme == 'dark') {
        themeMode = ThemeMode.dark;
      } else if (appTheme == 'system') {
        themeMode = ThemeMode.system;
      } else {
        themeMode = ThemeMode.light;
      }
    }
  }
}
