import 'package:flutter/foundation.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String unit;
  final String thumbnail;
  final List<String> imgDetails;
  final String category;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.thumbnail,
    required this.category,
    required this.imgDetails,
  });
}
