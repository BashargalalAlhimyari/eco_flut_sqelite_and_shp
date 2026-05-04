import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/theme/theme_provider.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../widgets/product_card.dart'; // 👈 استدعاء الويدجت المنفصلة هنا

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final categories = productsProvider.categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('متجري الذكي'),
       actions: [
    // 👈 زر تبديل الثيم
    Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () {
            themeProvider.toggleTheme(); // استدعاء دالة التبديل
          },
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {},
    ),
  ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final categoryProducts = productsProvider.getProductsByCategory(category.id);

          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 400 + (index * 200)),
            curve: Curves.easeOutCubic,
            builder: (context, double value, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: _buildCategorySection(context, category, categoryProducts),
          );
        },
      ),
    );
  }

  // بناء قسم كامل (عنوان القسم + قائمة المنتجات الأفقية)
  Widget _buildCategorySection(BuildContext context, Category category, List<Product> products) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(category.imageUrl, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    category.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // الانتقال لصفحة منتجات القسم
                },
                child: const Text('عرض الكل'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        
        // قائمة المنتجات الأفقية
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: products.length,
            itemBuilder: (context, index) {
              // 👇 هنا نستخدم الويدجت المنفصلة بدلاً من الدالة الداخلية
              return SizedBox(
                width: 160,
                child: ProductCard(
                  product: products[index],
                 
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
