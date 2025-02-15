// features/products/data/models/product_model.dart
class ProductModel {
  final int id;
  final String title;
  final String image;
  final double price;
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'].toDouble(),
      rating: json['rating']['rate'].toDouble(),
    );
  }
}
