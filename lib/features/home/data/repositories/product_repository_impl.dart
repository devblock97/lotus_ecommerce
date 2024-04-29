
import 'dart:convert';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:ecommerce_app/features/home/data/datasources/home_local_datasource.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_config.dart';
import 'package:http/http.dart' as http;

class ProductRepositoryImpl implements ProductRepository {

  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDatasource localDataSource;

  ProductRepositoryImpl(this.networkInfo, this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {

    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getAllProducts();
        localDataSource.saveAllProducts(response);
        return Right(response);
      } on ServerFailure {
        return Left(ServerFailure(SERVER_RESPONSE_ERROR));
      }
    } else {
      try {
        final response = await localDataSource.getAllProducts();
        return Right(response);
      } on CacheException {
        return Left(CacheFailure(CACHE_ERROR));
      }
    }
  }

}