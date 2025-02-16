import 'package:ecommerce/features/auth/data/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/product_card.dart';
import '../../data/product_provider.dart';
import '../../model/product_model.dart';


class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  bool showFilters = false;
  String? selectedCategory;
  RangeValues priceRange = const RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
              if (mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search Products',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(showFilters ? Icons.filter_alt_off : Icons.filter_alt),
                  onPressed: () => setState(() => showFilters = !showFilters),
                ),
              ],
            ),
          ),
          if (showFilters) ...[
            Wrap(
              spacing: 8.0,
              children: Category.values.map((category) => ChoiceChip(
                label: Text(category.toString().split('.').last),
                selected: selectedCategory == category.toString(),
                onSelected: (selected) => setState(() =>
                  selectedCategory = selected ? category.toString() : null),
              )).toList(),
            ),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 1000,
              divisions: 20,
              labels: RangeLabels(
                '\$${priceRange.start.toStringAsFixed(0)}',
                '\$${priceRange.end.toStringAsFixed(0)}',
              ),
              onChanged: (values) => setState(() => priceRange = values),
            ),
          ],
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => ref.invalidate(productListProvider),
              child: products.when(
                data: (productList) {
                  final filteredProducts = productList.where((product) =>
                    (selectedCategory == null || product.category.toString() == selectedCategory) &&
                    (product.price >= priceRange.start && product.price <= priceRange.end)
                  ).toList();

                  return filteredProducts.isEmpty
                      ? const Center(child: Text('No Products Available'))
                      : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(product: product);
              },
            );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: ${error.toString()}')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
