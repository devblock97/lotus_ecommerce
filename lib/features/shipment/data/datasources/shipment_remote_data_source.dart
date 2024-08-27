import 'dart:convert';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/data/models/shipping.dart';
import 'package:http/http.dart' as http;

abstract class ShipmentRemoteDataSource {
  Future<CustomerModel> updateAddress(int userId, Shipping address) => throw UnimplementedError('Stub');
}

class ShipmentRemoteDataSourceImpl implements ShipmentRemoteDataSource {

  ShipmentRemoteDataSourceImpl(this.client);
  final http.Client client;

  @override
  Future<CustomerModel> updateAddress(int userId, Shipping address) async {
    try {
      final response = await client.put(
        Uri.parse('${ApiConfig.apiUrl}/wc/v3/customers/$userId'),
        headers: ApiConfig.headerSystem,
        body: jsonEncode({
          'shipping': address.toJson()
        })
      );
      print('status code: ${response.statusCode}');
      if (response.statusCode != 200) {
        throw ServerFailure(response.body);
      }
      return CustomerModel.fromJson(jsonDecode(response.body));
    } catch (_) {
    }
    throw Exception('unknown error');
  }

}