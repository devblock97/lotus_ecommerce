import 'dart:io';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:ecommerce_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

class CartRepositoryImpl implements CartRepository {

  CartRepositoryImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Cart>> addItemCart(CartItemModel cart) async {
    try {
      final response = await remoteDataSource.addItem(cart);
      return Right(response);
    } catch (e) {
      return Left(CacheFailure(CACHE_ERROR));
    }
  }

  @override
  Future<Either<Failure, Cart?>> getCarts() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getCarts();
        debugPrint('check response: ${response.item}');
        localDataSource.syncLocalAndRemoteCart(response);
        return Right(response);
      } catch (e) {
        return Left(CacheFailure(CACHE_ERROR));
      }
    } else {
      final cart = await localDataSource.getCart();
      return Right(cart);
    }
  }

  @override
  Future<Either<Failure, Cart>> deleteItemCart(String key) async {
    try {
      debugPrint('check key here: $key');
      final response = await remoteDataSource.deleteItem(key);
      return Right(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Either<Failure, Cart>> updateItem(String key, int quantity) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.updateItem(key, quantity);
        return Right(response);
      } on SocketException {
        return Left(NetworkFailure(INTERNET_CONNECTION_ERROR));
      } on HttpException {
        return Left(ServerFailure(SERVER_RESPONSE_ERROR));
      } catch (e) {
        return Left(ServerFailure(SERVER_RESPONSE_ERROR));
      }
    } else {
      return Left(NetworkFailure(INTERNET_CONNECTION_ERROR));
    }
  }

  @override
  Future<Either<Failure, Cart>> deleteAllItems() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.deleteAllItems();
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(SERVER_RESPONSE_ERROR));
      }
    } else {
      return Left(NetworkFailure(INTERNET_CONNECTION_ERROR));
    }
  }

  @override
  Future<Either<Failure, Cart>> getCartsLocal() async {
    try {
      final response = await localDataSource.getCart();
      if (response == null) {
        return Left(CacheFailure(CACHE_ERROR));
      }
      return Right(response);
    } catch (e) {
      return Left(CacheFailure(CACHE_ERROR));
    }
  }

}
