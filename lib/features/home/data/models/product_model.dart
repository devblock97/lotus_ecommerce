
class ProductModel {

  int? id;
  String? name;
  String? slug;
  String? permalink;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  bool? onSale;
  int? totalSales;
  int? stockQuantity;
  int? ratingCount;
  List<ImageModel>? images;

  ProductModel({
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
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      name = json['name'];
      slug = json['slug'];
      permalink = json['permalink'];
      description = json['description'];
      shortDescription = json['short_description'];
      sku = json['sku'];
      price = json['price'];
      regularPrice = json['regular_price'];
      salePrice = json['sale_price'];
      onSale = json['on_sale'];
      totalSales = json['total_sales'];
      stockQuantity = json['stock_quantity'];
      ratingCount = json['rating_count'];
      if (json['images'] != null) {
        images = <ImageModel>[];
        json['images'].forEach((i) {
          images!.add(ImageModel.fromJson(i));
        });
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['permalink'] = permalink;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['sku'] = sku;
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['on_sale'] = onSale;
    data['total_sales'] = totalSales;
    data['stock_quantity'] = stockQuantity;
    data['rating_count'] = ratingCount;
    data['images'] = images;
    return data;
  }
}

class ImageModel {
  int? id;
  String? src;

  ImageModel(this.id, this.src);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    var image = json['src'] as String;
    image = image.replaceAll('localhost', '192.168.110.48');
    return ImageModel(json['id'], image);
  }
}