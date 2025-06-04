import 'package:flutter/material.dart';
import 'package:manage_me/core/constants/colors.dart';

/// Light theme definition for the app
/// 
/// Applies consistent colors, typography, and UI styling based on AppColors.
/// Suitable for bright environments, using lighter backgrounds and darker text.
final ThemeData lightTheme = ThemeData(
  // Light mode brightness
  brightness: Brightness.light,

  // Primary color for widgets like buttons, switches, progress indicators, etc.
  primaryColor: AppColors.primary,

  // Background color for Scaffold (main app screen background)
  scaffoldBackgroundColor: AppColors.background,

  // Color scheme for UI components across the app in light mode
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,               // Brand's main color
    secondary: AppColors.secondary,           // Secondary/accent color
    background: AppColors.background,         // General background color
    surface: AppColors.card,                  // Surface color (e.g., cards, sheets)
    onPrimary: AppColors.buttonText,          // Text color on primary-colored widgets
    onSecondary: AppColors.buttonText,        // Text color on secondary widgets
    onBackground: AppColors.textPrimary,      // Text color on background
    onSurface: AppColors.textSecondary,       // Text on cards, sheets, etc.
    error: AppColors.error,                   // Color used for error elements
    onError: AppColors.buttonText,            // Text/icon color on error backgrounds
  ),

  // App bar styling
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,    // Matches scaffold background
    foregroundColor: AppColors.textPrimary,   // App bar text/icon color
    elevation: 0,                             // Flat app bar, no shadow
    iconTheme: IconThemeData(color: AppColors.textPrimary), // Icon color in app bar
    titleTextStyle: TextStyle(                // Title text style
      color: AppColors.textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Default card appearance (used in Card widgets)
  cardColor: AppColors.card,

  // Default icon color across the app
  iconTheme: const IconThemeData(color: AppColors.textSecondary),

  // Default styling for TextField, TextFormField
  inputDecorationTheme: InputDecorationTheme(
    filled: true,                             // Input fields have background color
    fillColor: AppColors.searchBarFill,       // Light grey fill color
    hintStyle: const TextStyle(color: AppColors.hint), // Hint text styling
    border: OutlineInputBorder(               // Input border styling
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,            // No border line
    ),
  ),

  // Styling for ElevatedButton across the app
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,     // Background color for button
      foregroundColor: AppColors.buttonText,  // Text/icon color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
    ),
  ),

  // Default text styles
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary),     // General large text
    bodyMedium: TextStyle(color: AppColors.textSecondary),  // General secondary text
    titleLarge: TextStyle(color: AppColors.textPrimary),    // Titles/headers
  ),
);
