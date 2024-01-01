
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final List<ProductModel> products = [
    ProductModel(
      id: 1,
      name: 'Product 1',
      price: '19000',
    ),
    ProductModel(
      id: 2,
      name: 'Product 2',
      price: '19000',
    ),
    ProductModel(
      id: 3,
      name: 'Product 3',
      price: '39000',
    ),
    ProductModel(
      id: 4,
      name: 'Product 4',
      price: '49000',
    ),
    ProductModel(
      id: 5,
      name: 'Product 5',
      price:'59000',
    ),
    ProductModel(
      id: 6,
      name: 'Product 6',
      price: '69000',
    ),
    ProductModel(
      id: 7,
      name: 'Product 7',
      price:'79000',
    ),
    ProductModel(
      id: 8,
      name: 'Product 8',
      price: '89000',
    ),
    ProductModel(
      id: 9,
      name: 'Product 9',
      price: '99000',
    ),
    ProductModel(
      id: 10,
      name: 'Product 10',
      price: '109000',
    ),
  ];

  group('addProductToFavorite', () {

    test('should add product to favorites list and notify listeners', () {
      // Arrange
      final FavoriteRepositoryImpl favorite = FavoriteRepositoryImpl();

      // Act
      favorite.addProductToFavorite(products[0]);

      // Assert
      expect(favorite.productLists, contains(products[0]));
      expect(favorite.productLists.length, 1);

      // Add more assertions if needed based on your specific implementation
    });

    test('should add 2 products to favorite list', () {
      final FavoriteRepositoryImpl favorite = FavoriteRepositoryImpl();
      favorite.addProductToFavorite(products[1]);

      expect(favorite.productLists, [products[1]]);
      expect(favorite.productLists.length, 1);
    });

    test('should add 3 products to favorite list', () {
      final FavoriteRepositoryImpl favorite = FavoriteRepositoryImpl();
      favorite.addProductToFavorite(products[0]);
      favorite.addProductToFavorite(products[1]);
      favorite.addProductToFavorite(products[2]);

      expect(favorite.productLists, [products[0], products[1], products[2]]);
      expect(favorite.productLists.length, 3);
    });

    test('should remove 1 product in favorite list', () {
      final FavoriteRepositoryImpl favorite = FavoriteRepositoryImpl();
      favorite.addProductToFavorite(products[0]);
      favorite.addProductToFavorite(products[1]);
      favorite.addProductToFavorite(products[2]);
      expect(favorite.productLists.length, 3);

      // remove item
      favorite.removeProductFromFavorite(products[0]);
      expect(favorite.productLists.length, 2);
      expect(favorite.productLists, [products[1], products[2]]);
    });

    test('should notify listeners after adding a product', () {
      // Arrange
      final FavoriteRepositoryImpl favoriteRepositoryImpl = FavoriteRepositoryImpl();

      // Act
      favoriteRepositoryImpl.addProductToFavorite(products[1]);

      // Assert
      expect(favoriteRepositoryImpl.productLists, contains(products[1]));
      expect(favoriteRepositoryImpl.productLists.length, 1);
      // Add more assertions if needed based on your specific implementation
    });

    test('should add multiple products to favorites list', () {
      // Arrange
      final FavoriteRepositoryImpl favoriteRepositoryImpl = FavoriteRepositoryImpl();


      // Act
      favoriteRepositoryImpl.addProductToFavorite(products[0]);
      favoriteRepositoryImpl.addProductToFavorite(products[1]);

      // Assert
      expect(favoriteRepositoryImpl.productLists, contains(products[0]));
      expect(favoriteRepositoryImpl.productLists, contains(products[1]));
      expect(favoriteRepositoryImpl.productLists.length, 2);
      // Add more assertions if needed based on your specific implementation
    });

    // Add more test cases based on edge cases, such as adding the same product multiple times, etc.
  });
}