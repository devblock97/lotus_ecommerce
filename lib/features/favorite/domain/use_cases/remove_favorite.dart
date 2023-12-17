import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/features/favorite/domain/repositories/favorite_repository.dart';

class RemoveFavorite {
  FavoriteRepository _favoriteRepository;

  RemoveFavorite(this._favoriteRepository);

  Future<void> removeFavorite(ProductModel product) async {
    await _favoriteRepository.removeProductFromFavorite(product);
  }
}
