
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(item.product.images![0].src!),
      title: Text(item.product.name!),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('SL: x${item.quantity}'),
          Text('${item.product.price}đ')
        ],
      ),
    );
  }
}
