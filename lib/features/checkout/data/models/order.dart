
import 'package:ecommerce_app/features/cart/data/models/cart.dart';

class Order extends Cart {

  Order({required this.id, required this.status});
  final int id;
  final String status;
}