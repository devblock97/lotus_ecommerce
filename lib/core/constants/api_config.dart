
import 'dart:convert';

import 'package:ecommerce_app/env/env.dart';
import 'package:flutter/foundation.dart';

class ApiConfig {

  static String apiUrl = 'https://devblocks.tech/wp-json';
  static String consumerKey = Env.consumerKey;
  static String consumerSecret = Env.consumerSecret;

  static String products = '/wc/v3/products';
  static String orders = '/wc/v3/orders';
  static String cart = '/wc/store/v1/cart';
  static String addItem = '/wc/store/v1/cart/add-item';
  static String deleteAllItems = '/wc/store/v1/cart/items';
  static String updateItem = '/wc/store/v1/cart/update-item';
  static String removeItem = '/wc/store/v1/cart/remove-item';
  static String customer = '/wc/v3/customers';
  static String auth = '/jwt-auth/v1/token';

  static Map<String, String> header = {
    'Authorization': 'Basic ${base64Encode(utf8.encode('${ApiConfig.consumerKey}:${ApiConfig.consumerSecret}'))}',
    'Content-Type': 'application/json; charset=utf-8'
  };

}