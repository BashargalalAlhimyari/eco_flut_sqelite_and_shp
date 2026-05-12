import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/dataSourse/local_storage/products_local_storage.dart';
import 'package:flutter_application_2/models/product.dart';

class CartProvider extends ChangeNotifier {
  final ProductsLocalDataSource localDataSource;

  CartProvider({required this.localDataSource}) {
    _loadCart(); // تحميل السلة عند تشغيل التطبيق
  }

  // استخدمنا Map هنا لتسهيل زيادة الكمية بناءً على ID المنتج
  final Map<int, ProductModel> _cartItems = {};

  List<ProductModel> get cartItems => _cartItems.values.toList();

  // جلب البيانات من Hive
  Future<void> _loadCart() async {
    try {
      final cachedItems = await localDataSource.getCachedCartItems();
      for (var item in cachedItems) {
        _cartItems[item.id] = item;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("السلة فارغة حالياً");
    }
  }

  // إضافة للسلة وحفظ في Hive
  void addToCart(ProductModel product) async {
    _cartItems[product.id] = product;
    
    // حفظ القائمة المحدثة في Hive
    await localDataSource.cacheCartItems(_cartItems.values.toList());
    
    notifyListeners();
  }

  // حذف من السلة وتحديث Hive
  void removeFromCart(int productId) async {
    _cartItems.remove(productId);
    await localDataSource.cacheCartItems(_cartItems.values.toList());
    notifyListeners();
  }

  // حساب الإجمالي
  double get totalPrice {
    double total = 0;
    _cartItems.forEach((key, product) {
      total += product.price;
    });
    return total;
  }
}