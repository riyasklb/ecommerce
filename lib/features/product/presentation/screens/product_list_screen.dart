import 'package:ecommerce/features/auth/data/auth_provider.dart';
import 'package:ecommerce/features/product/data/search_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/product_card.dart';
import '../../data/product_provider.dart';
import '../../model/product_model.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {

  final showFiltersProvider = StateProvider<bool>((ref) => false);
  String? selectedCategory;
  RangeValues priceRange = const RangeValues(0, 1000);
  TextEditingController searchController = TextEditingController();
  final priceRangeProvider =
      StateProvider<RangeValues>((ref) => const RangeValues(0, 1000));
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilterRow(),
          if (ref.watch(showFiltersProvider)) _buildFilters(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => ref.invalidate(productListProvider),
              child: products.when(
                data: (productList) => _buildProductList(productList),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(backgroundColor: Colors.white,
        title: Text('All PRODUCTS',
            style: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Image.asset('assets/images/logout.png', height: 30),
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
              if (mounted) context.go('/login');
            },
          ),
        ],
      );

  Widget _buildSearchAndFilterRow() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (value) => ref
                    .read(searchQueryProvider.notifier)
                    .state = value.toLowerCase(),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  hintText: 'Search for products...',
                  hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        const BorderSide(color: Color(0xFFB08888), width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: ref.watch(showFiltersProvider)
                      ? const Color(0xFFB08888)
                      : Colors.grey[200],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  ref.watch(showFiltersProvider)
                      ? Icons.filter_alt_off
                      : Icons.filter_alt,
                  color: ref.watch(showFiltersProvider)
                      ? Colors.white
                      : Colors.black54,
                  size: 24,
                ),
              ),
              onPressed: () => ref.read(showFiltersProvider.notifier).state =
                  !ref.read(showFiltersProvider),
            )
          ],
        ),
      );

  Widget _buildFilters() => Column(
        children: [
          Wrap(
            spacing: 8.0,
            children: Category.values
                .map((category) => ChoiceChip(
                      label: Text(category.name),
                      selected: selectedCategory == category.name,
                      onSelected: (selected) => setState(() =>
                          selectedCategory = selected ? category.name : null),
                    ))
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RangeSlider(
              values: ref.watch(priceRangeProvider),
              min: 0,
              max: 1000,
              divisions: 20,
              labels: RangeLabels(
                '\$${ref.watch(priceRangeProvider).start.toStringAsFixed(0)}',
                '\$${ref.watch(priceRangeProvider).end.toStringAsFixed(0)}',
              ),
              activeColor: const Color(0xFFB08888),
              inactiveColor: Colors.grey[300],
              //thumbColor: Colors.white,
              overlayColor: MaterialStateProperty.all(
                const Color(0xFFB08888).withOpacity(0.3),
              ),
              onChanged: (values) =>
                  ref.read(priceRangeProvider.notifier).state = values,
            ),
          )
        ],
      );

  Widget _buildProductList(List<ProductModel> productList) {
    final query = ref.watch(searchQueryProvider);
    final filteredProducts = productList
        .where((product) =>
            (query.isEmpty || product.title.toLowerCase().contains(query)) &&
            (selectedCategory == null ||
                product.category.name == selectedCategory) &&
            product.price >= priceRange.start &&
            product.price <= priceRange.end)
        .toList();

    return filteredProducts.isEmpty
        ? const Center(child: Text('No Products Available'))
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) =>
                ProductCard(product: filteredProducts[index]),
          );
  }
}
