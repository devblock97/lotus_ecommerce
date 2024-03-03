
part of 'shipment_bloc.dart';

class ShippingState extends Equatable {

  const ShippingState();

  @override
  List<Object?> get props => [];
}

class ShippingInitial extends ShippingState {
  const ShippingInitial();
}

class ShippingLoading extends ShippingState {
  const ShippingLoading();
}

class ShippingSuccess extends ShippingState {
  final CustomerModel customer;
  const ShippingSuccess({required this.customer});
}

class ShippingError extends ShippingState {
  const ShippingError();
}