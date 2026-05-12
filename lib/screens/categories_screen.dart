import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/category_provider.dart';
import 'package:flutter_application_2/screens/category_products_screen.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأقسام'),
        centerTitle: true,
      ),
      body: Consumer<CategoriesProvider>(
        builder: (context, catProvider, child) {
          // حالة التحميل
          if (catProvider.state == CategoryState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // حالة الخطأ
          if (catProvider.state == CategoryState.error) {
            return Center(child: Text("فشل تحميل الأقسام"));
          }

          final categories = catProvider.categories;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1, // لجعل الكروت مستطيلة قليلاً وأنيقة
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final String categoryName = categories[index];
              
              // توليد لون عشوائي متناسق مع الثيم لكل قسم
              final Color categoryColor = Colors.primaries[index % Colors.primaries.length].withOpacity(0.7);

              return _buildCategoryCard(context, categoryName, categoryColor, theme);
            },
          );
        },
      ),
    );
  }

  // بناء كارت القسم بشكل جذاب
  Widget _buildCategoryCard(BuildContext context, String name, Color color, ThemeData theme) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProductsScreen(categoryName: name),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color.withOpacity(0.4)],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // أيقونة خلفية خفيفة لتعطي مظهراً جمالياً
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                Icons.category_rounded,
                size: 80,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}