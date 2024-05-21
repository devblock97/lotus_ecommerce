import 'dart:async';
import 'dart:convert';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signIn(AuthModel body) => throw UnimplementedError('Stub!');
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
      if (response.statusCode == 403) {
        return AuthResponseModel(error: AuthResponseError.fromJson(jsonDecode(response.body)));
      }
      return AuthResponseModel(success: AuthResponseSuccess.fromJson(jsonDecode(response.body)));
    } on ServerException catch (e) {
      throw ServerException();
    } on TimeoutException catch (e) {
      throw ServerFailure('Request timeout!!!');
    }
  }

}