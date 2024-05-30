
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/src/either.dart';

class GetCart extends UseCase<Cart, NoParams> {

  GetCart(this.cartRepository);

  final CartRepository cartRepository;

  @override
  Future<Either<Failure, Cart>> call(NoParams params) {
    return cartRepository.getCarts();
  }

}