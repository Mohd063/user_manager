import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

/// A [Cubit] that manages the current app theme.
/// 
/// Starts with the light theme by default.
/// Call [toggleTheme] with `true` to switch to dark theme,
/// or `false` to switch back to light theme.
class ThemeCubit extends Cubit<ThemeData> {
  /// Initializes the cubit with the default light theme.
  ThemeCubit() : super(lightTheme);

  /// Switches between dark and light themes.
  /// 
  /// [isDark] when true emits [darkTheme], otherwise emits [lightTheme].
  void toggleTheme(bool isDark) {
    emit(isDark ? darkTheme : lightTheme);
  }
}
