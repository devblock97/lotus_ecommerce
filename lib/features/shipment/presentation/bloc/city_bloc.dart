
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/shipment/domain/usecase/get_cities.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit(this.getCities) : super (const CityState());

  final GetCities getCities;

  Future<void> getCity(String parentCode) async {
    emit(state.copyWith(status: CityStatus.loading));
    try {
      final response = await getCities(GetCitiesParam(parentCode: parentCode));
      response.fold(
        (error) => emit(state.copyWith(
        status: CityStatus.error,
        message: error.toString())),
        (cities) => emit(state.copyWith(
        cities: cities,
        status: CityStatus.success))
      );
    } catch (e) {
      emit(state.copyWith(status: CityStatus.error));
    }
  }
}