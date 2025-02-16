// import 'package:ecommerce/features/cart/data/cart_repository.dart';
// import 'package:ecommerce/features/cart/model/cart_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

//  final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());

// class CartNotifier extends StateNotifier<List<CartItem>> {
//   final CartRepository repository = CartRepository();

//   CartNotifier() : super([]);

//   void addItem(CartItem item) {
//     repository.addItem(item);
//     state = repository.items;
//   }

//   void removeItem(String id) {
//     repository.removeItem(id);
//     state = repository.items;
//   }

//   void updateQuantity(String id, int quantity) {
//     repository.updateQuantity(id, quantity);
//     state = repository.items;
//   }
// }