import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseSeeder {
  static Future<void> seedProducts() async {
    final firestore = FirebaseFirestore.instance;
    final CollectionReference productsRef = firestore.collection('products');

    // مسح المنتجات القديمة أولاً لضمان تحديث روابط الصور
    try {
      final existingDocs = await productsRef.get();
      final WriteBatch deleteBatch = firestore.batch();
      for (var doc in existingDocs.docs) {
        deleteBatch.delete(doc.reference);
      }
      await deleteBatch.commit();
      debugPrint("تم تنظيف المنتجات القديمة بنجاح.");
    } catch (e) {
      debugPrint("خطأ أثناء تنظيف المنتجات القديمة: $e");
    }

    final List<Map<String, dynamic>> dummyProducts = [
      {
        'title': 'حقيبة ظهر فيالرافين كولومبيا',
        'price': 109.95,
        'description': 'حقيبة ممتازة للاستخدام اليومي وتتسع للابتوب وسهلة التنقل.',
        'category': 'إكسسوارات',
        'image': 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&q=80',
      },
      {
        'title': 'تيشيرت رجالي كاجوال ضيق',
        'price': 22.3,
        'description': 'تيشيرت رجالي مريح، قطن 100% وأنيق جداً للمناسبات غير الرسمية.',
        'category': 'ملابس رجالية',
        'image': 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&q=80',
      },
      {
        'title': 'جاكيت قطني كلاسيكي رجالي',
        'price': 55.99,
        'description': 'جاكيت شتوي وربيعي ممتاز ومناسب ومقاوم للبرودة وخفيف الوزن.',
        'category': 'ملابس رجالية',
        'image': 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400&q=80',
      },
      {
        'title': 'سوار ذهب وفضة للنساء مصمم خصيصاً',
        'price': 695.0,
        'description': 'سوار نسائي أنيق ومميز مطلي بالذهب والفضة ومناسب للهدايا الفاخرة.',
        'category': 'مجوهرات',
        'image': 'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400&q=80',
      },
      {
        'title': 'شاشة سامسونج منحنية ألعاب 49 بوصة',
        'price': 999.99,
        'description': 'شاشة ألعاب عريضة ومنحنية توفر تجربة لعب غامرة بمعدل تحديث فائق السرعة.',
        'category': 'إلكترونيات',
        'image': 'https://images.unsplash.com/photo-1593640408182-31c228f4c9ac?w=400&q=80',
      },
      {
        'title': 'لاب توب ايسر سويفت 3 نحيف جداً',
        'price': 899.99,
        'description': 'لابتوب خفيف الوزن ونحيف ومناسب للأعمال الشاقة وبطارية تدوم طويلاً.',
        'category': 'إلكترونيات',
        'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400&q=80',
      },
      {
        'title': 'قرص صلب خارجي WD Elements سعة 2 تيرابايت',
        'price': 64.0,
        'description': 'مساحة تخزين خارجية محمولة وسريعة سعة 2 تيرابايت متوافقة مع USB 3.0.',
        'category': 'إلكترونيات',
        'image': 'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=400&q=80',
      },
      {
        'title': 'قرص صلب داخلي SanDisk SSD سعة 1 تيرابايت',
        'price': 109.0,
        'description': 'قرص صلب داخلي ذو حالة صلبة فائق السرعة لتسريع إقلاع وتشغيل نظام التشغيل.',
        'category': 'إلكترونيات',
        'image': 'https://images.unsplash.com/photo-1618410320928-25228d811631?w=400&q=80',
      },
      {
        'title': 'خاتم خطوبة أنيق مطلي بالذهب الوردي',
        'price': 10.99,
        'description': 'خاتم نسائي جذاب وناعم مطلي بالذهب الوردي ومرصع بفصوص الكريستال البراقة.',
        'category': 'مجوهرات',
        'image': 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=400&q=80',
      },
      {
        'title': 'جاكيت نسائي رياضي خفيف مقاوم للماء والرياح',
        'price': 39.99,
        'description': 'جاكيت نسائي رياضي خفيف ومثالي للجري والرحلات ومقاوم كلياً للمطر الخفيف.',
        'category': 'ملابس نسائية',
        'image': 'https://images.unsplash.com/photo-1548126032-079a0fb0099d?w=400&q=80',
      },
      {
        'title': 'بلوزة نسائية كاجوال مريحة بأكمام قصيرة',
        'price': 9.85,
        'description': 'بلوزة نسائية خفيفة بتصميم مريح وعصري، مناسبة للاستخدام اليومي والطلعات الكاجوال.',
        'category': 'ملابس نسائية',
        'image': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400&q=80',
      },
    ];

    try {
      final WriteBatch batch = firestore.batch();
      for (var product in dummyProducts) {
        final docRef = productsRef.doc();
        batch.set(docRef, product);
      }
      await batch.commit();
      debugPrint("تمت إضافة البيانات العشوائية بنجاح عبر Batch!");
    } catch (e) {
      debugPrint("حدث خطأ أثناء إضافة البيانات: $e");
      rethrow;
    }
  }
}
