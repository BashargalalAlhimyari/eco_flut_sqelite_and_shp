import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:flutter_application_2/screens/product_details.dart';
import 'package:provider/provider.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favProvider.favoriteItems;

    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: favorites.isEmpty
          ? const Center(child: Text('لا توجد منتجات في المفضلة'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, i) {
                return ProductCard(
                  product: favorites[i],
                 
                );
              },
            ),
    );
  }
}
