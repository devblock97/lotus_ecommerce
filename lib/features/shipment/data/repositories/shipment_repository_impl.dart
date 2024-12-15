
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/data/models/shipping.dart';
import 'package:ecommerce_app/features/shipment/data/datasources/shipment_local_data_source.dart';
import 'package:ecommerce_app/features/shipment/data/datasources/shipment_remote_data_source.dart';
import 'package:ecommerce_app/features/shipment/data/models/city.dart';
import 'package:ecommerce_app/features/shipment/data/models/province.dart';
import 'package:ecommerce_app/features/shipment/domain/repositories/shipment_repository.dart';
import 'package:fpdart/src/either.dart';

class ShipmentRepositoryImpl implements ShipmentRepository {

  ShipmentRepositoryImpl(this.remoteDataSource, this.localDataSource);

  final ShipmentLocalDataSourceImpl localDataSource;
  final ShipmentRemoteDataSourceImpl remoteDataSource;

  @override
  Future<Either<Failure, void>> createShippingAddress(Shipping address) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Province>>> getProvinces() async {
    try {
      final response = await localDataSource.getProvinces();
      return Right(response);
    } catch (e) {
      return Left(CacheFailure('Không thể tải dữ liệu'));
    }
  }

  @override
  Future<Either<Failure, CustomerModel>> updateShippingAddress(int userId, Shipping address) async {
    try {
      final response = await remoteDataSource.updateAddress(userId, address);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure('Đã xảy ra lỗi khi cập nhật địa chỉ. Vui lòng thử lại sau'));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getCities(String parentCode) async {
    try {
      final response = await localDataSource.getCities(parentCode);
      return Right(response);
    } catch (e) {
      return Left(CacheFailure('Không th tải dữ liệu'));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getWards(String parentCode) async {
    try {
      final response = await localDataSource.getWards(parentCode);
      return Right(response);
    } catch (e) {
      return Left(CacheFailure('Không tải được dữ liệu'));
    }
  }

}