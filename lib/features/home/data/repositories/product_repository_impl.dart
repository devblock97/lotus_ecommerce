
import 'dart:convert';

import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';

import '../../../../core/constants/api_config.dart';
import 'package:http/http.dart' as http;

class ProductRepositoryImpl implements ProductRepository {

  final client = http.Client();

  @override
  Future<List<ProductModel>> getAllProducts() async {
    var url = Uri.parse(ApiConfig.URL + ApiConfig.PRODUCTS);
    var header = {
      'Authorization': 'Basic ${base64Encode(utf8.encode('${ApiConfig.CONSUMER_KEY}:${ApiConfig.CONSUMER_SECRECT}'))}'
    };
    var response = await client.get(url, headers: header);
    print('status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;

      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        final product = ProductModel.fromJson(map);
        print('data response: ${product.name}, ${product.images![0].src}');

        return ProductModel.fromJson(map);
      }).toList();
    } else {
      throw Exception('Failed to loading data from server');
    }
  }

}