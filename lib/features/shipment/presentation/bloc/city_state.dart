import 'package:ecommerce_app/features/shipment/data/models/city.dart';
enum CityStatus { initial, loading, error, success }

class CityState {
  const CityState({
    this.cities = const <City>[],
    this.status = CityStatus.initial,
    this.message = 'unknown message',
  });
  final List<City> cities;
  final CityStatus status;
  final String? message;

  CityState copyWith({
    List<City>? cities,
    CityStatus? status,
    String? message,
  }) {
    return CityState(
      cities: cities ?? this.cities,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}