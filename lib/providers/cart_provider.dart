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
      _cartItems.clear();
      for (var item in cachedItems) {
        _cartItems[item.id] = item;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("السلة فارغة حالياً: $e");
    }
  }

  void addToCart(ProductModel product) async {
    if (_cartItems.containsKey(product.id)) {
      final existingItem = _cartItems[product.id]!;
      _cartItems[product.id] = existingItem.copyWith(quantity: existingItem.quantity + 1);
    } else {
      _cartItems[product.id] = product.copyWith(quantity: 1);
    }
    await localDataSource.cacheCartItems(_cartItems.values.toList());
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) async {
    if (_cartItems.containsKey(productId)) {
      if (quantity <= 0) {
        removeFromCart(productId);
      } else {
        _cartItems[productId] = _cartItems[productId]!.copyWith(quantity: quantity);
        await localDataSource.cacheCartItems(_cartItems.values.toList());
        notifyListeners();
      }
    }
  }

  void incrementQuantity(String productId) {
    if (_cartItems.containsKey(productId)) {
      updateQuantity(productId, _cartItems[productId]!.quantity + 1);
    }
  }

  void decrementQuantity(String productId) {
    if (_cartItems.containsKey(productId)) {
      updateQuantity(productId, _cartItems[productId]!.quantity - 1);
    }
  }

  void removeFromCart(String productId) async {
    if (_cartItems.containsKey(productId)) {
      _cartItems.remove(productId);
      await localDataSource.cacheCartItems(_cartItems.values.toList());
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0;
    _cartItems.forEach((key, product) {
      total += product.price * product.quantity;
    });
    return total;
  }
}