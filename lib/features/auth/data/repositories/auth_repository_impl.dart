
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/core/utils/secure_storage.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
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
    final secureStorage = SecureStorage();
    var isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final response = await remoteDataSource.signIn(body);
        debugPrint('check auth response: ${response.error}; ${response.success}');

        if (response.error is AuthResponseError) {
          return Left(InputInvalid(error: response.error?.message));
        }
        await secureStorage.writeToken(response.success!.data?.token);
        debugPrint('check auth response success: ${response.success?.data?.token}');
        await localDataSource.cacheUserInfo(response);
        return Right(response);
      } on ServerException catch(err) {
        return Left(ServerFailure('Server Failure [error: $err]'));
      } on InputInvalid catch (err) {
        return Left(InputInvalid(error: 'Username or password incorrect'));
      }
    } else {
      return Left(ConnectionFailure('Internet connection failure!!!'));
    }
  }


  @override
  Future<Either<Failure, AuthResponseModel?>> getUserInfo() async {
    try {
      final user = await localDataSource.getUserInfo();
      if (user != null) {
        return Right(user);
      }
      return Left(CacheException());
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
        final response = await remoteDataSource.signUp(body);
        return Right(response);
      } on SocketException catch (e) {
        debugPrint('sign up on socket exception');
        return Left(NetworkFailure('auth [SignUp] issue: ${e.message}'));
      } on HttpException catch (e) {
        debugPrint('sign up on http exception');
        return Left(ServerFailure('auth [SignUp] issue: ${e.message}'));
      } on ServerFailure catch(e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return Left(ConnectionFailure('Internet connection failure'));
    }
  }

}