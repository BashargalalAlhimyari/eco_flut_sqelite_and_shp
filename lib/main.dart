
import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/di/service_locater.dart' as di;
import 'package:flutter_application_2/core/theme/app_theme.dart';
import 'package:flutter_application_2/core/theme/theme_provider.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/providers/cart_provider.dart';
import 'package:flutter_application_2/providers/category_provider.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:flutter_application_2/screens/main_screen.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  // 1. التأكد من تهيئة روابط فلاتر
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
   Hive.registerAdapter(ProductModelAdapter()); 
  
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // استخدام sl() لجلب النسخ المهيأة مسبقاً من الـ Service Locator
        ChangeNotifierProvider(create: (_) => di.sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<ProductsProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<CategoriesProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<CartProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<FavoritesProvider>()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'متجر الجنييد الذكي',
            debugShowCheckedModeBanner: false,
            
            // إعدادات الثيم
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            // إعدادات اللغة والاتجاه (RTL)
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