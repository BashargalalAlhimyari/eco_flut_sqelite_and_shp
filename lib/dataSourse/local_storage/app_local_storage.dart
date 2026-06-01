import 'package:flutter_application_2/models/product.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_2/dataSourse/local_storage/cart_db_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class AppLocalDataSource {
  Future<List<ProductModel>> getCachedFavorites();
  Future<void> cacheFavorites(List<ProductModel> products) ;
  Future<void> cacheCartItems(List<ProductModel> products);
  Future<List<ProductModel>> getCachedCartItems();
}

class AppLocalDataSourceImp implements AppLocalDataSource {
  final String _favoritesBoxName = 'favorites_box';
  final String _cartBoxName = 'cart_box';
  final CartDatabaseHelper _dbHelper = CartDatabaseHelper();

  @override
  Future<void> cacheFavorites(List<ProductModel> products) async {
    var box = await Hive.openBox<ProductModel>(_favoritesBoxName);
    await box.clear();
    await box.addAll(products);
  }

  @override
  Future<List<ProductModel>> getCachedFavorites() async {
    var box = await Hive.openBox<ProductModel>(_favoritesBoxName);
    return box.values.toList();
  }

  @override
  Future<void> cacheCartItems(List<ProductModel> products) async {
    if (kIsWeb) {
      var box = await Hive.openBox<ProductModel>(_cartBoxName);
      await box.clear();
      await box.addAll(products);
    } else {
      await _dbHelper.saveAllCartItems(products);
    }
  }

  @override
  Future<List<ProductModel>> getCachedCartItems() async {
    if (kIsWeb) {
      var box = await Hive.openBox<ProductModel>(_cartBoxName);
      return box.values.toList();
    } else {
      return await _dbHelper.getCartItems();
    }
  }
}
