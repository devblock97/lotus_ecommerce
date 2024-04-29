
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/home/domain/usecases/get_all_product_use_case.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc(this.getAllProductUseCase) : super(const HomeState()) {
    on<GetProductRequest>(_onProductLoaded);
  }

  final GetAllProductUseCase getAllProductUseCase;

  void _onProductLoaded(GetProductRequest event, Emitter<HomeState> emit) async {
    emit(const ProductLoading());
    try {
        final response = await getAllProductUseCase(NoParams());
        response.fold(
            (error) {
              if (error is ServerFailure) {
                emit(ProductError(error.error));
              }
              if (error is ConnectionFailure) {
                emit(ProductError(error.error));
              }
              if (error is ConnectionFailure) {
                emit(ProductError(error.error));
              }
            },
            (data) {
              emit(ProductSuccess(productList: data));
            }
        );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }


}