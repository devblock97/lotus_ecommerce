import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';

class EcommerceSearchBar extends StatefulWidget {
  const EcommerceSearchBar({super.key});

  @override
  State<EcommerceSearchBar> createState() => _EcommerceSearchBarState();
}

class _EcommerceSearchBarState extends State<EcommerceSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(builder: (context, controller) {
      return SearchBar(
        onTap: () {
          controller.openView();
        },
        backgroundColor: const WidgetStatePropertyAll(secondaryBackground),
        elevation: WidgetStateProperty.all(5),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        hintText: 'Nhập tìm kiếm...',
        textStyle: WidgetStatePropertyAll(
          TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color)
        ),
        onChanged: (_) => controller.openView(),
        leading: const Icon(Icons.search_outlined),
      );
    }, suggestionsBuilder: (context, suggester) {
      return List<ListTile>.generate(10, (index) {
        return ListTile(
          title: Text(
            'item $index',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          onTap: () {
            setState(() {
              suggester.closeView('item $index');
            });
          },
        );
      });
    });
  }
}
