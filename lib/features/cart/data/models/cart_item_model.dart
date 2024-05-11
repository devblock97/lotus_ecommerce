import 'package:ecommerce_app/features/home/data/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({required this.product, required this.quantity});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(product: json['product'], quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() =>
    {
      'product': product,
      'quantity': quantity
    };

}
