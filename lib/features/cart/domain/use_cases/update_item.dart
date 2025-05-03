

import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/src/either.dart';

class UpdateItem extends UseCase<Cart, PostParamUpdateItem> {

  UpdateItem(this.cartRepository);
  final CartRepository cartRepository;

  @override
  Future<Either<Failure, Cart>> call(PostParamUpdateItem params) async {
    debugPrint('trigger update item call');
    return cartRepository.updateItem(params.key, params.quantity);
  }
}

class PostParamUpdateItem extends Equatable {

  const PostParamUpdateItem({required this.key, required this.quantity});
  final String key;
  final int quantity;

  @override
  List<Object?> get props => [key, quantity];
}