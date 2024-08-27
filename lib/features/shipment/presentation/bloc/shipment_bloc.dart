import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/data/models/shipping.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/shipment/data/models/city.dart';
import 'package:ecommerce_app/features/shipment/data/models/province.dart';
import 'package:ecommerce_app/features/shipment/domain/usecase/update_address.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../domain/usecase/usecase.dart';
part 'shipment_event.dart';
part 'shipment_state.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  ShipmentBloc(this.getProvinces, this.getCities, this.getWards, this.updateAddress)
      : super(const ShipmentInitializeState()) {
    on<GetProvincesRequest>(_onGetProvincesRequest);
    on<UpdateAddressRequest>(_onUpdateAddress);
  }

  final GetProvinces getProvinces;
  final GetCities getCities;
  final GetWards getWards;
  final UpdateAddress updateAddress;

  Future<void> _onGetProvincesRequest(GetProvincesRequest event, Emitter<ShipmentState> emit) async {
    final response = await getProvinces(NoParams());
    response.fold(
        (error) {
          if (error is CacheFailure) {
            emit(ShipmentErrorState(error.message));
          }
        },
        (provinces) {
          emit(ShipmentProvinceState(provinces: provinces));
        }
    );
  }

  Future<void> _onUpdateAddress(UpdateAddressRequest event, Emitter<ShipmentState> emit) async {
    emit(const ShipmentUpdateLoading());
    debugPrint('check update address: ${event.userId}; ${event.address.firstName}; ${event.address.lastName}; ${event.address.address1}');
    final response = await updateAddress(PutAddressParam(userId: event.userId, address: event.address));
    response.fold(
        (error) {
          debugPrint('check update error: $error');
          emit(ShipmentErrorState(error.toString()));
        },
        (data) {
          debugPrint('check update data: ${data.firstName}; ${data.lastName}; ${data.email} ${data.shipping?.address1}');
          emit(ShipmentUpdateSuccess(customer: data));
        }
    );
  }

}