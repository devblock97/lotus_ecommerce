
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';

class GetAllProductUseCase {
  final ProductRepositoryImpl _productRepositoryImpl;

  const GetAllProductUseCase(this._productRepositoryImpl);

  Future<List<ProductModel>> call() async {
    return await _productRepositoryImpl.getAllProducts();
  }
}