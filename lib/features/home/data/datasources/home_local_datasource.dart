
import 'dart:convert';

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/constants/message_systems.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDatasource {

  Future<List<ProductModel>> getAllProducts() => throw UnimplementedError('Stub');

  Future<void> saveAllProducts(List<ProductModel> products) => throw UnimplementedError('Stub');

}

const ALL_PRODUCTS = 'ALL_PRODUCTS';

class HomeLocalDataSourceImpl implements HomeLocalDatasource {

  const HomeLocalDataSourceImpl(this.localSource);

  final SharedPreferences localSource;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = localSource.getString(ALL_PRODUCTS);
      final body = jsonDecode(response!) as List;
      final products = body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        final product = ProductModel.fromJson(map);
        return product;
      }).toList();
      return products;
    } catch (e) {
      print('retrieve error');
      return [];
    }
  }

  @override
  Future<void> saveAllProducts(List<ProductModel> products) async {
    try {

      final productJson = jsonEncode(products.map((p) {
        print('checking on save all product: ${jsonEncode(p.toJson())}');
        return p.toJson();
      }).toList());
      print('on save all product listening: $productJson');

      localSource.setString(ALL_PRODUCTS, productJson);
    } on CacheException {
      throw CacheFailure(CACHE_ERROR);
    }
  }

}