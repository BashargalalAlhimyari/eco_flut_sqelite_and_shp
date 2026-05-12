import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة المشتريات'),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;

          if (cartItems.isEmpty) {
            return _buildEmptyCart(theme);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    return _buildCartItem(context, product, cartProvider, theme);
                  },
                ),
              ),
              _buildCheckoutSection(context, cartProvider, theme),
            ],
          );
        },
      ),
    );
  }

  // بناء عنصر واحد في السلة
  Widget _buildCartItem(BuildContext context, dynamic product, CartProvider provider, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // صورة المنتج
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(product.image, fit: BoxFit.contain),
          ),
          const SizedBox(width: 16),
          // تفاصيل المنتج
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.price} \$',
                  style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // التحكم في الكمية (إذا أضفت حقل quantity في الموديل)
                Row(
                  children: [
                    _buildQuantityBtn(Icons.remove, () {
                      // هنا تضع منطق نقص الكمية
                    }, theme),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    _buildQuantityBtn(Icons.add, () {
                      // هنا تضع منطق زيادة الكمية
                    }, theme),
                  ],
                ),
              ],
            ),
          ),
          // زر الحذف
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () => provider.removeFromCart(product.id),
          ),
        ],
      ),
    );
  }

  // زر زيادة ونقص الكمية
  Widget _buildQuantityBtn(IconData icon, VoidCallback onTap, ThemeData theme) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  // قسم الحساب النهائي
  Widget _buildCheckoutSection(BuildContext context, CartProvider provider, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الإجمالي المستحق', style: theme.textTheme.titleMedium),
                Text(
                  '${provider.totalPrice.toStringAsFixed(2)} \$',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // منطق الدفع أو إرسال الطلب
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('إتمام عملية الشراء', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // واجهة السلة الفارغة
  Widget _buildEmptyCart(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: theme.hintColor.withOpacity(0.3)),
          const SizedBox(height: 20),
          const Text('سلتك لا تزال فارغة!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('أضف بعض المنتجات لتبدأ التسوق'),
        ],
      ),
    );
  }
}