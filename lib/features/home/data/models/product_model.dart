
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['permalink'] = this.permalink;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['on_sale'] = this.onSale;
    data['total_sales'] = this.totalSales;
    data['stock_quantity'] = this.stockQuantity;
    data['rating_count'] = this.ratingCount;
    data['images'] = this.images;
    return data;
  }
}

class ImageModel {
  int? id;
  String? src;

  ImageModel(this.id, this.src);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    var image = json['src'] as String;
    image = image.replaceAll('localhost', '192.168.110.47');
    return ImageModel(json['id'], image);
  }
}