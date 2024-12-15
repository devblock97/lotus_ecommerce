import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/view/cart_screen.dart';
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/notification/presentation/notify_screen.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.product});

  final ProductModel product;
  var quantity = 1;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: secondaryBackground,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _ImageSlider(product: widget.product),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.name!,
                    style: const TextStyle(
                        color: primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  _AddFavorite(
                    product: widget.product,
                  )
                ],
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('${'cai'}, Price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (widget.quantity > 1) {
                              setState(() {
                                widget.quantity--;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove)),
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: secondaryButton),
                            shape: BoxShape.rectangle),
                        child: Text('${widget.quantity}'),
                      ),
                      IconButton(
                          onPressed: () {
                            if (widget.quantity < 10) {
                              setState(() {
                                widget.quantity++;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.add,
                            color: primaryButton,
                          ))
                    ],
                  ),
                  Text('${widget.product.price} đ',
                      style: const TextStyle(
                          color: primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 24))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                trailing: const Icon(Icons.keyboard_arrow_down),
                title: const Text('Product Detail'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HtmlWidget(widget.product.description!),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ExpansionTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Nutritions'), Text('100gr')],
                ),
              ),
            ),
            const _ProductRatingBar(),
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: EcommerceButton(
            title: 'Thêm vào giỏ hàng',
            onTap: () {
              context.read<CartBloc>().add(AddItemEvent(
                  item: CartItemModel(
                      product: widget.product, quantity: widget.quantity)));
            },
          ),
        ));
  }
}

class _AddFavorite extends StatelessWidget {
  const _AddFavorite({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var favorite = context.read<FavoriteRepositoryImpl>();
    return Selector<FavoriteRepositoryImpl, bool>(
      builder: (context, isInFavorite, child) => IconButton(
        onPressed: () {
          if (isInFavorite) {
            favorite.removeProductFromFavorite(product);
          } else {
            favorite.addProductToFavorite(product);
          }
        },
        icon: Icon(isInFavorite ? Icons.favorite : Icons.favorite_outline),
        color: primaryButton,
      ),
      selector: (_, favorite) =>
          favorite.productLists.any((f) => f.id == product.id),
    );
  }
}

class _ProductRatingBar extends StatefulWidget {
  const _ProductRatingBar();

  @override
  State<_ProductRatingBar> createState() => _ProductRatingBarState();
}

class _ProductRatingBarState extends State<_ProductRatingBar> {
  late final _ratingController;
  late double _rating;

  final double _userRating = 3.0;
  final int _ratingBarMode = 1;
  final double _initialRating = 2.0;
  final bool _isRTLMode = false;
  final bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        trailing: const Icon(Icons.keyboard_arrow_right),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Review'),
            RatingBar.builder(
              itemSize: 20,
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.redAccent,
              ),
              onRatingUpdate: (rating) {
              },
            )
          ],
        ),
      ),
    );
  }
}

class _ImageSlider extends StatefulWidget {
  const _ImageSlider({required this.product});

  final ProductModel product;

  @override
  State<_ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<_ImageSlider> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    List<String> thumbnails = [
      widget.product.images![0].src!,
      widget.product.images![0].src!,
    ];
    return Container(
      height: 300,
      decoration: const BoxDecoration(
          color: secondaryBackground,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(25, 25),
              bottomRight: Radius.elliptical(25, 25))),
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: thumbnails
                  .map((img) => Image.network(
                        img,
                        fit: BoxFit.fitHeight,
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: thumbnails.asMap().entries.map((e) {
              return GestureDetector(
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : primaryButton)
                          .withOpacity(_current == e.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
