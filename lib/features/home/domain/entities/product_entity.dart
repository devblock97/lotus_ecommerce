
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {

  final String? id;
  final String? name;
  final String? slug;
  final String? permalink;
  final String? description;
  final String? shortDescription;
  final String? sku;
  final String? price;
  final String? regularPrice;
  final String? salePrice;
  final bool? onSale;
  final int? totalSales;
  final int? stockQuantity;
  final int? ratingCount;
  final List<dynamic>? upsellIds;
  final List<dynamic>? categories;
  final List<String>? tags;
  final List<dynamic>? images;
  final List<int>? relatedIds;

  const ProductEntity(
      this.id,
      this.name,
      this.slug,
      this.permalink,
      this.description,
      this.shortDescription,
      this.sku,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.onSale,
      this.totalSales,
      this.stockQuantity,
      this.ratingCount,
      this.upsellIds,
      this.categories,
      this.tags,
      this.images,
      this.relatedIds,
      );

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    permalink,
    description,
    shortDescription,
    sku,
    price,
    regularPrice,
    salePrice,
    onSale,
    totalSales,
    stockQuantity,
    ratingCount,
    upsellIds,
    categories,
    tags,
    images,
    relatedIds,
  ];

}

class CategoryEntity extends Equatable {

  final String? id;
  final String? name;
  final String? slug;

  const CategoryEntity(
      this.id,
      this.name,
      this.slug);

  @override
  List<Object?> get props => throw UnimplementedError();

}