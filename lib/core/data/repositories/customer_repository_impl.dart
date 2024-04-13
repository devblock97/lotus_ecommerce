
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/core/data/datasources/customer_remote_data_source.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/domain/repositories/customer_repository.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:fpdart/src/either.dart';

class CustomerRepositoryImpl implements CustomerRepository {

  final NetworkInfo networkInfo;
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, CustomerModel>> getCustomer({required int id}) async {
    final isConnected = await networkInfo.inConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getCustomer(id: id);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(SERVER_RESPONSE_ERROR));
      }
    } {
      return Left(ConnectionFailure(INTERNET_CONNECTION_ERROR));
    }
  }
}