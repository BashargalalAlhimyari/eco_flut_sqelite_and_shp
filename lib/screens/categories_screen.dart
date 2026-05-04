import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:flutter_application_2/screens/category_products_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ProductsProvider>(context, listen: false).categories;

    return Scaffold(
      appBar: AppBar(title: const Text('الأقسام')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return CategoryCard(
            category: categories[i],
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(category: categories[i])));
            },
          );
        },
      ),
    );
  }
}
