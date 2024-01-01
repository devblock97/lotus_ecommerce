import 'package:ecommerce_app/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

class FavoriteRepositoryImpl extends ChangeNotifier
    implements FavoriteRepository {
  List<ProductModel> productLists = [];

  @override
  Future<void> addProductToFavorite(ProductModel product) async {
    productLists.add(product);
    notifyListeners();
  }

  @override
  Future<List<ProductModel>> favoriteLists() async {
    final favoriteLists = productLists;
    return favoriteLists;
  }

  @override
  Future<void> removeProductFromFavorite(ProductModel product) async {
    productLists.remove(product);
    notifyListeners();
  }

  @override
  Future<void> clearAllFavoriteLists() async {
    productLists.clear();
    notifyListeners();
  }
}
