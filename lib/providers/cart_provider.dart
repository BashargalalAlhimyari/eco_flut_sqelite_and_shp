import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/dataSourse/local_storage/app_local_storage.dart';
import 'package:flutter_application_2/models/product.dart';

class CartProvider extends ChangeNotifier {
  final AppLocalDataSource localDataSource;

  CartProvider({required this.localDataSource}) {
    _loadCart();
  }

  final Map<String, ProductModel> _cartItems = {};

  List<ProductModel> get cartItems => _cartItems.values.toList();

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

  void addToCart(ProductModel product) async {
    _cartItems[product.id] = product;
    await localDataSource.cacheCartItems(_cartItems.values.toList());
    notifyListeners();
  }

  void removeFromCart(String productId) async {
    _cartItems.remove(productId);
    await localDataSource.cacheCartItems(_cartItems.values.toList());
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    _cartItems.forEach((key, product) {
      total += product.price;
    });
    return total;
  }
}