import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // الوضع الافتراضي هو الفاتح (أو يمكنك جعله system)
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  // التحقق هل الوضع الحالي ليلي؟
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // دالة التبديل بين الوضعين
  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners(); // تحديث التطبيق بالكامل
  }
}
