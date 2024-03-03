
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/models/customer_model.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/shipment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class GetRemoteCustomer extends UseCase<CustomerModel, ParamCustomer> {

  GetRemoteCustomer({required this.checkoutRepository});

  final ShippingAddressRepository checkoutRepository;

  @override
  Future<Either<Failure, CustomerModel>> call(ParamCustomer params) async {
    return await checkoutRepository.getRemoteCustomerInfo(userId: params.userId);
  }

}

class ParamCustomer extends Equatable {
  final int userId;
  const ParamCustomer({required this.userId});

  @override
  List<Object?> get props => [userId];
}