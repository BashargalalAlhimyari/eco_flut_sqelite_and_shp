import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:flutter_application_2/screens/product_details.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../widgets/product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  final Category category;

  const CategoryProductsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context, listen: false).getProductsByCategory(category.id);

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: products.isEmpty
          ? const Center(child: Text('لا توجد منتجات في هذا القسم'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, i) {
                return ProductCard(
                  product: products[i],
               
                );
              },
            ),
    );
  }
}
