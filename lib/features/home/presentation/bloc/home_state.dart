
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus {initial, success, failure, loading}

class HomeState extends Equatable {

  const HomeState({
    this.status = HomeStatus.initial,
    this.productList = const <ProductModel>[],
  });

  final HomeStatus status;
  final List<ProductModel> productList;

  HomeState copyWith({
    HomeStatus? status,
    List<ProductModel>? productList,
  }) {
    return HomeState(
      status: status ?? this.status,
      productList: productList ?? this.productList
    );
  }

  @override
  List<Object?> get props => [status, productList];

}

class ProductInitial extends HomeState {

  final HomeStatus homeStatus;
  final List<ProductModel> productList;

  const ProductInitial({this.homeStatus = HomeStatus.initial, this.productList = const <ProductModel>[]});

  @override
  List<Object?> get props => [homeStatus, productList];
}

class ProductSuccess extends HomeState {
  const ProductSuccess({required this.productList});

  final List<ProductModel> productList;

  @override
  List<Object?> get props => [productList];
}

class ProductLoading extends HomeState {
  const ProductLoading({this.status = HomeStatus.loading});
  final HomeStatus status;
}

class ProductError extends HomeState {

  const ProductError(this.error);

  final String error;
}