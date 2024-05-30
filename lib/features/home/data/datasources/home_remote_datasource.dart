
import 'dart:convert';

import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> getAllProducts() => throw UnimplementedError('Stub');
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {

  HomeRemoteDataSourceImpl(this.client);

  final http.Client client;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      var url = Uri.parse(ApiConfig.apiUrl + ApiConfig.products);
      var header = {
        'Authorization': 'Basic ${base64Encode(utf8.encode('${ApiConfig.register}:${ApiConfig.consumerSecret}'))}'
      };
      final response = await client.get(url, headers: ApiConfig.headerSystem);
      if (response.statusCode == 200) {
        List<ProductModel> allProducts = [];
        final body = jsonDecode(response.body) as List;
        final products = body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          allProducts.add(ProductModel.fromJson(map));
          return ProductModel.fromJson(map);
        }).toList();
        return allProducts;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

}