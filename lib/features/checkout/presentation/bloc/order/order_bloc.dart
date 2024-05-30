
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/features/checkout/data/models/create_order.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce_app/features/checkout/domain/usecases/use_case.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {

  final CreateOrder createOrder;

  OrderBloc({required this.createOrder}) : super(const OrderLoading()) {
    on<TapOnPlaceOrder>(_onTapPlaceOrder);
  }

  void _onTapPlaceOrder(TapOnPlaceOrder event, Emitter<OrderState> emit) async {
    emit(const OrderLoading());
    final response = await createOrder(ParamCreateOrder(order: event.order));
    response.fold(
            (l) => emit(const OrderError()),
            (r) => emit(const OrderSuccess())
    );
  }

}