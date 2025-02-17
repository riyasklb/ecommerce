import 'dart:convert';
import 'package:ecommerce/core/uri/api_constants.dart';
import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:ecommerce/core/utils/http_service.dart';

class ProductRepository {
  Future<List<ProductModel>> fetchProducts() async {
    final response = await HttpService.request(
      url: ApiConstants.productsEndpoint,
      method: 'GET',
    );

    if (response != null) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
