part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {

  const CartEvent();

  @override
  List<Object?> get props => [];
}

class GetCartEvent extends CartEvent {
  const GetCartEvent();
}

class AddToCartEvent extends CartEvent {
  final CartItemModel item;
  const AddToCartEvent({required this.item});

  @override
  List<Object?> get props => [item];
}

class IncrementItemEvent extends CartEvent {

  const IncrementItemEvent({required this.key, required this.quantity});
  final String key;
  final int quantity;
}

class DecrementItemEvent extends CartEvent {
  const DecrementItemEvent({required this.key, required this.quantity});
  final String key;
  final int quantity;
}

class DeleteItemEvent extends CartEvent {
  const DeleteItemEvent({required this.key});
  final String key;
}

class DeleteAllItemEvent extends CartEvent {

}