import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/dataSourse/local_storage/products_local_storage.dart';
import 'package:flutter_application_2/models/product.dart';

class FavoritesProvider extends ChangeNotifier {
  final ProductsLocalDataSource localDataSource; // حقن التبعية هنا

  FavoritesProvider({required this.localDataSource}) {
    _loadFavorites(); // جلب البيانات من Hive فور تشغيل البروفايدر
  }

  List<ProductModel> _favoriteProducts = [];

  List<ProductModel> get favoriteProducts => _favoriteProducts;

  // 1. دالة لجلب البيانات من التخزين المحلي عند فتح التطبيق
  Future<void> _loadFavorites() async {
    try {
      _favoriteProducts = await localDataSource.getCachedFavorites(); // دالة سنضيفها في الـ LocalDataSource
      notifyListeners();
    } catch (e) {
      _favoriteProducts = [];
    }
  }

  bool isFavorite(int productId) {
    return _favoriteProducts.any((p) => p.id == productId);
  }

  // 2. تعديل دالة التبديل لحفظ التغييرات في Hive فوراً
  void toggleFavorite(ProductModel product) async {
    final index = _favoriteProducts.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _favoriteProducts.removeAt(index);
    } else {
      _favoriteProducts.add(product);
    }
    
    // حفظ القائمة الجديدة كاملة في Hive
    await localDataSource.cacheFavorites(_favoriteProducts); 
    
    notifyListeners();
  }

  
}