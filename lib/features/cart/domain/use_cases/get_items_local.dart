import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCartLocal extends UseCase<Cart?, NoParams> {

  GetCartLocal(this.cartRepository);

  final CartRepository cartRepository;

  @override
  Future<Either<Failure, Cart?>> call(NoParams params) {
    return cartRepository.getCartsLocal();
  }

}