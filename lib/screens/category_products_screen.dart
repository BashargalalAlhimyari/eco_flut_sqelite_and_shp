import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:flutter_application_2/widgets/product_card.dart';
import 'package:provider/provider.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryProductsScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProductsProvider>(
      builder: (context, productsProvider, child) {
        // تصفية المنتجات التي تنتمي لهذه الفئة فقط
        final products = productsProvider.products
            .where((p) => p.category == categoryName)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoryName.toUpperCase()),
                Text(
                  '${products.length} منتج',
                  style: theme.textTheme.labelSmall?.copyWith(color: theme.hintColor),
                ),
              ],
            ),
          ),
          body: products.isEmpty
              ? _buildEmptyState(theme)
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65, // النسبة المثالية للـ ProductCard الجديد
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: products[index],
                    );
                  },
                ),
        );
      },
    );
  }

  // واجهة في حال كان القسم فارغاً
  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.category_outlined, size: 70, color: theme.hintColor.withOpacity(0.4)),
          const SizedBox(height: 16),
          Text(
            'لا توجد منتجات متوفرة حالياً في هذا القسم',
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}