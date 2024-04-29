import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/domain/repositories/customer_repository.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class GetCustomer extends UseCase<CustomerModel, ParamGetCustomer> {

  final CustomerRepository customerRepository;

  GetCustomer({required this.customerRepository});

  @override
  Future<Either<Failure, CustomerModel>> call(ParamGetCustomer params) async {
    return await customerRepository.getCustomer(id: params.id);
  }

}

class ParamGetCustomer extends Equatable {

  const ParamGetCustomer(this.id);
  final int id;

  @override
  List<Object?> get props => [id];
}
