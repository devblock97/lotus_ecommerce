import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  CartItem({super.key, required this.product, required this.quantity});

  final ProductModel product;
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
    var cart = context.read<CartRepositoryImpl>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Image.asset(
                  widget.product.thumbnail,
                  fit: BoxFit.contain,
                )),
            const Gap(10),
            Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(widget.product.name),
                      subtitle: Text('${widget.product.unit}, Price'),
                      trailing: IconButton(
                        onPressed: () => cart.removeItemToCart(widget.product),
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    width: 1, color: secondaryButton)),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (widget.quantity > 1) {
                                      cart.decrementItem(widget.product);
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove_outlined)),
                          ),
                          Text('${widget.quantity}'),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border:
                                    Border.all(color: primaryButton, width: 1)),
                            child: IconButton(
                                onPressed: () {
                                  if (widget.quantity < 10) {
                                    cart.incrementItem(widget.product);
                                  }
                                },
                                icon: const Icon(Icons.add_outlined)),
                          )
                        ],
                      ),
                      trailing: Text('\$${widget.product.price}'),
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
