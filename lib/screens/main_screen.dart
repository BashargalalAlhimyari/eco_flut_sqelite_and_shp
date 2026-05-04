import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/favorite_screen.dart' show FavoritesScreen;
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_badge.dart';
import 'home_screen.dart';
import 'categories_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const FavoritesScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'الرئيسية'),
          const BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view), label: 'الأقسام'),
          BottomNavigationBarItem(
            icon: CartBadge(child: const Icon(Icons.shopping_cart_outlined)),
            activeIcon: CartBadge(child: const Icon(Icons.shopping_cart)),
            label: 'السلة',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: 'المفضلة'),
        ],
      ),
    );
  }
}
