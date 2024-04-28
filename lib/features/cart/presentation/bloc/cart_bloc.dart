
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/add_item.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/delete_item.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_cart.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/update_item.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final AddItemCart addItemCart;
  final GetCart getCart;
  final DeleteItem deleteItem;
  final UpdateItem updateItem;

  CartBloc(this.addItemCart, this.getCart, this.deleteItem, this.updateItem) : super (const CartLoading()) {
    on<AddToCartEvent>((emit, state) => _onAddToCart(emit, state));
    on<GetCartEvent>((emit, state) => _onGetCart(emit, state));
    on<DeleteItemEvent>((emit, state) => _onDeleteItem(emit, state));
    on<IncrementItemEvent>((emit, state) => _onIncrementItem(emit, state));
    on<DecrementItemEvent>((emit, state) => _onDecrementItem(emit, state));
  }

  Future<void> _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    // emit(const CartLoading());
    try {
      final response = await addItemCart(ParamAddItemCart(item: event.item));
      response.fold(
          (error) {
            print('checking cart screen: error');
            emit(const CartError(message: 'Không thể thêm sản phẩm vào giở hàng'));
          },
          (cart) {
            print('checking cart screen: success - ${cart.itemsCount}');
            emit(CartSuccess(cart));
          }
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onGetCart(GetCartEvent event, Emitter<CartState> emit) async {
    try {
      final response = await getCart(NoParams());
      response.fold(
          (error) {
            print('checking cart screen get cart: error');
            emit(const CartError(message: 'Xin lỗi, không thể lấy giỏ hàng, vui lòng thử lại sau'));
          },
          (carts) {
            print('checking cart screen get cart: success');
            emit(CartSuccess(carts));
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
          (carts) => emit(CartSuccess(carts))
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onIncrementItem(IncrementItemEvent event, Emitter<CartState> emit) async {
    try {
      final response = await updateItem(PostParamUpdateItem(key: event.key, quantity: event.quantity));
      response.fold(
          (error) => emit(const CartError(message: 'Không thể tăng số lượng sản phẩm')),
          (carts) => emit(CartSuccess(carts))
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onDecrementItem(DecrementItemEvent event, Emitter<CartState> emit) async {
    try {
      final response = await updateItem(PostParamUpdateItem(key: event.key, quantity: event.quantity));
      response.fold(
              (error) => emit(const CartError(message: 'Không thể giảm số lượng sản phẩm')),
              (carts) => emit(CartSuccess(carts))
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}