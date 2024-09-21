import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/shipment/data/models/province.dart';
import 'package:ecommerce_app/features/shipment/domain/repositories/shipment_repository.dart';
import 'package:fpdart/src/either.dart';

class GetProvinces extends UseCase<List<Province>, NoParams> {

  GetProvinces({required this.repository});
  final ShipmentRepository repository;

  @override
  Future<Either<Failure, List<Province>>> call(NoParams params) {
    return repository.getProvinces();
  }

}