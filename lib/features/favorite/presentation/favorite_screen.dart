import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/product_detail/product_detail_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../data/repositories/favorite_repository_impl.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var favorite = context.watch<FavoriteRepositoryImpl>();
    // var cart = context.read<CartRepository>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Favorite',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: favorite.productLists.length,
        itemBuilder: (_, index) {
          return FavoriteItem(
            product: favorite.productLists[index],
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 20),
        child: favorite.productLists.isNotEmpty
            ? EcommerceButton(
                title: 'Thêm tất cả sản phảm vào giỏ hàng',
                onTap: () {
                  // cart.addAllProductFromFavorite(favorite.productLists);
                  favorite.clearAllFavoriteLists();

                  /// Enable the code below when interact with server
                  // showDialog(
                  //     context: context,
                  //     builder: (_) {
                  //       return FavoriteMessageDialog();
                  //     });
                },
              )
            : Center(
                child: Text(
                  'Sản phẩm yêu thích trống',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
      ),
    );
  }
}

class FavoriteMessageDialog extends StatelessWidget {
  const FavoriteMessageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
        height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/icons/error.png'),
            const Text('Oops! Order Failed'),
            const Gap(5),
            const Text('Something went tembly wrong.'),
            const Gap(5),
            EcommerceButton(
              title: 'Please Try Again',
              onTap: () {},
            ),
            EcommerceButton(
              title: 'Back to home',
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const GroceryApp()),
                  (route) => false),
              backgroundColor: Colors.transparent,
              titleColor: primaryText,
            )
          ],
        ),
      ),
      actions: const [],
    );
  }
}

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key, required this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DetailScreen(product: product!))),
            leading: SizedBox(
                width: 80, height: 80, child: Image.network(product!.images![0].src!)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(product!.name!)),
                Text('\$${product!.price}')
              ],
            ),
            subtitle: const Text('${'cai'}, Price'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          const Gap(10),
          const Divider(
            color: secondaryButton,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
