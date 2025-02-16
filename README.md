📱 E-Commerce App with Flutter
🛒 Overview
This is a Flutter-based E-Commerce App that includes Firebase Authentication, product listing, search & filter, and cart management. Riverpod is used for state management.

🚀 Features
1️⃣ User Authentication
✅ Email/password-based authentication with Firebase.
✅ Sign up, log in, log out, and forgot password functionality.

2️⃣ Product Listing
✅ Fetch products from FakeStoreAPI.
✅ Display products in a grid format with images, names, prices, and ratings.
✅ Pull-to-refresh support.

3️⃣ Product Details Page
✅ Show detailed product information (description, price, rating, reviews).
✅ "Add to Cart" button for easy purchasing.

4️⃣ Shopping Cart
✅ Add/remove products from the cart.
✅ Display total price and item quantity.
✅ Update item quantities in the cart.

5️⃣ Search and Filter
✅ Search for products by name.
✅ Filter products by category, price range, and rating.📱 E-Commerce App with Flutter
🛒 Overview
This is a Flutter-based E-Commerce App that includes Firebase Authentication, product listing, search & filter, and cart management. Riverpod is used for state management.

🚀 Features
1️⃣ User Authentication
✅ Email/password-based authentication with Firebase.
✅ Sign up, log in, log out, and forgot password functionality.

2️⃣ Product Listing
✅ Fetch products from FakeStoreAPI.
✅ Display products in a grid format with images, names, prices, and ratings.
✅ Pull-to-refresh support.

3️⃣ Product Details Page
✅ Show detailed product information (description, price, rating, reviews).
✅ "Add to Cart" button for easy purchasing.

4️⃣ Shopping Cart
✅ Add/remove products from the cart.
✅ Display total price and item quantity.
✅ Update item quantities in the cart.

5️⃣ Search and Filter
✅ Search for products by name.
✅ Filter products by category, price range, and rating.

📂 Project Structure


lib/
├── core/
│   ├── errors/
│   │   └── auth_exception.dart
│   ├── navigation/
│   │   └── app_router.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── widgets/
│   │   ├── custom_button.dart
│   │   ├── custom_text_field.dart
│   │   ├── custom_loader.dart
│   │   ├── cart_item_widget.dart
│   │   ├── custom_app_bar.dart
│   │   └── icons.dart
│   ├── utils/
│   │   ├── validators.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── auth_provider.dart
│   │   │   └── auth_repository.dart
│   │   ├── presentation/
│   │   │   ├── login_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   └── forgot_password_screen.dart
│
│   ├── product/
│   │   ├── data/
│   │   │   ├── product_api_service.dart
│   │   │   └── product_repository.dart
│   │   ├── presentation/
│   │   │   ├── product_list_screen.dart
│   │   │   ├── product_detail_screen.dart
│
│   ├── cart/
│   │   ├── data/
│   │   │   └── cart_repository.dart
│   │   ├── presentation/
│   │   │   ├── cart_screen.dart
│
└── main.dart


📦 Dependencies

dependencies:
  cupertino_icons: ^1.0.8
  flutter_riverpod: ^2.6.1
  firebase_core: ^3.11.0
  go_router: ^14.8.0
  dio: ^5.8.0+1
  google_fonts: ^6.2.1
  firebase_auth: ^5.4.2
  shared_preferences: ^2.5.2
  cached_network_image: ^3.4.1


git repository  --> https://github.com/riyasklb/ecommerce

🤝 Contributing
Pull requests are welcome! If you want to make a significant change, open an issue first to discuss your idea.

📜 License
This project is open-source and available under the MIT License.



