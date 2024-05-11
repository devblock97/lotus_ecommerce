import 'package:ecommerce_app/core/extensions/currency_extension.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  CartItem({super.key, required this.product, required this.quantity, this.prices});

  final Product product;
  final Prices? prices;
  int quantity;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prices = widget.prices;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Image.network(
                  widget.product.images![0].src!,
                  fit: BoxFit.contain,
                )),
            const Gap(10),
            Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(widget.product.name!),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(DeleteItemEvent(key: widget.product.key!));
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (widget.quantity > 1) {
                                    context.read<CartBloc>().add(DecrementItemEvent(key: widget.product.key!, quantity: widget.quantity - 1));
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove_outlined)),
                          Text('${widget.quantity}'),
                          IconButton(
                              onPressed: () {
                                if (widget.quantity < 10) {
                                  // cart.incrementItem(widget.product);
                                  context.read<CartBloc>().add(IncrementItemEvent(key: widget.product.key!, quantity: widget.quantity + 1));
                                }
                              },
                              icon: const Icon(Icons.add_outlined))
                        ],
                      ),
                      trailing: Text(
                          prices!.price!.format(code: prices.currencyCode!),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
        const Gap(10),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            thickness: 1,
            color: secondaryButton,
          ),
        )
      ],
    );
  }
}
