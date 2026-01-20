import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart';

class AppTheme {

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.primaryBackground,
      canvasColor: AppColors.primaryBackground,

      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primaryLight,
      primaryColorDark: AppColors.primaryDark,

      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,
      ),

      textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: "Poppins",
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.textHint),
        labelStyle: TextStyle(color: AppColors.textSecondary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }


  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
