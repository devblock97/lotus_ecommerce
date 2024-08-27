import 'package:ecommerce_app/features/shipment/data/models/city.dart';
import 'package:equatable/equatable.dart';

enum WardStatus { initial, loading, success, error }

class WardState extends Equatable {
  const WardState({
    this.wards = const <City>[],
    this.status = WardStatus.initial,
    this.message = ''
  });
  final List<City> wards;
  final WardStatus status;
  final String? message;

  WardState copyWith({
    List<City>? wards,
    WardStatus? status,
    String? message
  }) {
    return WardState(
      wards: wards ?? this.wards,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

  @override
  List<Object?> get props => [wards, status, message];
}