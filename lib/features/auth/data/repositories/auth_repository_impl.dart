
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {

  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.networkInfo);

  @override
  Future<Either<Failure, AuthResponseModel>> signIn(AuthModel body) async {

    var isConnected = await networkInfo.inConnected;

    if (isConnected) {
      try {
        final response = await http.post(
          Uri.parse(ApiConfig.AUTH),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': body.username,
            'password': body.password,
          }),
        );

        if (response.statusCode == 200) {
          return Right(AuthResponseModel.fromJson(json.decode(response.body)));
        } else {
          return Left(ServerFailure('Failed to loading data from server [statusCode: ${response.statusCode}]'));
        }
      } catch (e) {
        return Left(ServerFailure('Server unreachable [errorMessage: $e]'));
      }
    } else {
      return Left(ConnectionFailure('Internet connection failure!!!'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUp(SignUpModel body) async {
    var isConnected = await networkInfo.inConnected;
    if (isConnected) {
      try {
        final response = await http.post(
          Uri.parse('https://192.168.110.47/senhong/wp-json/wc/v3/customers'),
          headers: ApiConfig.HEADER,
          body: jsonEncode({
            "first_name": body.firstName,
            "last_name": body.lastName,
            "email": body.email,
            "password": body.password
          })
        );
        print('sign up status code: ${response.statusCode}');
        if (response.statusCode == 201) {
          print('sign up in 201: ${response.body}');
          final customer = jsonDecode(response.body) as Map<String, dynamic>;
          return Right(UserModel.fromJson(customer));
        } else {
          return Left(ServerFailure('Failed to loading data from server [statusCode: ${response.statusCode}]'));
        }
      } catch (e) {
        return Left(ServerFailure('Failed during make http request to server!!!'));
      }
    } else {
      return Left(ConnectionFailure('Internet connection failure'));
    }
  }

}