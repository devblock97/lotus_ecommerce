
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/checkout/data/datasources/order_remote_datasource.dart';
import 'package:ecommerce_app/features/checkout/data/models/create_order.dart';
import 'package:ecommerce_app/features/checkout/data/models/order_model.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/order_repository.dart';
import 'package:fpdart/src/either.dart';

class OrderRepositoryImpl implements OrderRepository {

  final NetworkInfo networkInfo;
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, OrderModel>> createOrder(Order order) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.createOrder(order);
        return Right(response);
      } on ServerFailure {
        return Left(ServerFailure(SERVER_RESPONSE_ERROR));
      }

    } else {
      return Left(ConnectionFailure(INTERNET_CONNECTION_ERROR));
    }
  }

}