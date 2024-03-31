
import 'dart:convert';

import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CheckOutLocalDataSource {
  Future<CustomerModel> getLocalCustomerInfo() => throw UnimplementedError('Stub!');
  Future<void> cachedCustomer(CustomerModel customer) => throw UnimplementedError('Stub!');
}

const CACHED_CUSTOMER_INFO = 'CACHED_CUSTOMER_INFO';

class CheckOutLocalDataSourceImpl implements CheckOutLocalDataSource {

  final SharedPreferences sharedPreferences;

  CheckOutLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CustomerModel> getLocalCustomerInfo() {
    final customerString = sharedPreferences.getString(CACHED_CUSTOMER_INFO);
    if (customerString != null) {
      return Future.value(CustomerModel.fromJson(jsonDecode(customerString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachedCustomer(CustomerModel customer) {
    return sharedPreferences.setString(CACHED_CUSTOMER_INFO, jsonEncode(customer.toJson()));
  }

}