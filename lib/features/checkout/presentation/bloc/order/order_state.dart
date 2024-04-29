part of 'order_bloc.dart';


class OrderState extends Equatable {

  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderError extends OrderState {
  const OrderError();
}

class OrderSuccess extends OrderState {
  const OrderSuccess();
}