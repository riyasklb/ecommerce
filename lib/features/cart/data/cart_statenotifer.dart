import 'package:ecommerce/features/cart/data/cart_repository.dart';
import 'package:ecommerce/features/cart/model/cart_model.dart';
import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  final CartRepository _cartRepository;

  CartNotifier(this._cartRepository) : super([]);

  // Load cart from repository
  void loadCart() {
    state = _cartRepository.cartItems;
  }

  // Add item to cart
  void addToCart(ProductModel product) {
    _cartRepository.addToCart(product);
    state = [..._cartRepository.cartItems];
  }

  // Remove item from cart
  void removeFromCart(ProductModel product) {
    _cartRepository.removeFromCart(product);
    state = [..._cartRepository.cartItems];
  }

  // Update item quantity
  void updateQuantity(ProductModel product, int quantity) {
    _cartRepository.updateQuantity(product, quantity);
    state = [..._cartRepository.cartItems];
  }

  // Get total price
  double get totalPrice => _cartRepository.totalPrice;
}

// Cart Provider
final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final repository = ref.read(cartRepositoryProvider);
  return CartNotifier(repository);
});
