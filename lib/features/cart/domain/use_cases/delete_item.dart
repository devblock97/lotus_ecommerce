
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class DeleteItem extends UseCase<Cart, ParamPostDeleteItem> {

  DeleteItem({required this.cartRepository});
  final CartRepository cartRepository;


  @override
  Future<Either<Failure, Cart>> call(ParamPostDeleteItem params) async {
    return cartRepository.deleteItemCart(params.key);
  }

}

class ParamPostDeleteItem extends Equatable {
  const ParamPostDeleteItem({required this.key});
  final String key;

  @override
  List<Object?> get props => [key];
}