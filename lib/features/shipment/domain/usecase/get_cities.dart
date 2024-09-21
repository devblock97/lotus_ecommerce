
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/shipment/data/models/city.dart';
import 'package:ecommerce_app/features/shipment/domain/repositories/shipment_repository.dart';
import 'package:fpdart/src/either.dart';

class GetCities extends UseCase<List<City>, GetCitiesParam> {

  GetCities(this.repository);
  final ShipmentRepository repository;
  @override
  Future<Either<Failure, List<City>>> call(GetCitiesParam params) {
    return repository.getCities(params.parentCode);
  }
}

class GetCitiesParam {
  GetCitiesParam({required this.parentCode});
  final String parentCode;
}