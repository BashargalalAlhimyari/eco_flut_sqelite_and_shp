import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(
              favProvider.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border,
              color: favProvider.isFavorite(product.id) ? Colors.red : null,
            ),
            onPressed: () {
              favProvider.toggleFavorite(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(favProvider.isFavorite(product.id) ? 'تمت الإضافة للمفضلة' : 'تمت الإزالة من المفضلة')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: Image.network(product.imageUrl, width: double.infinity, height: 300, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('${product.price} ريال', style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor)),
                  const SizedBox(height: 16),
                  Text('وصف المنتج:', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(product.description, style: theme.textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            cartProvider.addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تمت الإضافة إلى السلة بنجاح!')),
            );
          },
          icon: const Icon(Icons.shopping_cart),
          label: const Text('إضافة للسلة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
        ),
      ),
    );
  }
}
