
import 'package:ecommerce_app/core/data/models/customer_model.dart';
import 'package:ecommerce_app/core/extensions/currency.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/checkout/data/models/create_order.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/order/order_bloc.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/shipment/shipment_bloc.dart';
import 'package:ecommerce_app/features/checkout/presentation/widgets/product_item.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/city_bloc.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/shipment_bloc.dart' as shipBloc;
import 'package:ecommerce_app/features/shipment/presentation/bloc/shipment_bloc.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/ward_cubit.dart';
import 'package:ecommerce_app/features/shipment/presentation/view/shipment_screen.dart';
import 'package:ecommerce_app/screens/order_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../inject_container.dart';

enum PaymentMethod {
  directBankTransfer("bacs"),
  cashOnDelivery("cod"),
  checkPayments("cheque");

  final String title;
  const PaymentMethod(this.title);
}

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key, required this.carts});

  final Cart carts;

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
    final theme = Theme.of(context);

    final totals = widget.carts.totals;
    final shippingRates = widget.carts.shippingRates;

    final shippingFee = shippingRates!.fold(
        0.0, (pre, curr) => pre + curr.shippingRates!.fold(
        0.0, (pre, curr) => pre + double.parse(curr.price!))).toString()
    .format(code: totals!.currencyCode!);

    final coupon = widget.carts.coupons!.fold(
        0.0, (pre, curr) => pre + double.parse(curr.totals!.totalDiscount!))
    .toString().format(code: totals.currencyCode!);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrderBloc(createOrder: sl())),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thanh toán', style: theme.textTheme.headlineSmall),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.chevron_left, color: theme.iconTheme.color,)
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Text('Địa chỉ giao hàng', style: theme.textTheme.titleMedium),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.scaffoldBackgroundColor,
                border: Border.all(color: theme.highlightColor)
              ),
              child: ShippingAddress(cart: widget.carts),
            ),
            const Gap(10),
            Text('Phương thức thanh toán', style: theme.textTheme.titleMedium,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.scaffoldBackgroundColor,
                border: Border.all(color: theme.highlightColor)
              ),
              child: Column(
                children: widget.carts.paymentMethods!.map((pm) {
                  String method = PaymentMethod.cashOnDelivery.title;
                  PaymentMethod payment = PaymentMethod.cashOnDelivery;
                  switch (pm) {
                    case 'bacs':
                      method = 'Chuyển khoản ngân hàng';
                      payment = PaymentMethod.directBankTransfer;
                      break;
                    case 'cheque':
                      method = 'Thanh toán bằng séc';
                      payment = PaymentMethod.checkPayments;
                      break;
                    case 'cod':
                      method = 'Thanh toán khi nhận hàng';
                      payment = PaymentMethod.cashOnDelivery;
                      break;
                  }
                  return RadioListTile(
                    activeColor: Colors.blue,
                    title: Text(method, style: theme.textTheme.titleSmall),
                    value: payment,
                    groupValue: paymentMethod,
                    onChanged: (PaymentMethod? value) {
                      setState(() {
                        paymentMethod = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const Gap(10),
            Text('Sản phẩm', style: theme.textTheme.titleMedium),
            ListItemCheckOut(carts: widget.carts),
            const Gap(10),
            Text('Phương thức giao hàng', style: theme.textTheme.titleMedium),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.scaffoldBackgroundColor,
                border: Border.all(color: theme.highlightColor)
              ),
              child: Column(
                children: [
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: 1, groupValue: 2,
                    onChanged: (value) {

                    },
                    title: Text(
                      'Giao hàng tiết kiệm',
                      style: theme.textTheme.titleSmall,),),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: 1, groupValue: 2,
                    onChanged: (value) {},
                    title: Text(
                      'Giao hàng hỏa tốc',
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.highlightColor)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tạm tính'),
                      Text(totals.totalPrice!.format(code: totals.currencyCode!))
                    ],
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Phí vận chuyển'),
                      Text(shippingFee)
                    ],
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Khuyến mãi vận chuyển'),
                      Text('0'.format(code: totals.currencyCode!))
                    ],
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Giảm giá'),
                      Text(coupon)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8),
          color: theme.scaffoldBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tổng tiền', style: theme.textTheme.titleMedium,),
                  Text(totals.totalPrice!.format(code: totals.currencyCode!))
                ],
              ),
              BlocConsumer<OrderBloc, OrderState>(
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
                        MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
                            (route) => false);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      List<LineItem> lineItems = widget.carts.item!.map((e) => LineItem(
                          productId: e.id!,
                          quantity: e.quantity!)).toList();
                      Order order = Order(
                        paymentMethod: paymentMethod.title,
                        paymentMethodTitle: paymentMethod.title,
                        shipping: widget.carts.shippingAddress!,
                        lineItems: lineItems,
                      );
                      BlocProvider.of<OrderBloc>(context).add(TapOnPlaceOrder(order: order));
                      context.read<CartBloc>().add(DeleteAllItemEvent());
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.red
                    ),
                    child: const Text('Đặt hàng', style: TextStyle(color: Colors.white),),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({
    super.key,
    required this.cart
  });

  final Cart cart;

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.cart.shippingAddress!.isEmpty()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Bạn chưa có địa chỉ giao hàng', style: theme.textTheme.titleMedium,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  ShipmentScreen(isUpdate: false, cart: widget.cart,)));
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue)
            ),
            child: const Column(
              children: [
                Icon(Icons.add, color: Colors.white,),
                Text('Thêm địa chỉ', style: TextStyle(color: Colors.white))
              ],
            )
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.cart.shippingAddress!.firstName} ${widget.cart.shippingAddress!.lastName}'),
            TextButton(
              onPressed: () async {
                CustomerModel customer = await Navigator.push(context, MaterialPageRoute(builder: (_) => ShipmentScreen(isUpdate: true, cart: widget.cart,)));
                debugPrint('customer name: ${customer.firstName} ${customer.lastName}; ${customer.shipping?.address1}');
                setState(() {
                  widget.cart.shippingAddress = customer.shipping;
                });
              },
              child: Text('Thay đổi', style: theme.textTheme.titleMedium),
            )
          ],
        ),
        Text(widget.cart.shippingAddress!.address1),
      ],
    );
  }
}

class ListItemCheckOut extends StatelessWidget {
  const ListItemCheckOut({
    super.key,
    required this.carts,
  });

  final Cart carts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.scaffoldBackgroundColor,
        border: Border.all(color: theme.highlightColor)
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: carts.item!.length,
        itemBuilder: (context, index) {
          return ProductItem(product: carts.item![index]);
        },
      ),
    );
  }
}
