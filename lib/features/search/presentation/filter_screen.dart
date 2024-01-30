import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter',
          style: TextStyle(color: primaryText),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close_outlined,
              color: primaryText,
            )),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
            color: secondaryBackground,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: const CustomScrollView(slivers: [
          /// Categories
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Text(
                'Categories',
                style: TextStyle(
                    color: primaryText,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _ItemFilter(),

          /// Brand
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Text(
                'Brand',
                style: TextStyle(
                    color: primaryText,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _ItemFilter(),

          /// Price
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Text(
                'Price',
                style: TextStyle(
                    color: primaryText,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _ItemFilter()
        ]),
      ),
    );
  }
}

class _ItemFilter extends StatelessWidget {
  const _ItemFilter();

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return CheckboxListTile(
            value: index % 2 == 0,
            onChanged: (value) {},
            autofocus: true,
            shape: const CircleBorder(),
            splashRadius: 8,
            activeColor: primaryButton,
            title: Text('checkbox at $index'),
            controlAffinity: ListTileControlAffinity.leading,
          );
        });
  }
}
