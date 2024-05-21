import 'dart:convert';

import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/features/checkout/data/models/create_order.dart';
import 'package:ecommerce_app/features/checkout/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(Order order) => throw UnimplementedError('Stub');
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {

  final http.Client client;
  OrderRemoteDataSourceImpl({required this.client});

  @override
  Future<OrderModel> createOrder(Order order) async {
     try {
       final response = await client.post(
         Uri.parse('${ApiConfig.apiUrl}${ApiConfig.orders}'),
         headers: ApiConfig.header,
         body: jsonEncode(order.toJson())
       );
       return OrderModel.fromJson(jsonDecode(response.body));
     } on ServerException {
       throw ServerException();
     }
  }
}