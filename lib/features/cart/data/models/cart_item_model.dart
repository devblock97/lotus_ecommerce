import 'package:ecommerce_app/features/home/data/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({required this.product, required this.quantity});
}
