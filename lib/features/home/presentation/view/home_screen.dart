
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart' as product;
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_state.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/product_card.dart' as home;
import 'package:ecommerce_app/features/home/presentation/widgets/product_skelton.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

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
                          children: [
                            Icon(Icons.refresh),
                            Text('Tải lại')
                          ],
                        )
                    ),
                  );
                }
                if (state is ProductSuccess) {
                  return SliverToBoxAdapter(
                    child: _CategorySingleListView(
                      productList: state.productList,),
                  );
                }
                return const SliverToBoxAdapter(child: ProductSkelton());
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
                          children: [
                            Icon(Icons.refresh),
                            Text('Tải lại')
                          ],
                        )
                    ),
                  );
                }
                if (state is ProductSuccess) {
                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 2.0,
                      childAspectRatio: 0.6,
                    ),
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      return home.ProductCard(product: state.productList[index]);
                    },
                      childCount: state.productList.length,
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: ProductSkelton());
              },
            ),

            /// Ecommerce [_SliverCategoryGrid]; this section include title [Exclusive Offer]
            /// and product lists [Exclusive Offer]
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: _TitleSection(title: 'Siêu ưu đãi'),
              ),
            ),
            const SliverToBoxAdapter(child: ProductsList(),),

            /// Ecommerce [All Products]; this section include title [All Products]
            /// and product lists [All Products]
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: _TitleSection(title: 'Tất cả sản phẩm'),
              ),
            ),
            const SliverToBoxAdapter(child: ProductsList()),
          ],
        ),
        // body: _AllProducts(),
      ),
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
      create: (_) => HomeBloc(sl())..add(const GetProductRequest()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is ProductInitial || state is ProductLoading) {
           return const ProductSkelton();
          }
          if (state is ProductSuccess) {
            return GridView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6
                ),
                itemCount: state.productList.length,
                itemBuilder: (_, index) {
                  return  ProductCard(product: state.productList[index]);
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

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar();

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

class _CategorySingleListView extends StatelessWidget {
  const _CategorySingleListView({
    this.productList
  });

  final List<ProductModel>? productList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: productList!.map((e) {
              return SizedBox(
                  height: 320, width: 200, child: ProductCard(product: e));
            }).toList()
        )
    );
  }
}
