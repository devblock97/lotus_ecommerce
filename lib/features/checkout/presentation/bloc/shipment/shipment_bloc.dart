
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/models/customer_model.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../auth/data/models/sign_in_model.dart';
import '../../../domain/usecases/use_case.dart';



part 'shipment_state.dart';
part 'shipment_event.dart';

class ShipmentBloc extends Bloc<CheckOutEvent, ShippingState> {

  final GetRemoteCustomer getRemoteCustomer;
  final GetLocalCustomer getLocalCustomer;

  ShipmentBloc({required this.getLocalCustomer, required this.getRemoteCustomer})
      : super(const ShippingInitial()) {
    on<GetCustomerInfoEvent>(_getCustomerInfoRequest);
  }

  void _getCustomerInfoRequest(GetCustomerInfoEvent event, Emitter<ShippingState> emit) async {
    final cachedCustomer = await getLocalCustomer(NoParams());
    if (cachedCustomer != null) {
      cachedCustomer.fold(
          (error) {
            if (error is CacheFailure) {
              emit(const ShippingError());
            }
          },
          (customer) {
            emit(ShippingSuccess(customer: customer));
          }
      );
    } else {
      final userPref = await SharedPreferences.getInstance();
      final userString = userPref.getString(CACHED_USER_INFO);
      final userCached = AuthResponseModel.fromJson(jsonDecode(userString!));
      if (userCached.data != null) {
        emit(const ShippingLoading());
        final response = await getRemoteCustomer(ParamCustomer(userId: userCached.data!.id));
        response.fold(
            (error) {
              if (error is ServerFailure) {
                emit(const ShippingError());
              }
              if (error is ConnectionFailure) {
                emit(const ShippingError());
              }
            },
            (customer)  {
              emit(ShippingSuccess(customer: customer));
            }
        );
      }
    }

  }

}