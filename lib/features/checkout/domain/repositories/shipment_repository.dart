
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/entities/customer_entity.dart';
import 'package:ecommerce_app/core/models/customer_model.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class ShippingAddressRepository {

  Future<Either<Failure, CustomerModel>> getRemoteCustomerInfo({required int userId})
    => throw UnimplementedError('Stub!');

  Future<Either<Failure, CustomerModel>> getLocalCustomerInfo()
    => throw UnimplementedError('Stub!');

}