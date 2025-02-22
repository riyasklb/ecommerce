import 'package:ecommerce/features/cart/model/cart_model.dart';
import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartRepository {
  final List<CartItem> _cart = [];


  List<CartItem> get cartItems => List.unmodifiable(_cart);

 
  void addToCart(ProductModel product) {
    final index = _cart.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      _cart.add(CartItem(product: product, quantity: 1));
    } else {
      _cart[index].quantity++;
    }
  }

  void removeFromCart(ProductModel product) {
    _cart.removeWhere((item) => item.product.id == product.id);
  }


  void updateQuantity(ProductModel product, int quantity) {
    final index = _cart.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _cart[index].quantity = quantity;
    }
  }


  double get totalPrice => _cart.fold(
        0.0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );
}


final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});
