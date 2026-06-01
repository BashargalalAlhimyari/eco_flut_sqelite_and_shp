import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/widgets/product_card.dart';
import 'package:flutter_application_2/utils/seeder.dart';
import 'package:flutter_application_2/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد عدد الأعمدة بناءً على عرض الشاشة للتوافق مع الهواتف واللابتوب
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المنتجات المتاحة 🛒',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode_outlined,
                  color: const Color(0xFFFF6A00),
                ),
                tooltip: themeProvider.isDarkMode ? 'الوضع الفاتح' : 'الوضع الداكن',
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.redAccent),
            tooltip: 'تسجيل الخروج',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('تسجيل الخروج'),
                  content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('خروج', style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // دعم كامل للغة العربية
        child: StreamBuilder<QuerySnapshot>(
          // جلب البيانات حياً ومباشرة من مجموعة 'products' في Firestore
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            // 1. حالة التحميل والاتصال
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6A00)),
                ),
              );
            }

            // 2. حالة حدوث خطأ في جلب البيانات
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                      const SizedBox(height: 12),
                      Text(
                        'حدث خطأ أثناء تحميل البيانات:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              );
            }

            // 3. حالة عدم وجود أي منتجات في قاعدة البيانات - إظهار زر تهيئة المنتجات
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        'قاعدة البيانات فارغة حالياً!\nلا توجد منتجات لعرضها.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'اضغط على الزر أدناه لبذر قاعدة البيانات بـ 11 منتجاً حقيقياً ومزامنتها على السحابة.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6A00)),
                              ),
                            ),
                          );
                          try {
                            await DatabaseSeeder.seedProducts();
                            if (!context.mounted) return;
                            Navigator.pop(context); // إغلاق مؤشر التحميل
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم بذر المنتجات في Firestore بنجاح!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } catch (e) {
                            if (!context.mounted) return;
                            Navigator.pop(context); // إغلاق مؤشر التحميل
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('حدث خطأ أثناء إضافة المنتجات: $e'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.cloud_upload_outlined),
                        label: const Text('إضافة 11 منتجاً تجريبياً إلى Firestore'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6A00),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // 4. بناء الشبكة وعرض المنتجات بنجاح باستخدام Model class
            final docs = snapshot.data!.docs;
            final productsList = docs.map((doc) {
              return ProductModel.fromDoc(doc.data() as Map<String, dynamic>, doc.id);
            }).toList();

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65, // نسبة تناسب الكارت لتفادي أي Overflow مع المحتوى
              ),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                return ProductCard(product: productsList[index]);
              },
            );
          },
        ),
      ),
    );
  }
}