
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/data/models/shipping.dart';
import 'package:ecommerce_app/features/shipment/data/models/city.dart';
import 'package:ecommerce_app/features/shipment/data/models/province.dart';
import 'package:fpdart/fpdart.dart';

abstract class ShipmentRepository {
  Future<Either<Failure, void>> createShippingAddress(Shipping address) =>
      throw UnimplementedError('Stub');
  Future<Either<Failure, CustomerModel>> updateShippingAddress(int userId, Shipping address) =>
      throw UnimplementedError('Stub');
  Future<Either<Failure, List<Province>>> getProvinces() =>
      throw UnimplementedError('Stub');
  Future<Either<Failure, List<City>>> getCities(String parentCode) =>
      throw UnimplementedError('Stub');
  Future<Either<Failure, List<City>>> getWards(String parentCode) =>
      throw UnimplementedError('Stub');
}