import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartBadge extends StatelessWidget {
  final Widget child; 
  final Color? badgeColor; 

  const CartBadge({
    Key? key,
    required this.child,
    this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        // نستخدم طول القائمة لمعرفة عدد المنتجات المختلفة في السلة
        final int count = cartProvider.cartItems.length;

        return Badge(
          // 1. إخفاء العداد إذا كانت السلة فارغة
          isLabelVisible: count > 0,
          
          // 2. تنسيق مكان ومظهر العداد
          backgroundColor: badgeColor ?? Theme.of(context).colorScheme.primary,
          label: Text(
            count.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          // 3. الأيقونة (غالباً Icons.shopping_cart)
          child: child,
        );
      },
    );
  }
}