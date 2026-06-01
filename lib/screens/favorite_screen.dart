import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:flutter_application_2/widgets/product_card.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F7),
      appBar: AppBar(
        title: const Text('المفضلة'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<FavoritesProvider>(
          builder: (context, favProvider, child) {
            final favorites = favProvider.favoriteProducts;

            if (favorites.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 80,
                          color: Color(0xFFC0C0C0),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'قائمة المفضلة فارغة حالياً',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF181818),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'اضغط على أيقونة القلب في المنتجات لحفظها هنا.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 200,
                        height: 44,
                        child: OutlinedButton(
                          onPressed: () {
                            // العودة للتسوق
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFFF6A00)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            foregroundColor: const Color(0xFFFF6A00),
                          ),
                          child: const Text(
                            'اكتشف المنتجات',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: favorites[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}