import 'package:flutter/material.dart';

import 'package:flutter_application_2/core/errors/failure.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/repo/product_repo.dart';

enum ProductState { initial, loading, loaded, error }

class ProductsProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductsProvider({required this.repository});

  // البيانات والحالة
  List<ProductModel> _products = [];
  ProductState _state = ProductState.initial;
  String _errorMessage = '';

  // Getters للوصول للبيانات من الواجهة
  List<ProductModel> get products => _products;
  ProductState get state => _state;
  String get errorMessage => _errorMessage;

  // دالة جلب المنتجات
  Future<void> fetchAllProducts() async {
    _state = ProductState.loading;
    notifyListeners(); // إشعار الواجهة بالتحميل

    final result = await repository.getProducts();

    result.fold(
      (failure) {
        _state = ProductState.error;
        _errorMessage = _mapFailureToMessage(failure);
      },
      (productList) {
        _state = ProductState.loaded;
        _products = productList;
        print("=========================++++++=====");
print(_products);
print("=========================++++++=====");

      },
    );

    notifyListeners();
  }

  // تحويل الـ Failure إلى نص مفهوم للمستخدم
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return "خطأ في الاتصال بالسيرفر، حاول لاحقاً.";
    if (failure is CacheFailure) return "لا توجد بيانات مخزنة محلياً.";
    return "حدث خطأ غير متوقع.";
  }
}