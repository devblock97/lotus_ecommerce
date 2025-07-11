import 'dart:async';

import 'package:ecommerce_app/core/extensions/currency.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/widget/cart_skeleton.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Giỏ hàng',
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          print('check cart state listen: $state');
          if (state is CartError) {

          }
        },
        builder: (context, state) {
          debugPrint('check cart screen state: $state');
          if (state is CartSuccess) {
            debugPrint('check cart state builder: ${state.cart?.item?.length}');
            if (state.cart != null) {
              return ListView.builder(
                itemCount: state.cart!.item!.length,
                itemBuilder: (_, index) {
                  return CartItem(
                    product: state.cart!.item![index],
                    quantity: state.cart!.item![index].quantity!,
                    prices: state.cart!.item![index].prices,
                  );
                },
              );
            }
          }
          if (state is CartError) {
            return Center(child: Text(state.message),);
          }
          return const ListCartSkeleton();
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartSuccess) {
            if (state.cart != null) {
              final totals = state.cart!.totals;
              return Padding(
                padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 14),
                child: state.cart!.item!.isEmpty
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
                : EcommerceButton(
                    title: 'Thanh toán',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => CheckOutScreen(carts: state.cart!)));
                    }
                )
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
