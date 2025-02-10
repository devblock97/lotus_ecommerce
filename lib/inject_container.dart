
import 'package:ecommerce_app/core/data/datasources/customer_remote_data_source.dart';
import 'package:ecommerce_app/core/data/repositories/customer_repository_impl.dart';
import 'package:ecommerce_app/core/domain/repositories/customer_repository.dart';
import 'package:ecommerce_app/core/domain/usecase/customer/get_customer.dart';
import 'package:ecommerce_app/features/account/presentation/bloc/customer_bloc.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/get_last_auth.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/post_sign_in.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/post_sign_out.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/post_sign_up.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:ecommerce_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/add_item.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/delete_all_items.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/delete_item.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_items.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_items_local.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/update_item.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/checkout/data/datasources/order_remote_datasource.dart';
import 'package:ecommerce_app/features/checkout/data/datasources/shipment_local_datasource.dart';
import 'package:ecommerce_app/features/checkout/data/datasources/shipment_remote_datasource.dart';
import 'package:ecommerce_app/features/checkout/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_app/features/checkout/data/repositories/shipment_repository_impl.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/order_repository.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/shipment_repository.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/order/order_bloc.dart';
import 'package:ecommerce_app/features/home/data/datasources/home_local_datasource.dart';
import 'package:ecommerce_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/home/domain/usecases/get_all_product_use_case.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/features/shipment/data/datasources/shipment_local_data_source.dart';
import 'package:ecommerce_app/features/shipment/data/datasources/shipment_remote_data_source.dart';
import 'package:ecommerce_app/features/shipment/data/repositories/shipment_repository_impl.dart';
import 'package:ecommerce_app/features/shipment/domain/repositories/shipment_repository.dart';
import 'package:ecommerce_app/features/shipment/domain/usecase/get_cities.dart';
import 'package:ecommerce_app/features/shipment/domain/usecase/get_provinces.dart';
import 'package:ecommerce_app/features/shipment/domain/usecase/get_wards.dart';
import 'package:ecommerce_app/features/shipment/domain/usecase/update_address.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/city_bloc.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/shipment_bloc.dart' as ship;
import 'package:ecommerce_app/features/shipment/presentation/bloc/ward_cubit.dart';
import 'package:ecommerce_app/features/theme/data/data_source/theme_local_data_source.dart';
import 'package:ecommerce_app/features/theme/data/repositories/theme_repository.dart';
import 'package:ecommerce_app/features/theme/domain/repositories/theme_repository.dart';
import 'package:ecommerce_app/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:ecommerce_app/features/theme/domain/usecases/set_theme_use_case.dart';
import 'package:ecommerce_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/checkout/domain/usecases/use_case.dart';
import 'features/checkout/presentation/bloc/shipment/shipment_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  /// Main home screen
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));
  /// Auth
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl(), sl()));
  /// Check Out
  sl.registerFactory<ShipmentBloc>(() => ShipmentBloc(getLocalCustomer: sl(), getRemoteCustomer: sl()));
  sl.registerFactory<OrderBloc>(() => OrderBloc(createOrder: sl()));
  ///
  sl.registerFactory(() => CustomerBloc(getCustomer: sl(), getLastUserInfo: sl()));
  sl.registerFactory(() => CartBloc()..add(const GetCartEvent()));
  sl.registerFactory(() => ship.ShipmentBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => CityCubit(sl()));
  sl.registerFactory(() => WardCubit(sl()));
  sl.registerFactory(() => ThemeBloc());

  /// Use Case
  sl.registerLazySingleton(() => GetAllProductUseCase(sl()));
  // Sign In
  sl.registerLazySingleton(() => PostSignIn(authRepository: sl()));
  // Sign Up
  sl.registerLazySingleton(() => PostSignUp(sl()));
  // Sign Out
  sl.registerLazySingleton(() => PostSignOut(authRepository: sl()));
  // Get last user info (used to sign in again with enter form)
  sl.registerLazySingleton(() => GetLastUserInfo(sl()));
  sl.registerLazySingleton(() => CreateOrder(orderRepository: sl()));

  sl.registerLazySingleton(() => GetCustomer(customerRepository: sl()));

  /// Get customer info for CheckOut
  sl.registerLazySingleton(() => GetRemoteCustomer(checkoutRepository: sl()));
  sl.registerLazySingleton(() => GetLocalCustomer(checkoutRepository: sl()));
  sl.registerLazySingleton(() => AddItemCart(cartRepository: sl()));
  sl.registerLazySingleton(() => GetCart(sl()));
  sl.registerLazySingleton(() => GetCartLocal(sl()));
  sl.registerLazySingleton(() => DeleteItem(cartRepository: sl()));
  sl.registerLazySingleton(() => UpdateItem(sl()));
  sl.registerLazySingleton(() => DeleteAllItems(sl()));
  sl.registerLazySingleton(() => GetProvinces(repository: sl()));
  sl.registerLazySingleton(() => GetCities(sl()));
  sl.registerLazySingleton(() => GetWards(sl()));
  sl.registerLazySingleton(() => UpdateAddress(sl()));
  sl.registerLazySingleton(() => SetThemeMode(repository: sl()));
  sl.registerLazySingleton(() => GetThemeMode(repository: sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<ShippingAddressRepository>(() => ShippingAddressRepositoryImpl(networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<ShipmentRepository>(() => ShipmentRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(localDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CheckOutRemoteDataSource>(() => CheckoutRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CheckOutLocalDataSource>(() => CheckOutLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<OrderRemoteDataSource>(() => OrderRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CustomerRemoteDataSource>(() => CustomerRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<HomeLocalDatasource>(() => HomeLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSourceImpl());
  sl.registerLazySingleton(() => ShipmentLocalDataSourceImpl(sl()));
  sl.registerLazySingleton(() => ShipmentRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDataSourceImpl(preferences: sl()));

  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  // sl.registerLazySingleton(() {
  //   final dio = Dio();
  //   dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
  //   dio.interceptors.add(DioLoggingInterceptor());
  //   return dio;
  // });
  // sl.registerLazySingleton(() => ConstantConfig());
  // sl.registerLazySingleton(() => DataConnectionChecker());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}