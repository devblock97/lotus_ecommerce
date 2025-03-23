part of 'cart_bloc.dart';
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitialize extends CartState {
  const CartInitialize();
}

class CartSuccess extends CartState {

  const CartSuccess({required this.cart, this.dismiss});
  final Cart? cart;
  final bool? dismiss;

  @override
  List<Object?> get props => [cart, dismiss];
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartError extends CartState {
  const CartError({required this.message});
  final String message;
}

class CartDeleteError extends CartState {
  const CartDeleteError({this.message});
  final String? message;
}

class CartDeleteSuccess extends CartState {
  const CartDeleteSuccess();
}

class CartDeleteLoading extends CartState {
  const CartDeleteLoading();
}

/// This class used to indicate state for cart event:
/// increment item [IncrementItemEvent], decrement item[DecrementItemEvent]
/// remove item [DecrementItemEvent] and add item [AddToCartEvent]
class UpdateItemLoading extends CartState {
  const UpdateItemLoading();
}

class InCart extends CartState {
  const InCart({required this.isInCart});
  final bool isInCart;

  @override
  List<Object?> get props => [isInCart];
}
