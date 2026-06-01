import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter/foundation.dart';

class CartDatabaseHelper {
  static final CartDatabaseHelper _instance = CartDatabaseHelper._internal();
  factory CartDatabaseHelper() => _instance;
  CartDatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart_items (
            id TEXT PRIMARY KEY,
            title TEXT,
            price REAL,
            image TEXT,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertOrUpdate(ProductModel product) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cart_items',
      where: 'id = ?',
      whereArgs: [product.id],
    );

    if (maps.isNotEmpty) {
      final currentQty = maps.first['quantity'] as int? ?? 1;
      await db.update(
        'cart_items',
        {'quantity': currentQty + product.quantity},
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } else {
      await db.insert(
        'cart_items',
        product.toSqliteMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<ProductModel>> getCartItems() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('cart_items');
      return List.generate(maps.length, (i) {
        return ProductModel.fromSqliteMap(maps[i]);
      });
    } catch (e) {
      debugPrint("Error reading cart items from sqlite: $e");
      return [];
    }
  }

  Future<void> updateQuantity(String id, int quantity) async {
    final db = await database;
    await db.update(
      'cart_items',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCartItem(String id) async {
    final db = await database;
    await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> saveAllCartItems(List<ProductModel> products) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('cart_items');
      for (var product in products) {
        await txn.insert(
          'cart_items',
          product.toSqliteMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
