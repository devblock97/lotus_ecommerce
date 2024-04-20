
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllProductUseCase  extends UseCase<List<ProductModel>, NoParams>{

  GetAllProductUseCase(this._repository);
  final ProductRepository _repository;

  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) async {
    return _repository.getAllProducts();
  }


}