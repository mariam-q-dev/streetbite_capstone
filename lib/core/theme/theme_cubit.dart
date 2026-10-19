import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences sharedPreferences;
  static const String themeKey = 'THEME_MODE';

  ThemeCubit({required this.sharedPreferences}) : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() {
    final isDark = sharedPreferences.getBool(themeKey) ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    sharedPreferences.setBool(themeKey, !isDark);
    emit(newMode);
  }
}