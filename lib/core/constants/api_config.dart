
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApiConfig {
  static String MOBILE_URL = 'https://192.168.110.47/senhong/wp-json/wc/v3';
  static String WEB_URL = 'https://localhost/senhong/wp-json/wc/v3';
  static String URL = kIsWeb ? WEB_URL : MOBILE_URL;
  static String CONSUMER_KEY = 'ck_27711f499d97c090120b9dcef1e1f40af1778570';
  static String CONSUMER_SECRECT = 'cs_f62d5e2ce67c8bc1be8cd46a915e36adcb5f1aa2';

  static String PRODUCS = '/products';
  static String ORDERS = '/orders';

  static Map<String, String> HEADER = {
    'Authorization': 'Basic ' + base64Encode(utf8.encode('${ApiConfig.CONSUMER_KEY}:${ApiConfig.CONSUMER_SECRECT}')),
    'Content-Type': 'application/json; charset=utf-8'
  };

}