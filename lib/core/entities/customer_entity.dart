
import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  Billing? billing;
  Shipping? shipping;
  bool? isPayingCustomer;
  String? avatarUrl;
  List<MetaData>? metaData;

  CustomerEntity(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.email,
        this.firstName,
        this.lastName,
        this.role,
        this.username,
        this.billing,
        this.shipping,
        this.isPayingCustomer,
        this.avatarUrl,
        this.metaData});

  @override
  List<Object?> get props => [
    id, dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt,
    email, firstName, lastName, role, username];
}

class Billing {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? postcode;
  String? country;
  String? state;
  String? email;
  String? phone;

  Billing(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.postcode,
        this.country,
        this.state,
        this.email,
        this.phone});

  factory Billing.fromJson(Map<String, dynamic> json) {
    print('checking billing: ${json['address1']}');
    return Billing(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      city: json['city'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class Shipping {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? postcode;
  String? country;
  String? state;
  String? phone;

  Shipping(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.postcode,
        this.country,
        this.state,
        this.phone});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    print('checking shipping: ${json['address1']}');
    return Shipping(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      city: json['city'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address1': address1,
      'address2': address2,
      'city': city,
      'postcode': postcode,
      'country': country,
      'state': state,
      'phone': phone
    };
  }
}

class MetaData {
  int? id;
  String? key;
  String? value;

  MetaData({this.id, this.key, this.value});

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      id: json['id'],
      key: json['key'],
      value: json['value']
    );
  }

}