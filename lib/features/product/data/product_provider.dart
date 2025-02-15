// features/products/providers/product_provider.dart
import 'package:ecommerce/features/product/data/product_repositrys.dart';
import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productListProvider = FutureProvider<List<ProductModel>>((ref) async {
  final repository = ref.read(productRepositoryProvider);
  return repository.fetchProducts();
});
