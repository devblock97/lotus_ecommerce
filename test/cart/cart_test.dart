import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const product1 = ProductModel(
    id: 'SH123',
    name: 'Banana 1',
    price: 4.99,
    unit: 'kg',
    thumbnail: 'assets/icons/product_1.png',
    category: 'Eggs',
    imgDetails: [],
  );

  const product2 = ProductModel(
    id: 'SH122',
    name: 'Banana 2',
    price: 4.99,
    unit: 'kg',
    thumbnail: 'assets/icons/product_1.png',
    category: 'Eggs',
    imgDetails: [],
  );

  const product3 = ProductModel(
    id: 'SH124',
    name: 'Banana 3',
    price: 4.99,
    unit: 'kg',
    thumbnail: 'assets/icons/product_1.png',
    category: 'Eggs',
    imgDetails: [],
  );

  List<CartItemModel> output1 = [];

  List<CartItemModel> output2 = [
    CartItemModel(product: product1, quantity: 1),
  ];

  List<CartItemModel> output3 = [
    CartItemModel(product: product1, quantity: 2),
  ];

  List<CartItemModel> output4 = [
    CartItemModel(product: product1, quantity: 1),
    CartItemModel(product: product2, quantity: 1),
  ];

  List<CartItemModel> output5 = [
    CartItemModel(product: product1, quantity: 2),
    CartItemModel(product: product2, quantity: 1),
  ];

  List<CartItemModel> output6 = [
    CartItemModel(product: product1, quantity: 2),
    CartItemModel(product: product2, quantity: 2),
  ];

  test('cart null', () {
    CartRepositoryImpl cart = CartRepositoryImpl();
    expect(cart.cartLists(), output1);
  });

  test('add 1 item to cart', () {
    CartRepositoryImpl cart = CartRepositoryImpl();
    cart.addToCart(product1, 1);
    expect(cart.cartLists().length, output2.length);
    expect(cart.cartLists()[0].quantity, output2[0].quantity);
  });

  test('add duplicate item - output 3', () {
    CartRepositoryImpl cart = CartRepositoryImpl();
    cart.addToCart(product1, 1);
    cart.addToCart(product1, 1);
    expect(cart.cartLists()[0].product.id, output3[0].product.id);
    expect(cart.cartLists()[0].quantity, output3[0].quantity);
  });

  test('add new 2 item in cart - output 4', () {
    CartRepositoryImpl cart = CartRepositoryImpl();
    cart.addToCart(product1, 1);
    cart.addToCart(product2, 1);
    expect(cart.cartLists()[0].product.id, output4[0].product.id);
    expect(cart.cartLists()[0].quantity, output4[0].quantity);
    expect(cart.cartLists()[1].product.id, output4[1].product.id);
    expect(cart.cartLists()[1].quantity, output4[1].quantity);
  });

  test('test 2 item with 1 item is duplicate - output 5', () {
    CartRepositoryImpl cart = CartRepositoryImpl();
    cart.addToCart(product1, 1);
    cart.addToCart(product1, 1);
    cart.addToCart(product2, 1);

    expect(cart.cartLists()[0].product.id, output5[0].product.id);
    expect(cart.cartLists()[0].quantity, output5[0].quantity);
    expect(cart.cartLists()[1].product.id, output5[1].product.id);
    expect(cart.cartLists()[1].quantity, output5[1].quantity);
  });

  test('test 2 item with 2 item is duplicate - output 6', () {
    CartRepositoryImpl cart = CartRepositoryImpl();
    cart.addToCart(product1, 1);
    cart.addToCart(product1, 1);
    cart.addToCart(product2, 1);
    cart.addToCart(product2, 1);

    expect(cart.cartLists()[0].product.id, output6[0].product.id);
    expect(cart.cartLists()[0].quantity, output6[0].quantity);
    expect(cart.cartLists()[1].product.id, output6[1].product.id);
    expect(cart.cartLists()[1].quantity, output6[1].quantity);
  });

  group('addToCart', () {
    test('should add a new item to the cart when not already in the cart', () {
      // Arrange
      final cart = CartRepositoryImpl(); // Replace with the actual class name
      final product = product1;
      final quantity = 2;

      // Act
      cart.addToCart(product, quantity);

      // Assert
      expect(cart.cartLists().length, 1);
      expect(cart.cartLists()[0].product, product);
      expect(cart.cartLists()[0].quantity, quantity);
    });

    test('should update quantity for existing item in the cart', () {
      // Arrange
      final cart = CartRepositoryImpl(); // Replace with the actual class name
      final product = product2;
      final initialQuantity = 2;
      final updatedQuantity = 5;

      // Act
      cart.addToCart(product, initialQuantity);
      cart.addToCart(product, updatedQuantity);

      // Assert
      expect(cart.cartLists().length, 1);
      expect(cart.cartLists()[0].product, product);
      expect(cart.cartLists()[0].quantity, initialQuantity + updatedQuantity);
    });

    // Add more test cases for edge cases and additional scenarios as needed
  });

  /// Group 2
  group('addToCart', () {
    test('adds item to cart when not already in cart', () {
      // Arrange
      var cart =
          CartRepositoryImpl(); // Replace with the actual class that contains the function
      var product = product1;
      var initialCartLength = cart.cartLists().length;

      // Act
      cart.addToCart(product, 2);

      // Assert
      expect(cart.cartLists().length, initialCartLength + 1);
    });

    test('updates quantity when item is already in cart', () {
      // Arrange
      var cart =
          CartRepositoryImpl(); // Replace with the actual class that contains the function
      var product = product2;
      cart.addToCart(product, 2);
      var initialQuantity = cart.cartLists().first.quantity;

      // Act
      cart.addToCart(product, 3);

      // Assert
      expect(cart.cartLists().first.quantity, initialQuantity + 3);
    });

    test('notifies listeners after updating cart', () {
      // Arrange
      var cart =
          CartRepositoryImpl(); // Replace with the actual class that contains the function
      var product = product3;
      var listenerNotified = false;
      cart.addListener(() {
        listenerNotified = true;
      });

      // Act
      cart.addToCart(product, 2);

      // Assert
      expect(listenerNotified, true);
    });
  });

  /// Group 3
  group('addToCart', () {
    test('adds item to cart when not already in cart', () {
      // Arrange
      var cart =
          CartRepositoryImpl(); // Replace with the actual class that contains the function
      var product = product1;
      var initialCartLength = cart.cartLists().length;

      // Act
      cart.addToCart(product, 2);

      // Assert
      expect(cart.cartLists().length, initialCartLength + 1);
      expect(cart.cartLists().first.product, product);
      expect(cart.cartLists().first.quantity, 2);
    });

    test('updates quantity when item is already in cart', () {
      // Arrange
      var cart =
          CartRepositoryImpl(); // Replace with the actual class that contains the function
      var product = product2;
      cart.addToCart(product, 2);
      var initialQuantity = cart.cartLists().first.quantity;

      // Act
      cart.addToCart(product, 3);

      // Assert
      expect(cart.cartLists().first.quantity, initialQuantity + 3);
    });

    test('notifies listeners after updating cart', () {
      // Arrange
      var cart =
          CartRepositoryImpl(); // Replace with the actual class that contains the function
      var product = product3;
      var listenerNotified = false;
      cart.addListener(() {
        listenerNotified = true;
      });

      // Act
      cart.addToCart(product, 2);

      // Assert
      expect(listenerNotified, true);
    });

    test('adds item with quantity 1 if not specified', () {
      // Arrange
      var cart =
          CartRepositoryImpl(); // Replace with the actual class that contains the function
      var product = product3;
      var initialCartLength = cart.cartLists().length;

      // Act
      cart.addToCart(product, 1);

      // Assert
      expect(cart.cartLists().length, initialCartLength + 1);
      expect(cart.cartLists().first.product, product);
      expect(cart.cartLists().first.quantity, 1);
    });

    test('handles negative quantity by not adding to cart', () {
      // Arrange
      var cart =
          CartRepositoryImpl(); // Replace with the actual class that contains the function
      var product = product2;
      var initialCartLength = cart.cartLists().length;

      // Act
      cart.addToCart(product, -2);

      // Assert
      expect(cart.cartLists().length, initialCartLength);
    });
  });
}
