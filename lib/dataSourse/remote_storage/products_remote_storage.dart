import 'package:flutter_application_2/core/network/api_service.dart';
import 'package:flutter_application_2/models/product.dart';
abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int id);
}
class ProductsRemoteDataSourceImp extends ProductsRemoteDataSource {
  final ApiService apiService;

  ProductsRemoteDataSourceImp({required this.apiService});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    // نستخدم الـ baseUrl من الـ ApiService أو نمرر الرابط كاملاً
    var data = await apiService.get(endpoint: "https://fakestoreapi.com/products");
    
    List<ProductModel> products = (data as List).map((json) {
      return ProductModel.fromJson(json as Map<String, dynamic>);
    }).toList();
print("=========================++++++=====");
print(products);
print("=========================++++++=====");

    return products;
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    var data = await apiService.get(
      endpoint: "https://fakestoreapi.com/products/$id",
    );
    
    return ProductModel.fromJson(data as Map<String, dynamic>);
  }
}