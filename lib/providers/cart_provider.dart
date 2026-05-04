import 'package:flutter/material.dart';
import '../models/product.dart';

// كلاس مساعد لتمثيل عنصر داخل السلة (يحتوي على المنتج والكمية)
class CartItem {
  final String id;
  final Product product;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  // نستخدم Map لسهولة البحث عن المنتج وتحديث كميته
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  // 🔢 حساب عدد المنتجات في السلة (لعرضه على الأيقونة)
  int get itemCount {
    return _items.length;
  }

  // 💰 حساب السعر الإجمالي للسلة
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  // 🛒 إضافة منتج للسلة
  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      // إذا كان المنتج موجوداً مسبقاً، نزيد الكمية
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      // إذا كان منتجاً جديداً، نضيفه للسلة
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: DateTime.now().toString(),
          product: product,
        ),
      );
    }
    notifyListeners(); // 📢 تحديث الشاشات التي تستمع لهذا البروفايدر
  }

  // 🗑️ حذف منتج من السلة
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // تفريغ السلة بالكامل
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
