import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/core/utils/secure_storage.dart';
import 'package:ecommerce_app/core/utils/utils.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<Cart> getCarts() => throw UnimplementedError('Stub');
  Future<Cart> addItem(CartItemModel item) => throw UnimplementedError('Stub');
  Future<Cart> deleteItem(String key) => throw UnimplementedError('Stub');
  Future<Cart> updateItem(String key, int quantity) => throw UnimplementedError('Stub');
  Future<Cart> deleteAllItems() => throw UnimplementedError('Stub');
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {

  CartRemoteDataSourceImpl(this.client);

  final http.Client client;

  @override
  Future<Cart> addItem(CartItemModel item) async {
    try {
      final secureStorage = SecureStorage();
      final token = await secureStorage.readToken();
      final nonce = await secureStorage.readNonce();
      print('token here: $token - $nonce');
      final response = await client.post(
        Uri.parse('${ApiConfig.apiUrl}${ApiConfig.addItem}'),
        body: jsonEncode({
          'id': item.product.id,
          'quantity': item.quantity
        }),
        headers: ApiConfig.headerPersonal(token!, nonce!)
      );

      debugPrint('check response: ${jsonDecode(response.body)}');

      if (response.statusCode < 200 && response.statusCode > 209) {
        throw ServerFailure(SERVER_RESPONSE_ERROR);
      }

      if (response.statusCode == 403) {
        debugPrint('check nonce add to card: ${response.headers}');
        secureStorage.writeNonce(parseNonceFromHeader(response.headers));
        return addItem(item);
      }

      debugPrint('add to cart code: ${response.statusCode}');
      return Cart.fromJson(jsonDecode(response.body));

    } on SocketException catch(e) {
      throw NetworkFailure('cart [addItem] issue [SocketException]: ${e.message}');
    } on HttpException catch (e) {
      throw HttpException('cart [addItem] issue [HttpException]: ${e.message}');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Cart> getCarts() async {
    try {
      final secureStorage = SecureStorage();
      final token = await secureStorage.readToken();
      final nonce = await secureStorage.readNonce();
      final response = await client.get(
          Uri.parse('${ApiConfig.apiUrl}${ApiConfig.cart}'),
          headers: ApiConfig.headerPersonal(token!, nonce)
      );
      debugPrint('check trigger cart: ${response.statusCode}; $token; $nonce');
      // if (response.statusCode == 200) {
      //   final secureStorage = SecureStorage();
      //   final value = parseNonceFromHeader(response.headers);
      //   secureStorage.writeNonce(value);
      // }
      // if (response.statusCode == 403) {
      //   debugPrint('check nonce: ${response.headers}');
      // }
      print('status code: ${response.statusCode} - ${response.body}');
      final cart = Cart.fromJson(jsonDecode(response.body));
      return cart;
    } on SocketException catch (e) {
      throw NetworkFailure('cart [getCart] issue [SocketException]: ${e.message}');
    } on HttpException catch (e) {
      throw HttpException('cart [getCart] issue [HttpException]: ${e.message}');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Cart> deleteItem(String key) async {
    try {
      final secureStorage = SecureStorage();
      final nonce = await secureStorage.readNonce();
      final token = await secureStorage.readToken();
      final response = await client.post(
        Uri.parse('${ApiConfig.apiUrl}${ApiConfig.removeItem}'),
          headers: ApiConfig.headerPersonal(token!, nonce!),
        body: jsonEncode({
          'key': key
        })
      );
      return Cart.fromJson(jsonDecode(response.body));
    } on SocketException catch(e) {
      throw NetworkFailure('cart [removeItem] issue [SocketException]: ${e.message}');
    } on HttpException catch (e) {
      throw HttpException('cart [removeItem] issue [HttpException]: ${e.message}');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Cart> updateItem(String key, int quantity) async {
    try {
      final secureStorage = SecureStorage();
      final token = await secureStorage.readToken();
      final nonce = await secureStorage.readNonce();
      final response = await client.post(
        Uri.parse('${ApiConfig.apiUrl}${ApiConfig.updateItem}'),
        headers: ApiConfig.headerPersonal(token!, nonce!),
        body: jsonEncode({
          'key': key,
          'quantity': quantity
        })
      );
      return Cart.fromJson(jsonDecode(response.body));
    } on SocketException catch (e) {
      throw NetworkFailure('cart [updateCart] issue [SocketException]: ${e.message}');
    } on HttpException catch(e) {
      throw HttpException('cart [updateCart] issue [HttpException]: ${e.message}');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Cart> deleteAllItems() async {
    try {
      final secureStorage = SecureStorage();
      final token = await secureStorage.readToken();
      final nonce = await secureStorage.readNonce();
      final response = await client.delete(
        Uri.parse('${ApiConfig.apiUrl}${ApiConfig.deleteAllItems}'),
        headers: ApiConfig.headerPersonal(token!, nonce!),
      );
      return Cart.fromJson(jsonDecode(response.body));
    } on SocketException catch(e) {
      throw NetworkFailure('cart [deleteAllItems] issue [SocketException]: ${e.message}');
    } on HttpException catch(e) {
      throw HttpException('cart [deleteAllItems] issue [HttpException]: ${e.message}');
    } catch(_) {
      rethrow;
    }
  }
}