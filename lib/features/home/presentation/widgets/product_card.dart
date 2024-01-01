
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../theme/color.dart';
import '../../../cart/data/repositories/cart_repository_impl.dart';
import '../../../notification/data/models/notification.dart';
import '../../../notification/data/repositories/notify_repository_impl.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(product: product)));
      },
      child: Container(
        height: 150,
        width: 100,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: secondaryText),
            borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryButton,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Off ${product.price}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                _AddFavorite(product: product)
              ],
            ),
            const Gap(5),
            Center(
              child: Image.network(
                product.images![0].src!,
              ),
            ),
            Text(
              product.name!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '1cai/ Price',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                _AddProductButton(product: product)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AddFavorite extends StatelessWidget {
  const _AddFavorite({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var favorite = context.watch<FavoriteRepositoryImpl>();
    return Selector<FavoriteRepositoryImpl, bool>(
      builder: (context, isInFavorite, child) => IconButton(
          onPressed: () {
            if (isInFavorite) {
              favorite.removeProductFromFavorite(product);
            } else {
              favorite.addProductToFavorite(product);
            }
          },
          icon: Icon(
            isInFavorite ? Icons.favorite : Icons.favorite_outline,
            color: primaryButton,
          )),
      selector: (_, favorites) => favorites.productLists.any((favorite) => favorite.id == product.id),
    );
  }
}

class _AddProductButton extends StatelessWidget {
  const _AddProductButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var cart = context.read<CartRepositoryImpl>();
    var notif = context.read<NotifyRepositoryImpl>();
    return ElevatedButton(
      onPressed: () {
        cart.addToCart(product, 1);
        notif.addNotification(NotificationModel(
            title: 'Add ${product.name} to cart', isReaded: false));
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(40, 40),
          padding: const EdgeInsets.symmetric(vertical: 8),
          backgroundColor: primaryButton,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: const Icon(Icons.add),
    );
  }
}
