import 'package:flutter_application_2/models/product.dart';
import 'package:hive/hive.dart';

abstract class ProductsLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  
  Future<void> cacheProducts(List<ProductModel> products);
  
  Future<void> clearCache();

Future<List<ProductModel>> getCachedFavorites();

  Future<void> cacheFavorites(List<ProductModel> products) ;

  Future<void> cacheCartItems(List<ProductModel> products);

  Future<List<ProductModel>> getCachedCartItems();
}


// هذا هو التنفيذ (Implementation)
class ProductsLocalDataSourceImp implements ProductsLocalDataSource {
  final String _productsBoxName = 'products_box';
    final String _favoritesBoxName = 'favorites_box';
    final String _cartBoxName = 'cart_box';


  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    var box = await Hive.openBox<ProductModel>(_productsBoxName);
    await box.clear(); 
    await box.addAll(products);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    var box = await Hive.openBox<ProductModel>(_productsBoxName);
    if (box.isNotEmpty) {
      return box.values.toList();
    } else {
      throw Exception("No Cached Products Found");
    }
  }

  @override
  Future<void> clearCache() async {
    var box = await Hive.openBox<ProductModel>(_productsBoxName);
    await box.clear();
  }


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
    var box = await Hive.openBox<ProductModel>(_cartBoxName);
    await box.clear();
    await box.addAll(products);
  }

  @override
  Future<List<ProductModel>> getCachedCartItems() async {
    var box = await Hive.openBox<ProductModel>(_cartBoxName);
    return box.values.toList();
  }
}