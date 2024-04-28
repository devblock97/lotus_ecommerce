
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class AddItemCart extends UseCase<Cart, ParamAddItemCart> {

  AddItemCart({required this.cartRepository});
  final CartRepository cartRepository;

  @override
  Future<Either<Failure, Cart>> call(ParamAddItemCart params) {
   return cartRepository.addItemCart(params.item);
  }

}

class ParamAddItemCart extends Equatable {

  const ParamAddItemCart({required this.item});
  final CartItemModel item;

  @override
  List<Object?> get props => [item];
}