import 'package:ecommerce_app/features/cart/data/datasource/datasource.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EcommerceSearchBar extends StatefulWidget {
  const EcommerceSearchBar({super.key});

  @override
  State<EcommerceSearchBar> createState() => _EcommerceSearchBarState();
}

class _EcommerceSearchBarState extends State<EcommerceSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SearchAnchor(builder: (context, controller) {
        return SearchBar(
          onTap: () {
            controller.openView();
          },
          backgroundColor: const MaterialStatePropertyAll(secondaryBackground),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          hintText: 'Search Store',
          onChanged: (_) => controller.openView(),
          leading: const Icon(Icons.search_outlined),
        );
      }, suggestionsBuilder: (context, suggestor) {
        return List<ListTile>.generate(allProducts.length, (index) {
          final String item = allProducts![index].name!;
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                suggestor.closeView(item);
              });
            },
          );
        });
      }),
    );
  }
}
