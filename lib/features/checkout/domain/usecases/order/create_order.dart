
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/checkout/data/models/create_order.dart';
import 'package:ecommerce_app/features/checkout/data/models/order_model.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class CreateOrder extends UseCase<OrderModel, ParamCreateOrder> {
  final OrderRepository orderRepository;

  CreateOrder({required this.orderRepository});

  @override
  Future<Either<Failure, OrderModel>> call(ParamCreateOrder params) async {
    return await orderRepository.createOrder(params.order);
  }
}

class ParamCreateOrder extends Equatable {
  final Order order;
  const ParamCreateOrder({required this.order});

  @override
  List<Object?> get props => [order];
}