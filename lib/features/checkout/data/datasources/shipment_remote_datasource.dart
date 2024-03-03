
import 'dart:convert';

import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/models/customer_model.dart';
import 'package:http/http.dart' as http;

abstract class CheckOutRemoteDataSource {

  Future<CustomerModel> getRemoteCustomerInfo({required int userId})
    => throw UnimplementedError('Stub!');

}

class CheckoutRemoteDataSourceImpl implements CheckOutRemoteDataSource {

  final http.Client client;

  CheckoutRemoteDataSourceImpl({required this.client});


  @override
  Future<CustomerModel> getRemoteCustomerInfo({required int userId}) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConfig.URL}${ApiConfig.CUSTOMERS}/$userId'),
        headers: ApiConfig.HEADER
      );

      final customer = jsonDecode(response.body);
      return CustomerModel.fromJson(customer);

    } on ServerException {
      throw ServerException();
    }
  }



}