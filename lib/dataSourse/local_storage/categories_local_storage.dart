import 'package:hive/hive.dart';

abstract class CategoriesLocalDataSource {
  Future<List<String>> getCachedCategories();
  Future<void> cacheCategories(List<String> categories);
}



class CategoriesLocalDataSourceImp implements CategoriesLocalDataSource {
  final String _categoriesBoxName = 'categories_box';

  @override
  Future<void> cacheCategories(List<String> categories) async {
    var box = await Hive.openBox<String>(_categoriesBoxName);
    await box.clear();
    await box.addAll(categories);
  }

  @override
  Future<List<String>> getCachedCategories() async {
    var box = await Hive.openBox<String>(_categoriesBoxName);
    if (box.isNotEmpty) {
      return box.values.toList();
    } else {
      throw Exception("No Cached Categories Found");
    }
  }
}