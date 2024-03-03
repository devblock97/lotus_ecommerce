
part of 'shipment_bloc.dart';

abstract class CheckOutEvent extends Equatable {
  const CheckOutEvent();

  @override
  List<Object?> get props => [];
}

class GetCustomerInfoEvent extends CheckOutEvent {

  const GetCustomerInfoEvent();

  @override
  List<Object?> get props => [];
}



