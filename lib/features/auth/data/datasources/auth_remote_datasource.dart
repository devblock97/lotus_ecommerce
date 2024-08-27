import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signIn(AuthModel body) => throw UnimplementedError('Stub');
  Future<UserModel> signUp(SignUpModel body) => throw UnimplementedError('Stub');
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseModel> signIn(AuthModel body) async {
    try {
      final response = await client.post(
          Uri.parse('${ApiConfig.apiUrl}${ApiConfig.auth}'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body.toJson())
      );
      debugPrint('access token: ${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        return AuthResponseModel(success: AuthResponseSuccess.fromJson(
            jsonDecode(response.body)));
      }
      return AuthResponseModel(error: AuthResponseError.fromJson(
          jsonDecode(response.body)));
    } on ServerException catch (e) {
      throw ServerException();
    } on TimeoutException catch (e) {
      throw ServerFailure('Request timeout!!!');
    }
  }

  @override
  Future<UserModel> signUp(SignUpModel body) async {
    try {
      final response = await http.post(
          Uri.parse('${ApiConfig.apiUrl}${ApiConfig.customer}'),
          headers: ApiConfig.headerSystem,
          body: jsonEncode({
            'username': body.username,
            'email': body.email,
            'password': body.password
          })
      );
      if (response.statusCode >= 200 && response.statusCode <= 209) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerFailure(jsonDecode(response.body)['message']);
      }
    } on SocketException catch (e) {
      throw NetworkFailure('auth [SignUp] issue: ${e.message}');
    } on HttpException catch (e) {
      throw HttpException('auth [SignUp] issue: ${e.message}');
    } catch (_) {
      rethrow;
    }
  }

}