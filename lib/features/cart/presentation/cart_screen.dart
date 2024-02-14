import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../checkout/presentation/view/checkout_out_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartRepositoryImpl>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.keyboard_arrow_left, color: secondaryButton,)),
        title: Text(
          'Giỏ hàng',
          // style: TextStyle(
          //     color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: cart.cartLists().length,
        itemBuilder: (_, index) {
          return CartItem(
            product: cart.cartLists()[index].product,
            quantity: cart.cartLists()[index].quantity,
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 14),
        child: cart.cartLists().isEmpty
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                    'Không có sản phẩm nào trong giở hàng',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
            )
            : ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckOutScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryButton,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19)),
                    padding: const EdgeInsets.all(22)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Flexible(
                      flex: 3,
                      child: Text(
                        'Thanh toán',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xFF489E67)),
                        child: Text('\$${cart.totalPrice()}'),
                      ),
                    )
                  ],
                )),
      ),
    );
  }
}
