import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';

class ProductsProvider with ChangeNotifier {
  // 🗂️ قائمة الأقسام الوهمية
  final List<Category> _categories = [
    Category(id: 'c1', name: 'إلكترونيات', imageUrl: '💻'),
    Category(id: 'c2', name: 'ملابس', imageUrl: '👕'),
    Category(id: 'c3', name: 'كتب', imageUrl: '📚'),
  ];

  // 📦 قائمة المنتجات الوهمية
  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'لابتوب ماك بوك',
      price: 4500.0,
      description: 'لابتوب قوي جداً ومناسب للمبرمجين والمصممين.',
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500',
      categoryId: 'c1',
     ),
    Product(
      id: 'p2',
      name: 'سماعات بلوتوث',
      price: 150.0,
      description: 'سماعات لاسلكية بصوت نقي وعزل للضوضاء.',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      categoryId: 'c1',
     ),
    Product(
      id: 'p3',
      name: 'تيشيرت قطني',
      price: 50.0,
      description: 'تيشيرت مريح جداً مصنوع من القطن الخالص.',
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500',
      categoryId: 'c2',
     ),
    Product(
      id: 'p4',
      name: 'كتاب تعلم فلاتر',
      price: 80.0,
      description: 'كتاب شامل لتعلم بناء التطبيقات باستخدام Flutter.',
      imageUrl: 'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=500',
      categoryId: 'c3',
     ),
  ];

  // جلب كل الأقسام
  List<Category> get categories => [..._categories];

  // جلب كل المنتجات
  List<Product> get products => [..._products];

  // جلب منتجات قسم معين فقط
  List<Product> getProductsByCategory(String categoryId) {
    return _products.where((prod) => prod.categoryId == categoryId).toList();
  }
}
