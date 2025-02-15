// features/products/presentation/screens/product_list_screen.dart
import 'package:ecommerce/features/product/presentation/screens/product_detail_screen.dart';

import 'package:ecommerce/features/product/data/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(productListProvider);
        },
        child: products.when(
          data: (productList) {
            if (productList.isEmpty) {
              return const Center(child: Text('No Products Available'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: ProductCard(product: product),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: ${error.toString()}')),
        ),
      ),
    );
  }
}
