
import 'dart:convert';

import 'package:ecommerce_app/env/env.dart';
import 'package:flutter/foundation.dart';

class ApiConfig {

  static String API_URL = 'https://devblocks.tech/wp-json';
  static String CONSUMER_KEY = Env.consumerKey;
  static String CONSUMER_SECRECT = Env.consumerSecret;

  static String PRODUCTS = '/wc/v3/products';
  static String ORDERS = '/wc/v3/orders';
  static String CART = '/wc/store/v1/cart';
  static String ADD_ITEM = '/wc/store/v1/cart/add-item';
  static String UPDATE_ITEM = '/wc/store/v1/cart/update-item';
  static String REMOVE_ITEM = '/wc/store/v1/cart/remove-item';
  static String CUSTOMERS = '/wc/v3/customers';
  static String AUTH = '/jwt-auth/v1/token';

  static Map<String, String> HEADER = {
    'Authorization': 'Basic ${base64Encode(utf8.encode('${ApiConfig.CONSUMER_KEY}:${ApiConfig.CONSUMER_SECRECT}'))}',
    'Content-Type': 'application/json; charset=utf-8'
  };

}