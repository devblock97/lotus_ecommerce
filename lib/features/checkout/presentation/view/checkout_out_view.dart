
import 'dart:convert';

import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../screens/order_success_screen.dart';
import '../../../../widgets/my_button.dart';
import '../../../cart/data/repositories/cart_repository_impl.dart';
import 'package:http/http.dart' as http;

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Địa chỉ giao hàng'),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('John Nguyen'),
                      Text('Change')
                    ],
                  ),
                  Text('Shipping address 1'),
                  Text('Shipping address 2')
                ],
              ),
            ),
            Text('Phương thức thanh toán'),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
              ),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset('assets/icons/mastercard.svg'),
            ),
            Text('Phương thức giao hàng'),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
              ),
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: 1, groupValue: 2, onChanged: (value) {}, title: const Text('Giao hàng tiết kiệm'),),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: 1, groupValue: 2, onChanged: (value) {}, title: const Text('Giao hàng hỏa tốc'),),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tạm tính'),
                      Text('5.136.789đ')
                    ],
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí vận chuyển'),
                      Text('189.000đ')
                    ],
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Khuyến mãi vận chuyển'),
                      Text('136.789đ')
                    ],
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Giảm giá'),
                      Text('136.789đ')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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
                onTap: () async {
                  const data = {
                    'payment_method': "bacs",
                    'payment_method_title': "Direct Bank Transfer",
                    'set_paid': true,
                    'billing': {
                      'first_name': "John",
                      'last_name': "Doe",
                      'address_1': "969 Market",
                      'address_2': "",
                      'city': "San Francisco",
                      'state': "CA",
                      'postcode': "94103",
                      'country': "US",
                      'email': "john.doe@example.com",
                      'phone': "(555) 555-5555"
                    },
                    'shipping': {
                      'first_name': "John",
                      'last_name': "Doe",
                      'address_1': "969 Market",
                      'address_2': "",
                      'city': "San Francisco",
                      'state': "CA",
                      'postcode': "94103",
                      'country': "US"
                    },
                    'line_items': [
                      {
                        'product_id': 93,
                        'quantity': 1
                      },
                      {
                        'product_id': 123,
                        'quantity': 1
                      }
                    ],
                    'shipping_lines': [

                    ]
                  };

                  // final response = await http.post(
                  //   Uri.parse(ApiConfig.URL + ApiConfig.ORDERS),
                  //   body: data
                  // );
                  // print('response order: ${response.statusCode}');
                  // print('response order: ${response.body}');

                  // final response = await http.post(
                  //   Uri.parse(ApiConfig.URL + ApiConfig.ORDERS),
                  //   body: jsonEncode(data),
                  //   headers: ApiConfig.HEADER
                  // );
                  // print('create order status code: ${response.statusCode}');
                  //
                  // if (response.statusCode == 201) {
                  //   print('create order response: ${response.body}');
                  // } else {
                  //   print('create order error: ${response.request?.url}');
                  // }

                  cart.clearItemAllItemToCart();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderSuccessScreen()));
                }),
          )
        ]),
      ),
    );
  }
}
