// features/products/data/repositories/product_repository.dart
import 'dart:convert';
import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:http/http.dart' as http;


class ProductRepository {
  static const String apiUrl = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
