
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/domain/usecases/get_all_product_use_case.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc(this.getAllProductUseCase) : super(const HomeState()) {
    on<GetProduct>(_onProductLoaded);
  }

  final GetAllProductUseCase getAllProductUseCase;

  void _onProductLoaded(GetProduct event, Emitter<HomeState> emit) async {
    emit(const ProductLoading());
    try {
        final products = await getAllProductUseCase.call();
        print('get all products: $products');
        emit(ProductSuccess(productList: products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }


}