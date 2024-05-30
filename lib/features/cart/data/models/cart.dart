
import 'package:ecommerce_app/core/data/models/billing.dart';
import 'package:ecommerce_app/core/data/models/shipping.dart';

class Cart {
  List<Product>? item;
  Totals? totals;
  List<Coupon>? coupons;
  Shipping? shippingAddress;
  Billing? billingAddress;
  bool? needsPayment;
  bool? needsShipping;
  List<String>? paymentRequirements;
  bool? hasCalculatedShipping;
  List<ShippingRates>? shippingRates;
  int? itemsCount;
  int? itemsWeight;
  List<String>? paymentMethods;

  Cart({
    this.item,
    this.totals,
    this.shippingAddress,
    this.billingAddress,
    this.needsPayment,
    this.needsShipping,
    this.paymentRequirements,
    this.hasCalculatedShipping,
    this.shippingRates,
    this.itemsCount,
    this.itemsWeight,
    this.paymentMethods,
    this.coupons});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      item = <Product>[];
      json['items'].forEach((v) { item!.add(Product.fromJson(v)); });
    }
    if (json['coupon'] != null) {
      coupons = <Coupon>[];
      json['coupon'].forEach((v) => coupons!.add(Coupon.fromJson(v)));
    } else {
      coupons = <Coupon>[];
    }
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
    shippingAddress = Shipping.fromJson(json['shipping_address']);
    billingAddress = Billing.fromJson(json['billing_address']);
    needsPayment = json['needs_payment'];
    needsShipping = json['needs_shipping'];
    paymentRequirements = json['payment_requirements'].cast<String>();
    hasCalculatedShipping = json['has_calculated_shipping'];
    if (json['shipping_rates'] != null) {
      shippingRates = <ShippingRates>[];
      json['shipping_rates'].forEach((v) { shippingRates!.add(ShippingRates.fromJson(v)); });
    }
    itemsCount = json['items_count'];
    itemsWeight = json['items_weight'];
    paymentMethods = json['payment_methods'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (item != null) {
      data['items'] = item!.map((v) => v.toJson()).toList();
    }
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    if (billingAddress != null) {
      data['billing_address'] = billingAddress!.toJson();
    }
    data['needs_payment'] = needsPayment;
    data['needs_shipping'] = needsShipping;
    data['payment_requirements'] = paymentRequirements;
    data['has_calculated_shipping'] = hasCalculatedShipping;
    if (shippingRates != null) {
      data['shipping_rates'] = shippingRates!.map((v) => v.toJson()).toList();
    }
    data['items_count'] = itemsCount;
    data['items_weight'] = itemsWeight;
    data['payment_methods'] = paymentMethods;
    return data;
  }
}

class Product {
  final String? key;
  final int? id;
  final String? type;
  final int? quantity;
  final String? name;
  final String? shortDescription;
  final String? description;
  final String? sku;
  final bool? backordersAllowed;
  final bool? showBackorderBadge;
  final bool? soldIndividually;
  final String? permalink;
  final List<Images>? images;
  final Prices? prices;
  final Totals? totals;
  final String? catalogVisibility;

  Product({
    this.key,
    this.id,
    this.type,
    this.quantity,
    this.name,
    this.shortDescription,
    this.description,
    this.sku,
    this.backordersAllowed,
    this.showBackorderBadge,
    this.soldIndividually,
    this.permalink,
    this.images,
    this.prices,
    this.totals,
    this.catalogVisibility});

  factory Product.fromJson(Map<String, dynamic> json) {
    final imageList = (json['images'] as List).map((img) => Images.fromJson(img)).toList();
    return Product(
      key: json['key'],
      id: json['id'],
      type: json['type'],
      quantity: json['quantity'],
      name: json['name'],
      shortDescription: json['short_description'],
      description: json['description'],
      sku: json['sku'],
      backordersAllowed: json['backorders_allowed'],
      showBackorderBadge: json['show_backorder_badge'],
      soldIndividually: json['sold_individually'],
      permalink: json['permalink'],
      images: imageList,
      prices: json['prices'] != null ? Prices.fromJson(json['prices']) : null,
      totals: json['totals'] != null ? Totals.fromJson(json['totals']) : null,
      catalogVisibility: json['catalog_visibility'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['id'] = id;
    data['type'] = type;
    data['quantity'] = quantity;
    data['name'] = name;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['sku'] = sku;
    data['backorders_allowed'] = backordersAllowed;
    data['show_backorder_badge'] = showBackorderBadge;
    data['sold_individually'] = soldIndividually;
    data['permalink'] = permalink;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (prices != null) {
      data['prices'] = prices!.toJson();
    }
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    data['catalog_visibility'] = catalogVisibility;
    return data;
  }
}

class Coupon {
  String? code;
  String? discountType;
  Totals? totals;

  Coupon(this.code, this.discountType, this.totals);

  Coupon.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    discountType = json['discount_type'];
    totals = Totals.fromJson(json['totals']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['discount_type'] = discountType;
    data['totals'] = totals?.toJson();
    return data;
  }
}

class Images {
  int? id;
  String? src;
  String? thumbnail;
  String? srcset;
  String? sizes;
  String? name;
  String? alt;

  Images({this.id, this.src, this.thumbnail, this.srcset, this.sizes, this.name, this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    src = json['src'];
    thumbnail = json['thumbnail'];
    srcset = json['srcset'];
    sizes = json['sizes'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['src'] = src;
    data['thumbnail'] = thumbnail;
    data['srcset'] = srcset;
    data['sizes'] = sizes;
    data['name'] = name;
    data['alt'] = alt;
    return data;
  }
}

class Prices {
  String? price;
  String? regularPrice;
  String? salePrice;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;
  RawPrices? rawPrices;

  Prices({
    this.price,
    this.regularPrice,
    this.salePrice,
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
    this.rawPrices});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
    rawPrices = json['raw_prices'] != null ? RawPrices.fromJson(json['raw_prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['currency_code'] = currencyCode;
    data['currency_symbol'] = currencySymbol;
    data['currency_minor_unit'] = currencyMinorUnit;
    data['currency_decimal_separator'] = currencyDecimalSeparator;
    data['currency_thousand_separator'] = currencyThousandSeparator;
    data['currency_prefix'] = currencyPrefix;
    data['currency_suffix'] = currencySuffix;
    if (rawPrices != null) {
      data['raw_prices'] = rawPrices!.toJson();
    }
    return data;
  }
}

class RawPrices {
  int? precision;
  String? price;
  String? regularPrice;
  String? salePrice;

  RawPrices({this.precision, this.price, this.regularPrice, this.salePrice});

  RawPrices.fromJson(Map<String, dynamic> json) {
    precision = json['precision'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['precision'] = precision;
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    return data;
  }
}

class Total {
  String? lineSubtotal;
  String? lineSubtotalTax;
  String? lineTotal;
  String? lineTotalTax;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  Total({
    this.lineSubtotal,
    this.lineSubtotalTax,
    this.lineTotal,
    this.lineTotalTax,
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix});

  Total.fromJson(Map<String, dynamic> json) {
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'];
    lineTotalTax = json['line_total_tax'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['line_subtotal'] = lineSubtotal;
    data['line_subtotal_tax'] = lineSubtotalTax;
    data['line_total'] = lineTotal;
    data['line_total_tax'] = lineTotalTax;
    data['currency_code'] = currencyCode;
    data['currency_symbol'] = currencySymbol;
    data['currency_minor_unit'] = currencyMinorUnit;
    data['currency_decimal_separator'] = currencyDecimalSeparator;
    data['currency_thousand_separator'] = currencyThousandSeparator;
    data['currency_prefix'] = currencyPrefix;
    data['currency_suffix'] = currencySuffix;
    return data;
  }
}


class Totals {
  String? totalItems;
  String? totalItemsTax;
  String? totalFees;
  String? totalFeesTax;
  String? totalDiscount;
  String? totalDiscountTax;
  String? totalShipping;
  String? totalShippingTax;
  String? totalPrice;
  String? totalTax;
  String? currencySymbol;
  String? currencyCode;
  String? currencyPrefix;
  String? currencySuffix;

  Totals({this.totalItems, this.totalItemsTax, this.totalFees,
    this.totalFeesTax, this.totalDiscount, this.totalDiscountTax,
    this.totalShipping, this.totalShippingTax, this.totalPrice, this.totalTax,
    this.currencySymbol, this.currencyPrefix, this.currencySuffix,
    this.currencyCode
  });

  Totals.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalItemsTax = json['total_items_tax'];
    totalFees = json['total_fees'];
    totalFeesTax = json['total_fees_tax'];
    totalDiscount = json['total_discount'];
    totalDiscountTax = json['total_discount_tax'];
    totalShipping = json['total_shipping'];
    totalShippingTax = json['total_shipping_tax'];
    totalPrice = json['total_price'];
    totalTax = json['total_tax'];
    currencySymbol = json['currency_symbol'];
    currencyCode = json['currency_code'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['total_items_tax'] = totalItemsTax;
    data['total_fees'] = totalFees;
    data['total_fees_tax'] = totalFeesTax;
    data['total_discount'] = totalDiscount;
    data['total_discount_tax'] = totalDiscountTax;
    data['total_shipping'] = totalShipping;
    data['total_shipping_tax'] = totalShippingTax;
    data['total_price'] = totalPrice;
    data['total_tax'] = totalTax;
    data['currency_symbol'] = currencySymbol;
    data['currency_code'] = currencyCode;
    data['currency_prefix'] = currencyPrefix;
    data['currency_suffix'] = currencySuffix;
    return data;
  }
}

class ShippingRates {
  int? packageId;
  String? name;
  Destination? destination;
  List<Items>? items;
  List<ShippingRatesItem>? shippingRates;

  ShippingRates({this.packageId, this.name, this.destination, this.items, this.shippingRates});

  ShippingRates.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    name = json['name'];
    destination = json['destination'] != null ? Destination.fromJson(json['destination']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) { items!.add(Items.fromJson(v)); });
    }
    if (json['shipping_rates'] != null) {
      shippingRates = <ShippingRatesItem>[];
      json['shipping_rates'].forEach((v) { shippingRates!.add(ShippingRatesItem.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_id'] = packageId;
    data['name'] = name;
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (shippingRates != null) {
      data['shipping_rates'] = shippingRates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Destination {
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  Destination({this.address1, this.address2, this.city, this.state, this.postcode, this.country});

  Destination.fromJson(Map<String, dynamic> json) {
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    return data;
  }
}

class Items {
  String? key;
  String? name;
  int? quantity;

  Items({this.key, this.name, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}

class ShippingRatesItem {
  String? rateId;
  String? name;
  String? description;
  String? deliveryTime;
  String? price;
  String? taxes;
  int? instanceId;
  String? methodId;
  List<MetaData>? metaData;
  bool? selected;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  ShippingRatesItem({this.rateId, this.name, this.description, this.deliveryTime, this.price, this.taxes, this.instanceId, this.methodId, this.metaData, this.selected, this.currencyCode, this.currencySymbol, this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix});

  ShippingRatesItem.fromJson(Map<String, dynamic> json) {
    rateId = json['rate_id'];
    name = json['name'];
    description = json['description'];
    deliveryTime = json['delivery_time'];
    price = json['price'];
    taxes = json['taxes'];
    instanceId = json['instance_id'];
    methodId = json['method_id'];
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) { metaData!.add(MetaData.fromJson(v)); });
    }
    selected = json['selected'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate_id'] = rateId;
    data['name'] = name;
    data['description'] = description;
    data['delivery_time'] = deliveryTime;
    data['price'] = price;
    data['taxes'] = taxes;
    data['instance_id'] = instanceId;
    data['method_id'] = methodId;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    data['selected'] = selected;
    data['currency_code'] = currencyCode;
    data['currency_symbol'] = currencySymbol;
    data['currency_minor_unit'] = currencyMinorUnit;
    data['currency_decimal_separator'] = currencyDecimalSeparator;
    data['currency_thousand_separator'] = currencyThousandSeparator;
    data['currency_prefix'] = currencyPrefix;
    data['currency_suffix'] = currencySuffix;
    return data;
  }
}

class MetaData {
  String? key;
  String? value;

  MetaData({this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}