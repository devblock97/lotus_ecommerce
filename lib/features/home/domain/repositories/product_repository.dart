
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {

  Future<Either<Failure, List<ProductModel>>> getAllProducts();

}