import 'dart:convert';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/core/data/models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<CustomerModel> getCustomer({required int id}) => throw UnimplementedError('Stub');
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {

  final http.Client client;
  CustomerRemoteDataSourceImpl({required this.client});

  @override
  Future<CustomerModel> getCustomer({required int id}) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConfig.API_URL}${ApiConfig.CUSTOMERS}/$id'),
        headers: ApiConfig.HEADER
      );
      return CustomerModel.fromJson(jsonDecode(response.body));
    } on ServerException {
      throw ServerException();
    }
  }

}