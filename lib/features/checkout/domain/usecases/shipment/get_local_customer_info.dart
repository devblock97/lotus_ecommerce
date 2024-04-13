
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/shipment_repository.dart';
import 'package:fpdart/src/either.dart';

class GetLocalCustomer extends UseCase<CustomerModel, NoParams> {

  ShippingAddressRepository checkoutRepository;

  GetLocalCustomer({required this.checkoutRepository});

  @override
  Future<Either<Failure, CustomerModel>> call(NoParams params) async {
    return await checkoutRepository.getLocalCustomerInfo();
  }

}