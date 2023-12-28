
import 'package:ecommerce_app/features/home/data/models/product_model.dart';

abstract class ProductRepository {

  Future<List<ProductModel>> getAllProducts();

}