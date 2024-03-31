
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/domain/usecase/customer/get_customer.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/get_last_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {

  final GetCustomer getCustomer;
  final GetLastUserInfo getLastUserInfo;

  CustomerBloc({required this.getCustomer, required this.getLastUserInfo}) : super(const CustomerLoading())   {
    on<CustomerInfoRequest>((event, emit) async {
      try {
          final customer = await getCustomer(const ParamGetCustomer(2));
          customer.fold(
            (error) {
                print('reponse error');
                if (error is ServerFailure) {
                  emit(CustomerError(error.error));
                }
                if (error is ConnectionFailure) {
                  emit(CustomerError(error.error));
                }
              },
            (r) => emit(CustomerSuccess(r))
          );
        // }
      } on ServerException {
        throw ServerException();
      }
    });
  }

}