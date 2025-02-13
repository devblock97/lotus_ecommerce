import 'package:ecommerce_app/core/extensions/currency.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Image.network(
        product.images![0].src!,
        width: 60,
        height: 60,
      ),
      title: Text(product.name!, style: theme.textTheme.labelMedium,),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('SL: x${product.quantity}', style: theme.textTheme.labelMedium,),
          Text(
            product.prices!.price!.format(code: product.prices!.currencyCode!),
            style: theme.textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
