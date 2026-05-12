import 'package:flutter_application_2/core/network/api_service.dart';
import 'package:flutter_application_2/models/product.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<String>> getAllCategories();
  Future<List<ProductModel>> getProductsByCategory(String categoryName);
}

class CategoriesRemoteDataSourceImp extends CategoriesRemoteDataSource {
  final ApiService apiService;

  CategoriesRemoteDataSourceImp({required this.apiService});

  @override
  Future<List<String>> getAllCategories() async {
    var data = await apiService.get(endpoint: "https://fakestoreapi.com/products/categories");
    
    return (data as List).map((e) => e.toString()).toList();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    var data = await apiService.get(
      endpoint: "https://fakestoreapi.com/products/category/$categoryName",
    );

    return (data as List).map((json) {
      return ProductModel.fromJson(json as Map<String, dynamic>);
    }).toList();
  }
}