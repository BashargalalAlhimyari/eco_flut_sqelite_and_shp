import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritesProvider with ChangeNotifier {
  // قائمة المنتجات المفضلة
  final List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => [..._favoriteItems];

  // ❤️ إضافة أو إزالة منتج من المفضلة
  void toggleFavorite(Product product) {
    final existingIndex = _favoriteItems.indexWhere((prod) => prod.id == product.id);
    
    if (existingIndex >= 0) {
      // إذا كان موجوداً، نقوم بإزالته
      _favoriteItems.removeAt(existingIndex);
    } else {
      // إذا لم يكن موجوداً، نضيفه
      _favoriteItems.add(product);
    }
    notifyListeners(); // 📢 تحديث الشاشات
  }

  // 🔍 التحقق مما إذا كان المنتج في المفضلة (لتغيير لون أيقونة القلب)
  bool isFavorite(String productId) {
    return _favoriteItems.any((prod) => prod.id == productId);
  }
}
