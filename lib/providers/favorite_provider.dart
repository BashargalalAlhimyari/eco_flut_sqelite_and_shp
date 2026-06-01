import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/models/product.dart';

class FavoritesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  StreamSubscription<QuerySnapshot>? _favoritesSubscription;
  List<ProductModel> _favoriteProducts = [];

  List<ProductModel> get favoriteProducts => _favoriteProducts;

  FavoritesProvider() {
    // الاستماع الفوري لتغييرات حالة المستخدم لربط المفضلة بحساب المستخدم الحالي
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _listenToFavorites(user.uid);
      } else {
        _clearFavorites();
      }
    });
  }

  void _listenToFavorites(String userId) {
    _favoritesSubscription?.cancel();
    
    // الاستماع اللحظي لمجموعة المفضلة الخاصة بالمستخدم (snapshots)
    _favoritesSubscription = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .listen((snapshot) {
      _favoriteProducts = snapshot.docs.map((doc) {
        final data = doc.data();
        return ProductModel.fromDoc(data, doc.id);
      }).toList();
      notifyListeners();
    }, onError: (error) {
      debugPrint("خطأ أثناء الاستماع للمفضلة: $error");
    });
  }

  void _clearFavorites() {
    _favoritesSubscription?.cancel();
    _favoritesSubscription = null;
    _favoriteProducts = [];
    notifyListeners();
  }

  bool isFavorite(String productId) {
    return _favoriteProducts.any((p) => p.id == productId);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(product.id);

    final isFav = isFavorite(product.id);

    try {
      if (isFav) {
        // حذف من المفضلة
        await docRef.delete();
      } else {
        // إضافة للمفضلة باستخدام set() كما هو مطلوب في التمرين 3
        await docRef.set(product.toMap());
      }
    } catch (e) {
      debugPrint("حدث خطأ أثناء تعديل المفضلة: $e");
    }
  }

  // دالة لتحديث بيانات المفضلة تبرز استخدام update()
  Future<void> updateFavoriteInfo(String productId, Map<String, dynamic> data) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId);

    try {
      await docRef.update(data);
    } catch (e) {
      debugPrint("حدث خطأ أثناء تحديث بيانات المفضلة: $e");
    }
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    super.dispose();
  }
}