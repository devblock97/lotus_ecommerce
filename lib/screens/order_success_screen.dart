import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const textPrimaryStyle = TextStyle(
        color: primaryText, fontSize: 23, fontWeight: FontWeight.bold);
    const textSecondaryStyle = TextStyle(color: secondaryText, fontSize: 16);
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Spacer(),
        Image.asset('assets/icons/success.png'),
        const Spacer(),
        const Text(
          'Your Order has been accepted',
          style: textPrimaryStyle,
        ),
        const Text(
          'Your items has been placcd and is on \nit\'s way to being processed',
          style: textSecondaryStyle,
        ),
        const Spacer(),
        Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: EcommerceButton(
                title: 'Track Order',
                onTap: () {},
              ),
            )),
        EcommerceButton(
            title: 'Back to home',
            titleColor: primaryText,
            backgroundColor: Colors.transparent,
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const GroceryApp(),
                ),
                (route) => false))
      ]),
    );
  }
}
