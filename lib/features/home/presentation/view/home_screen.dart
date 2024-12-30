import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_state.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/product_skeleton.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/my_search_bar.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = sl<HomeBloc>()..add(const GetProductRequest());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (_) => homeBloc,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [

              const SliverAppBar(
                flexibleSpace: EcommerceSearchBar(),
                pinned: true,
                floating: true,
              ),

              const SliverToBoxAdapter(
                child: _CarouselHome(),
              ),

              /// Ecommerce [Recommended for you] this section include title [Best Selling]
              /// and product lists [Best Selling]
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: _TitleSection(title: 'Phù hợp cho bạn'),
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is ProductError) {
                    return SliverToBoxAdapter(
                      child: ElevatedButton(
                        onPressed: () {
                          homeBloc.add(const GetProductRequest());
                        },
                        child: const Column(
                          children: [Icon(Icons.refresh), Text('Tải lại')],
                        )),
                    );
                  }
                  if (state is ProductSuccess) {
                    return SliverToBoxAdapter(
                      child: _CategorySingleListView(
                        productList: state.productList,
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: ProductSkeleton());
                },
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: _TitleSection(title: 'Sản phẩm bán chạy'),
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is ProductError) {
                    return SliverToBoxAdapter(
                      child: ElevatedButton(
                        onPressed: () {
                          homeBloc.add(const GetProductRequest());
                        },
                        child: const Column(
                          children: [Icon(Icons.refresh), Text('Tải lại')],
                        )),
                    );
                  }
                  if (state is ProductSuccess) {
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.8),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ProductCard(product: state.productList[index]);
                        },
                        childCount: state.productList.length,
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: ProductSkeleton());
                },
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: _TitleSection(title: 'Tất cả sản phẩm'),
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is ProductError) {
                    return SliverToBoxAdapter(
                      child: ElevatedButton(
                          onPressed: () {
                            homeBloc.add(const GetProductRequest());
                          },
                          child: const Column(
                            children: [Icon(Icons.refresh), Text('Tải lại')],
                          )),
                    );
                  }
                  if (state is ProductSuccess) {
                    return SliverGrid(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.8),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ProductCard(product: state.productList[index]);
                        },
                        childCount: state.productList.length,
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: ProductSkeleton());
                },
              ),
            ],
          ),
        ),
        // body: _AllProducts(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({
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
        // const Text(
        //   'See all',
        //   style: TextStyle(color: primaryButton, fontSize: 16),
        // )
      ],
    );
  }
}

class _CarouselHome extends StatelessWidget {
  const _CarouselHome();

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

class _CategorySingleListView extends StatelessWidget {
  const _CategorySingleListView({this.productList});

  final List<ProductModel>? productList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: productList!.map((e) {
          return SizedBox(
              height: 260, width: 190, child: ProductCard(product: e));
        }).toList()));
  }
}
