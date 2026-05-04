import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // =========================================
  // 🌙 الوضع الليلي (Telegram Style)
  // =========================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground, // 1. الخلفية الأغمق
      
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
      ),

      // 📊 الـ AppBar (يأخذ اللون الأفتح ليكون بارزاً)
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkElevated,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // 🗂️ البطاقات (تأخذ اللون المتوسط)
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0, // نلغي الظل لأننا نعتمد على تباين الألوان
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // 📱 شريط التنقل السفلي (يأخذ اللون الأفتح ليكون عائماً)
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkElevated,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      // 🔘 الأزرار
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // =========================================
  // ☀️ الوضع الفاتح
  // =========================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.lightSurface,
        background: AppColors.lightBackground,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 2, // في الفاتح نستخدم الظلال الخفيفة
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightTextSecondary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
