import 'package:flutter/material.dart';

class AppColors {
  // 🔵 اللون الأساسي (أزرق تيليجرام المريح)
  static const Color primary = Color(0xFF2A90D3);

  // 🌙 ألوان الوضع الليلي (Telegram Dark Mode)
  static const Color darkBackground = Color(0xFF0E1621); // الأغمق: للخلفية الرئيسية (Scaffold)
  static const Color darkSurface = Color(0xFF18222D);    // أفتح قليلاً: للبطاقات (Cards)
  static const Color darkElevated = Color(0xFF232E3C);   // الأفتح: لشريط التنقل والـ AppBar
  
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8B9CB0); // رمادي مزرق للنصوص الفرعية

  // ☀️ ألوان الوضع الفاتح
  static const Color lightBackground = Color(0xFFF0F2F5); // رمادي فاتح جداً للخلفية
  static const Color lightSurface = Color(0xFFFFFFFF);    // أبيض نقي للبطاقات
  
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF7A828A);

  // 🔴 ألوان وظيفية
  static const Color error = Color(0xFFE53935);
}
