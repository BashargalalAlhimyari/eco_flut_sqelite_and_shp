import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartBadge extends StatelessWidget {
  final Widget child; // الأيقونة التي سيظهر فوقها العداد (مثل أيقونة السلة)
  final Color? badgeColor; // لون اختياري للعداد (افتراضياً سيكون أحمر)

  const CartBadge({
    Key? key,
    required this.child,
    this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // نستخدم Consumer للاستماع لتغييرات السلة فقط دون إعادة بناء الشاشة بالكامل
    return Consumer<CartProvider>(
      builder: (context, cart, ch) {
        return Badge(
          // 1. إخفاء العداد تماماً إذا كانت السلة فارغة (تجربة مستخدم أفضل)
          isLabelVisible: cart.itemCount > 0,
          
          // 2. لون العداد (يأخذ اللون الممرر، أو لون الخطأ من الثيم كافتراضي)
          backgroundColor: badgeColor ?? Theme.of(context).colorScheme.error,
          
          // 3. تصميم الرقم داخل العداد
          label: Text(
            cart.itemCount.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          // 4. الأيقونة الأساسية
          child: child,
        );
      },
    );
  }
}
