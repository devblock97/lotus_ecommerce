import 'dart:convert';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/utils/secure_storage.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<Cart> getCarts() => throw UnimplementedError('Stub');
  Future<Cart> addProductToCart(CartItemModel item) => throw UnimplementedError('Stub');
  Future<Cart> removeProductToCart(String key) => throw UnimplementedError('Stub');
  Future<Cart> updateCart(String key, int quantity) => throw UnimplementedError('Stub');
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {

  CartRemoteDataSourceImpl(this.client);

  final http.Client client;

  @override
  Future<Cart> addProductToCart(CartItemModel item) async {
    try {
      final secureStorage = SecureStorage();
      final token = await secureStorage.readToken();
      final nonce = await secureStorage.readNonce();
      final response = await client.post(
        Uri.parse('${ApiConfig.API_URL}${ApiConfig.ADD_ITEM}'),
        body: jsonEncode({
          'id': item.product.id,
          'quantity': item.quantity
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Nonce': '$nonce'
        }
      );
      print('checking add to cart: ${jsonDecode(response.body)}');
      return Cart.fromJson(jsonDecode(response.body));

    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<Cart> getCarts() async {
    try {
      final secureStorage = SecureStorage();
      final token = await secureStorage.readToken();
      final nonce = await secureStorage.readNonce();
      final response = await client.get(
          Uri.parse('${ApiConfig.API_URL}${ApiConfig.CART}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Nonce': '$nonce'
          }
      );
      print('header: ${response.statusCode} - ${response.headers}');
      if (response.statusCode == 200) {
        final secureStorage = SecureStorage();
        final value = parseNonceFromHeader(response.headers);
        print('checking nonce: $value');
        secureStorage.writeNonce(value);
      }
      final cart = Cart.fromJson(jsonDecode(response.body));
      print('cart here: ${cart.itemsCount}');
      return cart;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Cart> removeProductToCart(String key) async {
    try {
      final secureStorage = SecureStorage();
      final nonce = await secureStorage.readNonce();
      final token = await secureStorage.readToken();
      final response = await client.post(
        Uri.parse('${ApiConfig.API_URL}${ApiConfig.REMOVE_ITEM}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Nonce': '$nonce'
          },
        body: jsonEncode({
          'key': key
        })
      );
      print('remove cart response: ${response.body}');
      return Cart.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Cart> updateCart(String key, int quantity) async {
    try {
      final secureStorage = SecureStorage();
      final token = await secureStorage.readToken();
      final nonce = await secureStorage.readNonce();
      final response = await client.post(
        Uri.parse('${ApiConfig.API_URL}${ApiConfig.UPDATE_ITEM}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Nonce': '$nonce'
        },
        body: jsonEncode({
          'key': key,
          'quantity': quantity
        })
      );
      final update = Cart.fromJson(jsonDecode(response.body));
      print('update cart item status code: ${response.statusCode} ${update.item?.length}');
      return Cart.fromJson(jsonDecode(response.body));
    } on ServerException catch (e) {
      throw ServerException();
    }
  }

}

String parseNonceFromHeader(Map<String, String> headers) {
  // Check for both possibilities (nonce and x-wc-store-api-nonce)
  if (headers.containsKey('nonce')) {
    return headers['nonce']!;
  } else if (headers.containsKey('x-wc-store-api-nonce')) {
    return headers['x-wc-store-api-nonce']!;
  } else {
    throw Exception('Nonce not found in headers');
  }
}