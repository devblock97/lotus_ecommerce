import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/domain/entities/customer_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomerRepository {
  Future<Either<Failure, CustomerModel>> getCustomer({required int id}) => throw UnimplementedError('Stub');
}