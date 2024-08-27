import 'billing.dart';
import 'shipping.dart';

class CustomerModel {
  final int id;
  final String? dateCreated;
  final String? dateCreatedGmt;
  final String? dateModified;
  final String? dateModifiedGmt;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? username;
  final Billing? billing;
  final Shipping? shipping;
  final bool? isPayingCustomer;
  final String? avatarUrl;

  CustomerModel({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.username,
    required this.billing,
    required this.shipping,
    required this.isPayingCustomer,
    required this.avatarUrl,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    try {
      return CustomerModel(
        id: json['id'] as int,
        dateCreated: json['date_created'] as String,
        dateCreatedGmt: json['date_created_gmt'] as String,
        dateModified: json['date_modified'] as String,
        dateModifiedGmt: json['date_modified_gmt'] as String,
        email: json['email'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        role: json['role'] as String,
        username: json['username'] as String,
        billing: Billing.fromJson(json['billing']),
        shipping: Shipping.fromJson(json['shipping']),
        isPayingCustomer: json['is_paying_customer'] as bool,
        avatarUrl: json['avatar_url'] as String,
      );
    } on Exception catch (e) {
      // Handle casting errors gracefully (e.g., log the error or throw a specific exception)
      throw Exception('Error parsing Customer data: $e');
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date_created': dateCreated,
    'date_created_gmt': dateCreatedGmt,
    'date_modified': dateModified,
    'date_modified_gmt': dateModifiedGmt,
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'role': role,
    'username': username,
    'billing': billing?.toJson(), // Call toJson on nested object
    'shipping': shipping?.toJson(), // Call toJson on nested object
    'is_paying_customer': isPayingCustomer,
    'avatar_url': avatarUrl,
  };
}

