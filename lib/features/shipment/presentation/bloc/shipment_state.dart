part of 'shipment_bloc.dart';

enum ShipmentStatus {initialize, loading, success, error}

abstract class ShipmentState extends Equatable {

  const ShipmentState();

  @override
  List<Object?> get props => [];
}

class ShipmentProvinceState extends ShipmentState {
  const ShipmentProvinceState({required this.provinces});
  final List<Province> provinces;

  @override
  List<Object?> get props => [provinces];
}

class ShipmentCitiesState extends ShipmentState {
  const ShipmentCitiesState({required this.cities});
  final List<City> cities;

  @override
  List<Object?> get props => [cities];
}

class ShipmentWardsState extends ShipmentState {
  const ShipmentWardsState({required this.wards});
  final List<City> wards;

  @override
  List<Object?> get props => [wards];
}

class ShipmentErrorState extends ShipmentState {
  const ShipmentErrorState(this.message);
  final String? message;

  @override
  List<Object?> get props => [message];
}

class ShipmentLoadingState extends ShipmentState {
  const ShipmentLoadingState();
}

class ShipmentInitializeState extends ShipmentState {
  const ShipmentInitializeState();
}

class ShipmentAddressState extends ShipmentState {

  const ShipmentAddressState({this.customer,});

  final CustomerModel? customer;

  @override
  List<Object?> get props => [customer];
}

class ShipmentUpdateSuccess extends ShipmentState {
  const ShipmentUpdateSuccess({required this.customer});
  final CustomerModel customer;
}

class ShipmentUpdateLoading extends ShipmentState {
  const ShipmentUpdateLoading();
}

