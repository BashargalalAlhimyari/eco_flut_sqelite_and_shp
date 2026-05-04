import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('سلة المشتريات')),
      body: cartItems.isEmpty
          ? const Center(child: Text('السلة فارغة حالياً'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, i) {
                      final item = cartItems[i];
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(item.product.imageUrl)),
                        title: Text(item.product.name),
                        subtitle: Text('الكمية: ${item.quantity} x ${item.product.price} ريال'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => cart.removeItem(item.product.id),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('الإجمالي:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('${cart.totalAmount} ريال', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
