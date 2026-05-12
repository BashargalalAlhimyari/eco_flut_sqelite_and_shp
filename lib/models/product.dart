import 'package:hive/hive.dart';

// هذا السطر مهم جداً لتوليد الملف التلقائي (سيظهر خطأ حتى تشغل الأمر في الـ Terminal)
part 'product_model.g.dart'; 

@HiveType(typeId: 0) // رقم فريد لكل موديل
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  // دوال التحويل من JSON كما هي لديك سابقاً
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
    );
  }
}