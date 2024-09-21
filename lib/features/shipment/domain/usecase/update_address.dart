import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/data/models/shipping.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/shipment/domain/repositories/shipment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class UpdateAddress extends UseCase<CustomerModel, PutAddressParam> {

  UpdateAddress(this._repository);
  final ShipmentRepository _repository;
  @override
  Future<Either<Failure, CustomerModel>> call(PutAddressParam params) {
    return _repository.updateShippingAddress(params.userId, params.address);
  }

}

class PutAddressParam extends Equatable {
  const PutAddressParam({required this.userId, required this.address});
  final int userId;
  final Shipping address;

  @override
  List<Object?> get props => [userId, address];
}