part of 'cart_bloc.dart';
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartSuccess extends CartState {

  const CartSuccess(this.carts);
  final Cart carts;

  @override
  List<Object?> get props => [carts];
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

class InCart extends CartState {
  const InCart({required this.isInCart});
  final bool isInCart;

  @override
  List<Object?> get props => [isInCart];
}
