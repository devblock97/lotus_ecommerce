
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    if (cachedCustomer.isRight()) {
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
      final userCached = AuthResponseModel(success: AuthResponseSuccess.fromJson(jsonDecode(userString!)));
      if (userCached.success != null) {
        emit(const ShippingLoading());
        final response = await getRemoteCustomer(ParamCustomer(userId: userCached.success!.data!.id));
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