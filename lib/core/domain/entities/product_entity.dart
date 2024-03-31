
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEntity {

  ProductEntity({this.docId, required this.name, required this.price, required this.unit, required this.img});

  String? docId;
  final String name;
  final String img;
  final String unit;
  final double price;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'unit': unit,
      'img': img,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      docId: map['docID'] != null ? map['docID'] as String : null,
      name: map['name'] as String,
      price: map['price'] as double,
      unit: map['unit'] as String,
      img: map['img'] as String,
    );
  }

  factory ProductEntity.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ProductEntity(
        docId: doc.id,
        name: doc['name'] as String,
        price: doc['price'] as double,
        unit: doc['unit'] as String,
        img: doc['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductEntity.fromJson(String source) => ProductEntity.fromMap(json.decode(source));
}