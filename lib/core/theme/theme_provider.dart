import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  // الوضع الافتراضي هو الفاتح
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  // التحقق هل الوضع الحالي ليلي؟
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // تحميل المظهر المحفوظ من shared_preferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('is_dark_mode') ?? false;
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    } catch (e) {
      debugPrint("خطأ في تحميل المظهر المفضل: $e");
    }
  }

  // دالة التبديل بين الوضعين وحفظ الاختيار
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners(); // تحديث التطبيق بالكامل
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_dark_mode', _themeMode == ThemeMode.dark);
    } catch (e) {
      debugPrint("خطأ في حفظ المظهر المفضل: $e");
    }
  }
}
