import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/screens/order_success_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
import 'package:ecommerce_app/widgets/my_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const PlaceOrder();
                      });
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

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.read<CartRepositoryImpl>();
    // final textPrimaryStyle = TextStyle(
    //     color: primaryText, fontSize: 23, fontWeight: FontWeight.bold);
    // final textSecondaryStyle = TextStyle(
    //     color: primaryText, fontSize: 16, fontWeight: FontWeight.bold);
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: secondaryBackground),
      child: SingleChildScrollView(
        child: Column(children: [
          ListTile(
            leading: Text(
              'Checkout',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            trailing: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_outlined)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: secondaryButton,
              thickness: 1,
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery'),
                Text(
                  'Select Method',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            trailing: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.keyboard_arrow_right)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: secondaryButton,
              thickness: 1,
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Payment'),
                Image.asset('assets/icons/card.png')
              ],
            ),
            trailing: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.keyboard_arrow_right)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: secondaryButton,
              thickness: 1,
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Payment'),
                Text(
                  'Pick discount',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            trailing: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.keyboard_arrow_right)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: secondaryButton,
              thickness: 1,
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Cost'),
                Text(
                  '\$13.97',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            trailing: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.keyboard_arrow_right)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: secondaryButton,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: RichText(
              text: const TextSpan(
                  text: 'By placing an order you agree to our ',
                  style: TextStyle(color: secondaryText),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                            color: primaryText, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'And ', style: TextStyle(color: secondaryText)),
                    TextSpan(
                        text: 'Conditions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: primaryText))
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EcommerceButton(
                title: 'Place Order',
                onTap: () {
                  cart.clearItemAllItemToCart();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderSuccessScreen()));
                }),
          )
        ]),
      ),
    );
  }
}
