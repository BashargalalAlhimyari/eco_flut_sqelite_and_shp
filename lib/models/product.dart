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

  // Non-Hive field, defaults to 1, used for SQLite cart quantities
  final int quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.quantity = 1,
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
      quantity: 1,
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

  ProductModel copyWith({
    String? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromSqliteMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      image: map['image'] as String,
      description: '',
      category: '',
      quantity: map['quantity'] as int? ?? 1,
    );
  }
}