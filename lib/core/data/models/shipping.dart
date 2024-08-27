class Shipping {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String address1;
  final String? address2;
  final String? city;
  final String? postcode;
  final String? country;
  final String? state;
  final String? phone;

  Shipping({
    this.firstName,
    this.lastName,
    this.company,
    required this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.country,
    this.state,
    this.phone,
  });

  bool isEmpty() => city!.isEmpty && address1.isEmpty && address2!.isEmpty;

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      company: json['company'] as String,
      address1: json['address_1'] as String,
      address2: json['address_2'] as String ?? '', // Handle potential null value
      city: json['city'] as String,
      postcode: json['postcode'] as String ?? '', // Handle potential null value
      country: json['country'] as String,
      state: json['state'] as String ?? '', // Handle potential null value
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'first_name': firstName ?? '',
    'last_name': lastName ?? '',
    'company': company ?? '',
    'address_1': address1 ?? '',
    'address_2': address2 ?? '',
    'city': city ?? '',
    'postcode': postcode ?? '',
    'country': country ?? '',
    'state': state ?? '',
    'phone': phone ?? '',
  };
}
