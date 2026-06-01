import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/di/service_locater.dart' as di;
import 'package:flutter_application_2/core/theme/app_theme.dart';
import 'package:flutter_application_2/core/theme/theme_provider.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/providers/cart_provider.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:flutter_application_2/screens/main_screen.dart';
import 'package:flutter_application_2/screens/login_screen.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ChangeNotifierProvider(create: (_) => di.sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<CartProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<FavoritesProvider>()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'متجر الجنييد الذكي',
            debugShowCheckedModeBanner: false,
            
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
            
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasData) {
                  return const MainScreen();
                }
                return const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}