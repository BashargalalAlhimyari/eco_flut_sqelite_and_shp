import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/theme/theme_provider.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/cart_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // 👈 إضافة مزود الثيم
      ],
      // 👈 استخدام Consumer للاستماع لتغيرات الثيم
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'متجري الذكي',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode, // 👈 ربط حالة الثيم هنا
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
