import 'dart:async';

import 'package:ecommerce_app/core/extensions/currency.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/widget/cart_skeleton.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../checkout/presentation/view/checkout_out_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  @override
  void initState() {
    super.initState();
    // sl<CartBloc>().add(const GetCartEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.keyboard_arrow_left,
              color: secondaryButton,
            )
        ),
        title: Text(
          'Giỏ hàng',
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          print('check cart state listen: $state');
          if (state is CartError) {

          }
        },
        builder: (context, state) {
          if (state is CartSuccess) {
            print('check cart state builder: ${state.cart.item?.length}');
            return ListView.builder(
              itemCount: state.cart.item!.length,
              itemBuilder: (_, index) {
                return CartItem(
                  product: state.cart.item![index],
                  quantity: state.cart.item![index].quantity!,
                  prices: state.cart.item![index].prices,
                );
              },
            );
          }
          return const ListCartSkeleton();
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartSuccess) {
            final totals = state.cart.totals;
            return Padding(
              padding: const EdgeInsets.only(
                  left: 8, top: 0, right: 8, bottom: 14),
              child: state.cart.item!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Không có sản phẩm nào trong giở hàng',
                              textAlign: TextAlign.center,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (_) => CheckOutScreen(carts: state.cart)));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryButton,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Thanh toán',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color(0xFF489E67)),
                            child: Text(
                              totals!.totalPrice!.format(code: totals.currencyCode!),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
