
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/features/checkout/data/models/create_order.dart';
import 'package:ecommerce_app/features/checkout/data/models/order_model.dart';
import 'package:fpdart/fpdart.dart' hide Order;

abstract class OrderRepository {
  Future<Either<Failure, OrderModel>> createOrder(Order order)
    => throw UnimplementedError('Stub');
}