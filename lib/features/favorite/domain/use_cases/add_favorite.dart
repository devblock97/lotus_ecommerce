import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/features/favorite/domain/repositories/favorite_repository.dart';

class AddFavorite {
  FavoriteRepository _favoriteRepository;

  AddFavorite(this._favoriteRepository);

  Future<void> addFavorite(ProductModel product) async {
    await _favoriteRepository.addProductToFavorite(product);
  }
}
