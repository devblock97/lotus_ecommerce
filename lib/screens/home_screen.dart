import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/features/cart/data/datasource/datasource.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_product_card.dart';
import 'package:ecommerce_app/widgets/my_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),

          /// Ecommerce App Bar [_SliverAppBar]
          const _SliverAppBar(),

          const SliverToBoxAdapter(
            child: EcommerceSearchBar(),
          ),

          const SliverToBoxAdapter(
            child: _CarouselHome(),
          ),

          /// Ecommerce [Best Selling] this section include title [Best Selling]
          /// and product lists [Best Selling]
          SliverToBoxAdapter(
            child: _CategorySingleListView(
                categoryName: 'Recommended for you', productList: bestSelling),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: _TitleSection(title: 'Best Selling'),
            ),
          ),
          _SliverCategroyGrid(productLists: bestSelling),

          /// Ecommerce [Exclusive Offer]; this section include title [Exclusive Offer]
          /// and product lists [Exclusive Offer]
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: _TitleSection(title: 'Exclusive Offer'),
            ),
          ),
          _SliverCategroyGrid(productLists: exclusiveOffer),

          /// Ecommerce [All Products]; this section include title [All Products]
          /// and product lists [All Products]
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: _TitleSection(title: 'All Products'),
            ),
          ),
          _SliverCategroyGrid(productLists: allProducts)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Text(
          'See all',
          style: TextStyle(color: primaryButton, fontSize: 16),
        )
      ],
    );
  }
}

class _CarouselHome extends StatelessWidget {
  const _CarouselHome({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      'assets/banners/banner1.jpeg',
      'assets/banners/banner2.jpeg',
      'assets/banners/banner3.jpeg'
    ];
    return Container(
      margin: const EdgeInsets.all(9),
      child: CarouselSlider(
        options: CarouselOptions(
            autoPlay: true, autoPlayCurve: Curves.fastOutSlowIn),
        items: list
            .map((item) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: Image.asset(
                    item,
                    fit: BoxFit.fitHeight,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        children: [
          const Gap(20),
          SvgPicture.asset('assets/icons/logo.svg'),
          const Gap(10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Text(
                'Quan 12, Ho Chi Minh',
                style:
                    TextStyle(color: primaryText, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _CategorySingleListView extends StatefulWidget {
  const _CategorySingleListView(
      {super.key, this.categoryName, this.productList});

  final String? categoryName;
  final List<ProductModel>? productList;

  @override
  State<_CategorySingleListView> createState() => __CategoryListViewState();
}

class __CategoryListViewState extends State<_CategorySingleListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.categoryName != null)
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: _TitleSection(title: widget.categoryName!),
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.productList!.map((e) {
              return SizedBox(
                  height: 300, width: 200, child: ProductCard(product: e));
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SliverCategroyGrid extends StatelessWidget {
  const _SliverCategroyGrid({
    super.key,
    required this.productLists,
  });

  final List<ProductModel> productLists;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 0.60,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ProductCard(product: productLists[index]);
        },
        childCount: productLists.length,
      ),
    );
  }
}
