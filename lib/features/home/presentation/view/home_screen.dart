
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_state.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/product_card.dart' as home;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart' as product;

import '../../../../widgets/my_search_bar.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {

  late ProductRepositoryImpl productRepositoryImpl;
  @override
  void initState() {
    super.initState();
    productRepositoryImpl = ProductRepositoryImpl();
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

          /// Ecommerce [Recommended for you] this section include title [Best Selling]
          /// and product lists [Best Selling]
          const SliverToBoxAdapter(
            child: _CategorySingleListView(
                categoryName: 'Recommended for you', productList: null),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: _TitleSection(title: 'Best Selling'),
            ),
          ),
          _SliverCategoryGrid(productRepositoryImpl: productRepositoryImpl,),

          /// Ecommerce [_SliverCategoryGrid]; this section include title [Exclusive Offer]
          /// and product lists [Exclusive Offer]
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
              child: _TitleSection(title: 'Exclusive Offer'),
            ),
          ),
          const SliverToBoxAdapter(child: ProductsList(),),

          /// Ecommerce [All Products]; this section include title [All Products]
          /// and product lists [All Products]
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
              child: _TitleSection(title: 'All Products'),
            ),
          ),
          const SliverToBoxAdapter(child: ProductsList()),
        ],
      ),
      // body: _AllProducts(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(sl())..add(const GetProduct()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is ProductInitial || state is ProductLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if (state is ProductSuccess) {
            return GridView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55
                ),
                itemCount: state.productList.length,
                itemBuilder: (_, index) {
                  return ProductCard(product: state.productList[index]);
                }
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
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
  const _CategorySingleListView({
    super.key,
    this.categoryName,
    this.productList
  });

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
        BlocProvider(
          create: (_) => HomeBloc(sl())..add(const GetProduct()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (_, state) {
              if (state is ProductInitial || state is ProductLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if (state is ProductSuccess) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: state.productList.map((e) {
                        return SizedBox(
                            height: 320, width: 200, child: ProductCard(product: e));
                      }).toList()
                  )
                );
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}

class _SliverCategoryGrid extends StatelessWidget {
  const _SliverCategoryGrid({
    super.key,
    required this.productRepositoryImpl,
  });

  final ProductRepositoryImpl productRepositoryImpl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<product.ProductModel>>(
      future: productRepositoryImpl.getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final productLists = snapshot.data!.map((e) {
              return product.ProductModel(
                id: e.id,
                name: e.name,
                slug: e.slug,
                permalink: e.permalink,
                description: e.description,
                shortDescription: e.shortDescription,
                sku: e.sku,
                price: e.price,
                regularPrice: e.regularPrice,
                salePrice: e.salePrice,
                onSale: e.onSale,
                totalSales: e.totalSales,
                stockQuantity: e.stockQuantity,
                ratingCount: e.ratingCount,
                images: e.images
              );
            }).toList();
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: 0.55,
              ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return home.ProductCard(product: productLists[index]);
                },
                childCount: productLists.length,
              ),
            );
          } else {
            return const SliverToBoxAdapter(child: Center(child: Text('Failed to loading data from server'),));
          }

        }
        else {
          return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),));
        }
      },
    );
  }
}
