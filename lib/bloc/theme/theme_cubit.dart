import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diamond_kgk_app/services/theme_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_getInitialTheme());

  // Get the initial theme from the stored value.
  static ThemeMode _getInitialTheme() {
    final savedTheme = ThemeStorageService.getSavedThemeMode();
    return savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  // Toggle between light and dark themes and persist the selection.
  void toggleTheme() {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    ThemeStorageService.saveThemeMode(
      newTheme == ThemeMode.light ? 'light' : 'dark',
    );
  }
}
