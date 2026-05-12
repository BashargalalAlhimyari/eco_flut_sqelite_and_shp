import 'package:flutter/material.dart';
import 'package:flutter_application_2/repo/category_repo.dart';

enum CategoryState { initial, loading, loaded, error }

class CategoriesProvider extends ChangeNotifier {
  final CategoryRepository repository;

  CategoriesProvider({required this.repository});

  List<String> _categories = [];
  CategoryState _state = CategoryState.initial;

  List<String> get categories => _categories;
  CategoryState get state => _state;

  Future<void> fetchCategories() async {
    _state = CategoryState.loading;
    notifyListeners();

    final result = await repository.getCategories();

    result.fold(
      (failure) => _state = CategoryState.error,
      (categoryList) {
        _state = CategoryState.loaded;
        _categories = categoryList;
      },
    );

    notifyListeners();
  }
}