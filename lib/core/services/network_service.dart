
import 'dart:convert';

import 'package:ecommerce_app/core/constants/api_config.dart';

import 'package:ecommerce_app/core/services/network_repository.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class NetworkService extends BaseRepository {

  final client = http.Client();

  @override
  Future<dynamic> delete(String endpoint) async {

  }

  @override
  Future<List<ProductModel>> get(String endpoint) async {
    var url = Uri.parse(ApiConfig.URL + endpoint);
    var response = await client.get(url, headers: ApiConfig.HEADER);
    print('status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        print('data response: ${map['name']}');
        return ProductModel.fromJson(map);
      }).toList();
    } else {
      throw Exception('Failed to loading data from server');
    }
  }

  @override
  Future<dynamic> post(String endpoint, dynamic body) async {
    final url = Uri.parse(ApiConfig.URL + endpoint);
    final response = await client.get(url, headers: ApiConfig.HEADER);
    return _handleResponse(response);
  }

  @override
  Future<dynamic> put(String endpoint, dynamic body) async {
    final url = Uri.parse(ApiConfig.URL + endpoint);
    final response = await client.put(url, headers: ApiConfig.HEADER);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to make network request');
    }
  }
}