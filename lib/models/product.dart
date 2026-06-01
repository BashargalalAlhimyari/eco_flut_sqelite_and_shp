import 'package:hive/hive.dart';

part 'product_model.g.dart'; 

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final String id;

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

  // من Firestore إلى كائن Dart
  factory ProductModel.fromDoc(Map<String, dynamic> doc, String docId) {
    return ProductModel(
      id: docId,
      title: doc['title'] ?? doc['name'] ?? '', 
      price: _parsePrice(doc['price']),
      description: doc['description'] ?? '',
      category: doc['category'] ?? '',
      image: doc['image'] ?? '',
    );
  }

  static double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    if (price is num) return price.toDouble();
    if (price is String) {
      return double.tryParse(price) ?? 0.0;
    }
    return 0.0;
  }

  // من كائن Dart إلى Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };
  }
}