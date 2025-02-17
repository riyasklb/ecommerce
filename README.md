# 🛒 E-Commerce App with Flutter

## 🚀 Overview
Welcome to the Flutter E-Commerce App! This app offers a complete shopping experience with user authentication, product browsing, search and filter functionality, and a fully-featured shopping cart — all powered by Riverpod for state management and Firebase for authentication.

### 🌟 Key Features
- **👤 User Authentication:**
  - Sign up, log in, log out, and reset passwords using Firebase.
  - Email/password-based authentication with error handling.

- **🛍️ Product Listing:**
  - Fetch products from FakeStoreAPI.
  - Display items in a grid with images, names, prices, and ratings.
  - Support pull-to-refresh for easy browsing.

- **📖 Product Details:**
  - View detailed descriptions, ratings, and reviews.
  - Add items to the cart instantly.

- **🛒 Shopping Cart:**
  - Add, remove, and update item quantities.
  - Show total price and item counts dynamically.

- **🔍 Search & Filter:**
  - Search products by name.
  - Filter by category, price range, and ratings.

### 🛤️ Routing & Authentication Check
- The app uses `go_router` for smooth navigation.
- On startup, the app checks if a user is logged in and navigates to the appropriate screen (login or home).

## 📂 Project Structure (Organized for Scale)
```
lib/
├── core/
│   ├── errors/ (Custom error classes)
│   ├── navigation/ (Routing configuration)
│   ├── theme/ (App-wide theming)
│   ├── widgets/ (Reusable components)
│   └── utils/ (Helpers and validators)
│
├── features/
│   ├── auth/ (Authentication logic)
│   ├── product/ (Product listing and details)
│   └── cart/ (Shopping cart management)
│
└── main.dart (App entry point with routing and auth check)
```

## 📦 Dependencies
- `flutter_riverpod` for state management
- `firebase_auth` for user authentication
- `go_router` for navigation
- `shared_preferences` for local storage
- `cached_network_image` for faster image loading

## 🛡️ Error Handling
- **Auth Errors:** Custom error messages for login/signup issues.
- **API Errors:** Friendly messages for network issues.
- **Global Handling:** Catch unhandled exceptions with alerts.

## 💪 Contributing
We welcome your contributions! Please open an issue or pull request if you’d like to improve the app.

## 📜 License
This project is open-source under the MIT License. Enjoy building and happy coding! 💙🚀


## 📜 githublink
https://github.com/riyasklb/ecommerce