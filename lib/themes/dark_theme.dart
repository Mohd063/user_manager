import 'package:flutter/material.dart';
import 'package:manage_me/core/constants/colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: Colors.black,
  canvasColor: Colors.black, // Background for dialogs, drawers, etc.

  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: Colors.black,
    surface: Colors.grey[900]!,
    onPrimary: AppColors.buttonText,
    onSecondary: Colors.black,
    onBackground: Colors.white70,
    onSurface: Colors.white70,
    error: AppColors.error,
    onError: Colors.black,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  dialogBackgroundColor: Colors.black,

  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.black,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.black,
    modalBackgroundColor: Colors.black,
  ),

  cardColor: Colors.grey[900],
  iconTheme: const IconThemeData(color: Colors.white70),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[850],
    hintStyle: const TextStyle(color: Colors.white54),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.buttonText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    titleLarge: TextStyle(color: Colors.white),
  ),
);
