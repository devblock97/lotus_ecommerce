
import 'dart:convert';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {

  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  late SharedPreferences sharedPreferences;

  @override
  Future<Either<Failure, AuthResponseModel>> signIn(AuthModel body) async {

    sharedPreferences = await SharedPreferences.getInstance();
    var isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final response = await remoteDataSource.signIn(body);

        if (response.error is AuthResponseError) {
          return Left(InputInvalid(error: response.error?.message));
        }
        await localDataSource.cacheUserInfo(response);
        return Right(response);
      } on ServerException catch(err) {
        return Left(ServerFailure('Server Failure [error: $err]]'));
      } on InputInvalid catch (err) {
        return Left(InputInvalid(error: 'Username or password incorrect'));
      }
    } else {
      return Left(ConnectionFailure('Internet connection failure!!!'));
    }
  }


  @override
  Future<Either<Failure, AuthResponseModel>> getUserInfo() async {
    try {
      final user = await localDataSource.getUserInfo();
      return Right(user!);
    } on CacheException {
      return Left(CacheFailure('Cache Failure'));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      final isClearedUser = await localDataSource.clearCacheUser(CACHED_USER_INFO);
      if (!isClearedUser) {
        return Left(CacheException());
      }
      return Right(isClearedUser);
    } on CacheException {
      return Left(CacheFailure('Logout Failure'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp(SignUpModel body) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await http.post(
          Uri.parse('${ApiConfig.API_URL}${ApiConfig.CUSTOMERS}'),
          headers: ApiConfig.HEADER,
          body: jsonEncode({
            "first_name": body.firstName,
            "last_name": body.lastName,
            "email": body.email,
            "password": body.password
          })
        );
        if (response.statusCode == 200) {
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