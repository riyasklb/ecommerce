import 'package:ecommerce/features/cart/data/cart_provider.dart';
import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CartScreen extends ConsumerWidget {
   final ProductModel product;

  CartScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final cartItems = ref.watch(cartProvider);
    
    // Corrected total price calculation with proper type handling
    final double totalPrice = cartItems.fold<double>(
      0.0,
      (total, item) => total + item.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text('₹${(item.price * item.quantity).toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => ref.read(cartProvider.notifier).updateQuantity(item.id, item.quantity - 1),
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => ref.read(cartProvider.notifier).updateQuantity(item.id, item.quantity + 1),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Checkout (₹${totalPrice.toStringAsFixed(2)})'),
        ),
      ),
    );
  }
}
