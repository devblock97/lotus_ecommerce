
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
          title: const Text('Thanh toán'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Text('Địa chỉ giao hàng'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
              ),
              child: ShippingAddress(cart: widget.carts),
            ),
            const Gap(10),
            const Text('Phương thức thanh toán'),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
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
                    title: Text(method),
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
            const Text('Sản phẩm'),
            ListItemCheckOut(carts: widget.carts),
            const Gap(10),
            const Text('Phương thức giao hàng'),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
              ),
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
            const Gap(10),
            Container(
              padding: const EdgeInsets.all(12),
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
                      Text(totals.totalPrice!.format(code: totals.currencyCode!))
                    ],
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí vận chuyển'),
                      Text(shippingFee)
                    ],
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Khuyến mãi vận chuyển'),
                      Text('0'.format(code: totals.currencyCode!))
                    ],
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Giảm giá'),
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
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tổng tiền'),
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

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
    required this.cart
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    debugPrint('check address: ${cart.shippingAddress?.firstName}; ${cart.shippingAddress?.address1}');
    if (cart.shippingAddress!.isEmpty()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Bạn chưa có địa chỉ giao hàng'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  ShipmentScreen(isUpdate: false, cart: cart,)));
            },
            child: const Column(
              children: [
                Icon(Icons.add),
                Text('Thêm địa chỉ', style: TextStyle(fontSize: 10),)
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
            Text('${cart.shippingAddress!.firstName} ${cart.shippingAddress!.lastName}'),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => sl<shipBloc.ShipmentBloc>()..add(const GetProvincesRequest())),
                  BlocProvider(create: (_) => CityCubit(sl())),
                  BlocProvider(create: (_) => WardCubit(sl()))
                ],
                child: ShipmentScreen(isUpdate: true, cart: cart,)))
              ),
              child: const Text('Thay đổi'),
            )
          ],
        ),
        Text(cart.shippingAddress!.address1),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
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
