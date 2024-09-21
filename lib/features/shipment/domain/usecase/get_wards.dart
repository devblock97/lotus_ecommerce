import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/shipment/data/models/city.dart';
import 'package:ecommerce_app/features/shipment/domain/repositories/shipment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class GetWards extends UseCase<List<City>, ParamGetWards> {

  GetWards(this.repository);
  final ShipmentRepository repository;
  @override
  Future<Either<Failure, List<City>>> call(ParamGetWards params) {
    return repository.getWards(params.parentCode);
  }

}

class ParamGetWards extends Equatable {
  const ParamGetWards({required this.parentCode});
  final String parentCode;

  @override
  List<Object?> get props => [parentCode];
}