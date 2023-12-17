import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const List<ProductModel> favoriteLists = [
    ProductModel(
      id: '1',
      name: 'Product 1',
      price: 19.99,
      unit: 'pcs',
      thumbnail: 'product1_thumbnail.jpg',
      category: 'Electronics',
      imgDetails: ['product1_detail1.jpg', 'product1_detail2.jpg'],
    ),
    ProductModel(
      id: '2',
      name: 'Product 2',
      price: 29.99,
      unit: 'kg',
      thumbnail: 'product2_thumbnail.jpg',
      category: 'Clothing',
      imgDetails: ['product2_detail1.jpg', 'product2_detail2.jpg'],
    ),
    ProductModel(
      id: '3',
      name: 'Product 3',
      price: 39.99,
      unit: 'pcs',
      thumbnail: 'product3_thumbnail.jpg',
      category: 'Home',
      imgDetails: ['product3_detail1.jpg', 'product3_detail2.jpg'],
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
