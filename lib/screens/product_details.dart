import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/providers/cart_provider.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F7),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.4),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- منطقة عرض الصورة ---
              Stack(
                children: [
                  Container(
                    height: 380,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Hero(
                        tag: 'product_${product.id}',
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image.network(product.image, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                  // زر المفضلة العائم
                  Positioned(
                    bottom: 16,
                    left: 20,
                    child: Consumer<FavoritesProvider>(
                      builder: (context, favProvider, _) {
                        final isFav = favProvider.isFavorite(product.id);
                        return GestureDetector(
                          onTap: () => favProvider.toggleFavorite(product),
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? const Color(0xFFFA3E3E) : const Color(0xFF888888),
                              size: 24,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              // --- تفاصيل المنتج ---
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // السعر والاسم
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E5E5), width: 0.8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.price.toStringAsFixed(2)} \$',
                            style: const TextStyle(
                              color: Color(0xFFFF6A00),
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF181818),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // التقييم والتوصيل السريع بأسلوب علي بابا
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E5E5), width: 0.8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.star, color: Color(0xFFFF9E00), size: 18),
                              SizedBox(width: 6),
                              Text(
                                "4.8",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF181818)),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "150 مراجعة",
                                style: TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                              Spacer(),
                              Text(
                                "التقييمات والمراجعات",
                                style: TextStyle(color: Color(0xFFFF6A00), fontSize: 13, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          Row(
                            children: const [
                              Icon(Icons.local_shipping_outlined, color: Colors.green, size: 18),
                              SizedBox(width: 8),
                              Text(
                                "شحن مجاني وسريع",
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green, fontSize: 13),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // الوصف والتفاصيل
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E5E5), width: 0.8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'تفاصيل المنتج 📄',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF181818),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF555555),
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100), // للتأكد من عدم تغطية الزر السفلي للمحتوى
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text('تمت إضافة المنتج بنجاح!'),
                          ),
                          backgroundColor: const Color(0xFFFF6A00),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                    label: const Text(
                      'إضافة إلى السلة',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6A00),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}