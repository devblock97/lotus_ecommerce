part of 'order_bloc.dart';

class OrderEvent extends Equatable {

  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class TapOnPlaceOrder extends OrderEvent {
  final Order order;
  const TapOnPlaceOrder({required this.order});
}