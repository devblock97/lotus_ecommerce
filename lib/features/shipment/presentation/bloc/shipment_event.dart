part of 'shipment_bloc.dart';

abstract class ShipmentEvent extends Equatable {
  const ShipmentEvent();

  @override
  List<Object?> get props => [];
}

class GetProvincesRequest extends ShipmentEvent {
  const GetProvincesRequest();
}

class SelectedProvinceRequest extends ShipmentEvent {
  SelectedProvinceRequest({required this.province, required this.parentCode, this.isCity = false, this.isWard = false});
  final String province;
  final String parentCode;
  bool isCity;
  bool isWard;

  @override
  List<Object?> get props => [
    province,
    parentCode,
    isCity,
    isWard
  ];
}

class UpdateCityRequest extends ShipmentEvent {
  const UpdateCityRequest({required this.province, required this.parentCode});
  final String province;
  final String parentCode;

  @override
  List<Object?> get props => [
    province,
    parentCode
  ];
}

class ShipmentInitialize extends ShipmentEvent {
  const ShipmentInitialize();
}

class UpdateAddressRequest extends ShipmentEvent {
  const UpdateAddressRequest({required this.userId, required this.address});
  final int userId;
  final Shipping address;

  @override
  List<Object?> get props => [
    userId,
    address
  ];
}