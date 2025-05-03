import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/add_item.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/delete_all_items.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/delete_item.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_items.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_items_local.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/update_item.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartBloc() : super (const CartInitialize()) {
    on<AddItemEvent>(_onAddToCart);
    on<GetCartEvent>(_onGetCart);
    on<DeleteItemEvent>(_onDeleteItem);
    on<IncrementItemEvent>(_onIncrementItem);
    on<DecrementItemEvent>(_onDecrementItem);
    on<DeleteAllItemEvent>(_onDeleteAllItems);
  }

  Future<void> _onAddToCart(AddItemEvent event, Emitter<CartState> emit) async {
    try {
      final response = await sl<AddItemCart>().call(ParamAddItemCart(item: event.item));
      response.fold(
          (error) {
            emit(const CartError(message: 'Không thể thêm sản phẩm vào giở hàng'));
          },
          (cart) {
            emit(CartSuccess(cart: cart, dismiss: true));
          }
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onGetCart(GetCartEvent event, Emitter<CartState> emit) async {
    debugPrint('check cart screen trigger');
    try {
      final response = await sl<GetCart>().call(NoParams());
      response.fold(
          (error) async {
            final response = await sl<GetCartLocal>().call(NoParams());
            response.fold(
              (error) {
                emit(const CartError(message: 'Xin lỗi, không thể lấy giỏ hàng, vui lòng thử lại sau'));
              },
              (carts) {
                debugPrint('check local cart: ${carts?.item}');
                emit(CartSuccess(cart: carts, dismiss: true));
              }
            );
          },
          (carts) {
            emit(CartSuccess(cart: carts, dismiss: true));
          }
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onDeleteItem(DeleteItemEvent event, Emitter<CartState> emit) async {
    try {
      final response = await sl<DeleteItem>().call(ParamPostDeleteItem(key: event.key));
      response.fold(
          (error) => emit(const CartDeleteError()),
          (carts) => emit(CartSuccess(cart: carts, dismiss: true))
      );
    } catch (e, stackTrace) {
      debugPrint('CartBloc [_onDeleteItem] stackTrace: [$stackTrace]');
      throw Exception(e);
    }
  }

  Future<void> _onIncrementItem(IncrementItemEvent event, Emitter<CartState> emit) async {
    try {
      debugPrint('trigger increment item: ${event.key}; ${event.quantity}');
      final response = await sl<UpdateItem>().call(PostParamUpdateItem(key: event.key, quantity: event.quantity));
      response.fold(
              (error) {
            if (error is NetworkFailure) {
              emit(const CartError(message: 'Không có kết nối đến máy chủ, vui lòng kiểm tra lại internet'));
            }
            else if (error is ServerFailure) {
              emit(const CartError(message: 'Không thể cập nhật giỏ hàng, vui lòng thử lại sau'));
            }
            else {
              emit(const CartError(message: 'Không thể giảm số lượng sản phẩm'));
            }
          },
              (carts) => emit(CartSuccess(cart: carts, dismiss: true))
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onDecrementItem(DecrementItemEvent event, Emitter<CartState> emit) async {
    try {
      debugPrint('trigger decrement item: ${event.key}; ${event.quantity}');
      final response = await sl<UpdateItem>().call(PostParamUpdateItem(key: event.key, quantity: event.quantity));
      response.fold(
        (error) {
          if (error is NetworkFailure) {
            emit(const CartError(message: 'Không có kết nối đến máy chủ, vui lòng kiểm tra lại internet'));
          }
          else if (error is ServerFailure) {
            emit(const CartError(message: 'Không thể cập nhật giỏ hàng, vui lòng thử lại sau'));
          }
          else {
            emit(const CartError(message: 'Không thể giảm số lượng sản phẩm'));
          }
        },
        (carts) => emit(CartSuccess(cart: carts, dismiss: true))
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onDeleteAllItems(DeleteAllItemEvent event, Emitter<CartState> emit) async {
    try {
      final response = await sl<DeleteAllItems>().call(NoParams());
      response.fold(
          (error) => emit(const CartError(message: '')),
          (carts) => emit(CartSuccess(cart: carts, dismiss: true))
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}