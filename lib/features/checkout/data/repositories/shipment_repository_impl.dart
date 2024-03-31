
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/checkout/data/datasources/shipment_remote_datasource.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/shipment_repository.dart';
import 'package:fpdart/src/either.dart';

import '../datasources/shipment_local_datasource.dart';

class ShippingAddressRepositoryImpl implements ShippingAddressRepository {

  final NetworkInfo networkInfo;
  final CheckOutRemoteDataSource remoteDataSource;
  final CheckOutLocalDataSource localDataSource;

  ShippingAddressRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource
  });

  @override
  Future<Either<Failure, CustomerModel>> getRemoteCustomerInfo({required int userId}) async {
    var isConnected = await networkInfo.inConnected;
    if (isConnected) {
      try {
        final customer = await remoteDataSource.getRemoteCustomerInfo(userId: userId);
        try {
          await localDataSource.cachedCustomer(customer);
        } on CacheException {
          return Left(CacheFailure('Caching customer error'));
        }
        return Right(customer);
      } catch (e) {
        return Left(ServerFailure(SERVER_RESPONSE_ERROR));
      }
    } else {
      return Left(ConnectionFailure(INTERNET_CONNECTION_ERROR));
    }
  }

  @override
  Future<Either<Failure, CustomerModel>> getLocalCustomerInfo() async {
    try {
      final customer = await localDataSource.getLocalCustomerInfo();
      return Right(customer);
    } on CacheException {
      return Left(CacheFailure('Cached Error'));
    }
  }

}