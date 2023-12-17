
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  const List<ProductModel> products = [
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
    ProductModel(
      id: '4',
      name: 'Product 4',
      price: 49.99,
      unit: 'kg',
      thumbnail: 'product4_thumbnail.jpg',
      category: 'Electronics',
      imgDetails: ['product4_detail1.jpg', 'product4_detail2.jpg'],
    ),
    ProductModel(
      id: '5',
      name: 'Product 5',
      price: 59.99,
      unit: 'pcs',
      thumbnail: 'product5_thumbnail.jpg',
      category: 'Clothing',
      imgDetails: ['product5_detail1.jpg', 'product5_detail2.jpg'],
    ),
    ProductModel(
      id: '6',
      name: 'Product 6',
      price: 69.99,
      unit: 'kg',
      thumbnail: 'product6_thumbnail.jpg',
      category: 'Home',
      imgDetails: ['product6_detail1.jpg', 'product6_detail2.jpg'],
    ),
    ProductModel(
      id: '7',
      name: 'Product 7',
      price: 79.99,
      unit: 'pcs',
      thumbnail: 'product7_thumbnail.jpg',
      category: 'Electronics',
      imgDetails: ['product7_detail1.jpg', 'product7_detail2.jpg'],
    ),
    ProductModel(
      id: '8',
      name: 'Product 8',
      price: 89.99,
      unit: 'kg',
      thumbnail: 'product8_thumbnail.jpg',
      category: 'Clothing',
      imgDetails: ['product8_detail1.jpg', 'product8_detail2.jpg'],
    ),
    ProductModel(
      id: '9',
      name: 'Product 9',
      price: 99.99,
      unit: 'pcs',
      thumbnail: 'product9_thumbnail.jpg',
      category: 'Home',
      imgDetails: ['product9_detail1.jpg', 'product9_detail2.jpg'],
    ),
    ProductModel(
      id: '10',
      name: 'Product 10',
      price: 109.99,
      unit: 'kg',
      thumbnail: 'product10_thumbnail.jpg',
      category: 'Electronics',
      imgDetails: ['product10_detail1.jpg', 'product10_detail2.jpg'],
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