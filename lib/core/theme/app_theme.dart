import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';

class AppTheme {
  AppTheme._();

  // ── Dark Theme ────────────────────────────────────────────────
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.dkBg,
      primaryColor: AppColors.dkAccent,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.dkAccent,
        secondary: AppColors.dkSuccess,
        surface: AppColors.dkCard,
        error: AppColors.dkDanger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.dkText,
      ),
      fontFamily: 'DMSans',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dkBg,
        foregroundColor: AppColors.dkText,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: AppColors.dkText),
        titleTextStyle: TextStyle(
          fontFamily: 'Syne',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.dkText,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.dkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.dkBorder),
        ),
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.dkBg,
        hintStyle: const TextStyle(color: AppColors.dkSecondary, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dkAccent),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.dkBtn,
          foregroundColor: AppColors.dkBg,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          elevation: 0,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.w800, color: AppColors.dkText, letterSpacing: -1),
        headlineMedium: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.w700, color: AppColors.dkText, letterSpacing: -0.5),
        titleLarge: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.w700, color: AppColors.dkText),
        titleMedium: TextStyle(fontFamily: 'DMSans', fontWeight: FontWeight.w600, color: AppColors.dkText),
        bodyLarge: TextStyle(fontFamily: 'DMSans', color: AppColors.dkText, fontSize: 15),
        bodyMedium: TextStyle(fontFamily: 'DMSans', color: AppColors.dkText, fontSize: 14),
        bodySmall: TextStyle(fontFamily: 'DMSans', color: AppColors.dkSecondary, fontSize: 12),
        labelSmall: TextStyle(fontFamily: 'DMSans', color: AppColors.dkSecondary, fontSize: 11, fontWeight: FontWeight.w600),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.dkCard,
        selectedItemColor: AppColors.dkAccent,
        unselectedItemColor: AppColors.dkSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.dkBorder, thickness: 1, space: 0),
      iconTheme: const IconThemeData(color: AppColors.dkSecondary, size: 20),
    );
  }

  // ── Light Theme (Admin) ────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.ltBg,
      primaryColor: AppColors.ltPrimary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.ltPrimary,
        secondary: AppColors.ltAccent,
        surface: AppColors.ltCard,
        error: AppColors.ltDanger,
        onPrimary: Colors.white,
        onSurface: AppColors.ltText,
      ),
      fontFamily: 'DMSans',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.ltCard,
        foregroundColor: AppColors.ltText,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: AppColors.ltSecondary),
        titleTextStyle: TextStyle(
          fontFamily: 'Syne',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.ltText,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.ltCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.ltBorder),
        ),
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.ltBg,
        hintStyle: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.ltBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.ltBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.ltPrimary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.ltPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          elevation: 0,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.w800, color: AppColors.ltText, letterSpacing: -1),
        headlineMedium: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.w700, color: AppColors.ltText),
        titleLarge: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.w700, color: AppColors.ltText),
        titleMedium: TextStyle(fontFamily: 'DMSans', fontWeight: FontWeight.w600, color: AppColors.ltText),
        bodyLarge: TextStyle(fontFamily: 'DMSans', color: AppColors.ltText, fontSize: 15),
        bodyMedium: TextStyle(fontFamily: 'DMSans', color: AppColors.ltText, fontSize: 14),
        bodySmall: TextStyle(fontFamily: 'DMSans', color: AppColors.ltSecondary, fontSize: 12),
        labelSmall: TextStyle(fontFamily: 'DMSans', color: AppColors.ltSecondary, fontSize: 11, fontWeight: FontWeight.w600),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.ltBorder, thickness: 1, space: 0),
      iconTheme: const IconThemeData(color: AppColors.ltSecondary, size: 20),
    );
  }
}