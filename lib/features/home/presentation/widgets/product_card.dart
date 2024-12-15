
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:ecommerce_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(product: product)));
      },
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border.all(color: secondaryText),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header (sale and favorite)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                product.onSale! ? Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryButton,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Giá gốc ${product.regularPrice}đ',
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 10),
                  ),
                )
                : const SizedBox(),

                _AddFavorite(product: product)
              ],
            ),
            const Gap(5),

            // Product image
            Center(
              child: Image.network(
                product.images![0].src!,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),

            // Product name
            Text(
              product.name!,
              style: theme.textTheme.bodyMedium,
            ),

            // Footer (price and add to cart)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.price}đ',
                  style: theme.textTheme.bodyLarge,
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
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CartBloc>().add(AddItemEvent(item: CartItemModel(product: product, quantity: 1)));
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(40, 40),
          padding: const EdgeInsets.symmetric(vertical: 8),
          backgroundColor: primaryButton,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: const Icon(Icons.add, color: Colors.white,),
    );
  }
}
