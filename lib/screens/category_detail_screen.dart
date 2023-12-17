import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_product_card.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatelessWidget {
  CategoryDetail({super.key, required this.categoryName, this.productLists});

  final String categoryName;
  List<ProductModel>? productLists;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: primaryText,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          categoryName,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: primaryText, fontSize: 24),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: secondaryBackground,
        elevation: 0,
      ),
      body: productLists!.isNotEmpty
          ? GridView.builder(
              itemCount: productLists!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.62, crossAxisCount: 2),
              itemBuilder: (_, index) {
                return ProductCard(product: productLists![index]);
              })
          : const Center(
              child: Text(
                'No items found',
                style:
                    TextStyle(color: primaryText, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
