
import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/checkout/data/models/create_order.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/order/order_bloc.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/shipment/shipment_bloc.dart';
import 'package:ecommerce_app/features/checkout/presentation/widgets/product_item.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../inject_container.dart';
import '../../../../screens/order_success_screen.dart';
import '../../../../widgets/my_button.dart';
import '../../../cart/data/repositories/cart_repository_impl.dart';

enum PaymentMethod {
  directBankTransfer("Direct Bank Transfer"),
  cashOnDelivery("Cash On Delivery"),
  checkPayments("Check Payments");

  final String title;
  const PaymentMethod(this.title);
}

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key, required this.items});

  final List<CartItemModel> items;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  PaymentMethod paymentMethod = PaymentMethod.directBankTransfer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrderBloc(createOrder: sl())),
        BlocProvider(create: (_) => ShipmentBloc(getLocalCustomer: sl(), getRemoteCustomer: sl())..add(const GetCustomerInfoEvent()))
      ],
      child: Scaffold(
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
                child: BlocBuilder<ShipmentBloc, ShippingState>(
                    builder: (context, state) {
                      if (state is ShippingSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${state.customer.firstName} ${state.customer.lastName}'),
                                Text('Thay đổi')
                              ],
                            ),
                            Text(state.customer.shipping.address1!),
                          ],
                        );
                      }
                      if (state is ShippingLoading) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      return const SizedBox();
                    }
                ),
              ),

              const Text('Phương thức thanh toán'),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(PaymentMethod.directBankTransfer.title),
                      leading: Radio<PaymentMethod>(
                        value: PaymentMethod.directBankTransfer,
                        groupValue: paymentMethod,
                        onChanged: (PaymentMethod? value) {
                          setState(() {
                            paymentMethod = value!;
                            print('payment method: ${paymentMethod.title}');
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(PaymentMethod.checkPayments.title),
                      leading: Radio<PaymentMethod>(
                        value: PaymentMethod.checkPayments,
                        groupValue: paymentMethod,
                        onChanged: (PaymentMethod? value) {
                          setState(() {
                            paymentMethod = value!;
                            print('payment method: ${paymentMethod.title}');
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(PaymentMethod.cashOnDelivery.title),
                      leading: Radio<PaymentMethod>(
                        value: PaymentMethod.cashOnDelivery,
                        groupValue: paymentMethod,
                        onChanged: (PaymentMethod? value) {
                          setState(() {
                            paymentMethod = value!;
                            print('payment method: ${paymentMethod.title}');
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),

              const Text('Sản phẩm'),
              ListItemCheckOut(items: widget.items),

              const Text('Phương thức giao hàng'),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tạm tính'),
                        Text('${widget.items.fold(0.0, (prePrice, items) =>
                        prePrice + (double.parse(items.product.price!) * items.quantity))}')
                      ],
                    ),
                    Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phí vận chuyển'),
                        Text('0đ')
                      ],
                    ),
                    Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Khuyến mãi vận chuyển'),
                        Text('-30.000đ')
                      ],
                    ),
                    Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Giảm giá'),
                        Text('20.000đ')
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tổng tiền'),
                  Text('${widget.items.fold(0.0, (previousValue, element) =>
                  previousValue + (double.parse(element.product.price!) * element.quantity))}đ')
                ],
              ),
              BlocBuilder<ShipmentBloc, ShippingState>(
                builder: (BuildContext context, state) {
                  if (state is ShippingSuccess) {
                    return BlocListener<OrderBloc, OrderState>(
                      listener: (context, state) {
                        if (state is OrderLoading) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return const Center(child: CircularProgressIndicator());
                            }
                          );
                        }

                        if (state is OrderSuccess) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const GroceryApp()),
                              (route) => false);
                        }
                      },
                      child: ElevatedButton(
                        onPressed: () async {
                          List<LineItem> lineItems = widget.items.map((e) => LineItem(
                                productId: e.product.id!,
                                quantity: e.quantity)).toList();
                          print('checking line item: ${lineItems.length}');
                          Order order = Order(
                              paymentMethod: 'bacs',
                              paymentMethodTitle: paymentMethod.title,
                              shipping: state.customer.shipping,
                              lineItems: lineItems,
                          );
                          print('checking shipment in order: ${state.customer.shipping.address1}');
                          BlocProvider.of<OrderBloc>(context).add(TapOnPlaceOrder(order: order));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.red
                        ),
                        child: const Text('Đặt hàng', style: TextStyle(color: Colors.white),),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


class PlaceOrderButton extends StatefulWidget {
  const PlaceOrderButton({
    super.key,
    required this.items,
    required this.paymentMethod,
  });

  final PaymentMethod paymentMethod;
  final List<CartItemModel> items;

  @override
  State<PlaceOrderButton> createState() => _PlaceOrderButtonState();
}

class _PlaceOrderButtonState extends State<PlaceOrderButton> {

  late OrderBloc orderBloc = sl<OrderBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tổng tiền'),
                  Text('${widget.items.fold(0.0, (previousValue, element) =>
                  previousValue + (double.parse(element.product.price!) * element.quantity))}đ')
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.red
                ),
                child: const Text('Đặt hàng', style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        );
      },
    );
  }
}

class Shipping extends StatefulWidget {
  const Shipping({
    super.key,
  });

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  @override
  void initState() {
    super.initState();
    context.read<ShipmentBloc>().add(const GetCustomerInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
      ),
      child: BlocBuilder<ShipmentBloc, ShippingState>(
          builder: (context, state) {
            if (state is ShippingSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${state.customer.firstName} ${state.customer.lastName}'),
                      Text('Thay đổi')
                    ],
                  ),
                  Text(state.customer.shipping.address1!),
                ],
              );
            }
            if (state is ShippingLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }
            return const SizedBox();
          }
      ),
    );
  }
}

class ListItemCheckOut extends StatelessWidget {
  const ListItemCheckOut({
    super.key,
    required this.items,
  });

  final List<CartItemModel> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
      ),
      margin: const EdgeInsets.all(8),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ProductItem(item: items[index]);
        },
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
