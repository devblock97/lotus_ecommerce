
import 'package:ecommerce_app/core/data/models/billing.dart';
import 'package:ecommerce_app/core/data/models/shipping.dart';
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