import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/favorite/domain/repositories/favorite_repository.dart';

class GetFavoriteList {
  FavoriteRepository _favoriteRepository;

  GetFavoriteList(this._favoriteRepository);

  Future<List<ProductModel>> getFavoriteLists() async {
    final favoriteLists = await _favoriteRepository.favoriteLists();
    return favoriteLists;
  }
}
