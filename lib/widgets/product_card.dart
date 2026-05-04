import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/product_details.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  
  // قمنا بحذف المتغير onTap لأننا سنبرمج الانتقال داخلياً

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // 🚀 برمجة الانتقال إلى شاشة التفاصيل عند الضغط
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌟 صورة المنتج مع Hero Animation
            Expanded(
              child: Hero(
                tag: product.id, 
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            // 📝 تفاصيل المنتج (الاسم والسعر)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, 
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.price} ريال',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
