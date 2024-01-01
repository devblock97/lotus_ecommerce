import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<ProductModel> favoriteLists = [
    ProductModel(
      id: 1,
      name: 'Product 1',
      price: '199000',
    ),
    ProductModel(
      id: 2,
      name: 'Product 2',
      price: '30000',
    ),
    ProductModel(
      id: 3,
      name: 'Product 3',
      price: '40000',
    ),
  ];

  group('remove favorite group', () {
    test('remove single item', () {
      final FavoriteRepositoryImpl favoriteRepositoryImpl =
          FavoriteRepositoryImpl();

      favoriteRepositoryImpl.clearAllFavoriteLists();
      expect(favoriteRepositoryImpl.productLists.length, 0);

      favoriteRepositoryImpl.addProductToFavorite(favoriteLists[0]);
      favoriteRepositoryImpl.addProductToFavorite(favoriteLists[0]);
      favoriteRepositoryImpl.addProductToFavorite(favoriteLists[0]);

    });
  });
}
