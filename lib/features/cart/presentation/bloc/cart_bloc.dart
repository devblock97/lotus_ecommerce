
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/add_item.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/delete_all_items.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/delete_item.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_items.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/update_item.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final GetCart getCart;
  final AddItemCart addItemCart;
  final UpdateItem updateItem;
  final DeleteItem deleteItem;
  final DeleteAllItems deleteAllItems;

  CartBloc(
      this.getCart,
      this.addItemCart,
      this.updateItem,
      this.deleteItem,
      this.deleteAllItems)
      : super (const CartInitialize()) {
    on<AddItemEvent>((emit, state) => _onAddToCart(emit, state));
    on<GetCartEvent>((emit, state) => _onGetCart(emit, state));
    on<DeleteItemEvent>((emit, state) => _onDeleteItem(emit, state));
    on<IncrementItemEvent>((emit, state) => _onIncrementItem(emit, state));
    on<DecrementItemEvent>((emit, state) => _onDecrementItem(emit, state));
    on<DeleteAllItemEvent>((emit,state) => _onDeleteAllItems(emit, state));
  }

  Future<void> _onAddToCart(AddItemEvent event, Emitter<CartState> emit) async {
    try {
      final response = await addItemCart(ParamAddItemCart(item: event.item));
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
    print('check cart screen trigger');
    try {
      final response = await getCart(NoParams());
      response.fold(
          (error) {
            emit(const CartError(message: 'Xin lỗi, không thể lấy giỏ hàng, vui lòng thử lại sau'));
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
      final response = await deleteItem(ParamPostDeleteItem(key: event.key));
      response.fold(
          (error) => emit(const CartDeleteError()),
          (carts) => emit(CartSuccess(cart: carts, dismiss: true))
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onIncrementItem(IncrementItemEvent event, Emitter<CartState> emit) async {
    try {
      final response = await updateItem(PostParamUpdateItem(key: event.key, quantity: event.quantity));
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