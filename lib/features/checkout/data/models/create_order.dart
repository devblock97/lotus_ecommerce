import 'package:equatable/equatable.dart';

import '../../../auth/data/models/user_model.dart';

class Order extends Equatable {
  final String? paymentMethod;
  final String paymentMethodTitle;
  final bool? setPaid;
  final Billing? billing;
  final Shipping shipping;
  final List<LineItem> lineItems; // Only using product_id and quantity

  const Order({
    this.paymentMethod,
    required this.paymentMethodTitle,
    this.setPaid,
    this.billing,
    required this.shipping,
    required this.lineItems
  });

  Map<String, dynamic> toJson() {
    return {
      'payment_method': paymentMethod,
      'payment_method_title': paymentMethodTitle,
      'set_paid': setPaid,
      'shipping': shipping.toJson(),
      // 'billing': shipping != null ? billing.toJson() : null,
      'line_items': lineItems
    };
  }

  @override
  List<Object?> get props => [
    paymentMethod,
    paymentMethodTitle,
    setPaid,
    billing,
    shipping,
    lineItems
  ];
}

class LineItem {
  final int productId;
  final int quantity;

  LineItem({required this.productId, required this.quantity});

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(productId: json['product_id'], quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity
  };
}