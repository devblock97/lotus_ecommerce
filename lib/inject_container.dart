
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
import 'package:ecommerce_app/features/checkout/data/datasources/order_remote_datasource.dart';
import 'package:ecommerce_app/features/checkout/data/datasources/shipment_local_datasource.dart';
import 'package:ecommerce_app/features/checkout/data/datasources/shipment_remote_datasource.dart';
import 'package:ecommerce_app/features/checkout/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_app/features/checkout/data/repositories/shipment_repository_impl.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/order_repository.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/shipment_repository.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/order/order_bloc.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/domain/usecases/get_all_product_use_case.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_bloc.dart';
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

  // Use Case
  sl.registerLazySingleton(() => GetAllProductUseCase(sl()));
  /// Sign In
  sl.registerLazySingleton(() => PostSignIn(authRepository: sl()));
  /// Sign Up
  sl.registerLazySingleton(() => PostSignUp(sl()));
  /// Sign Out
  sl.registerLazySingleton(() => PostSignOut(authRepository: sl()));
  /// Get last user info (used to sign in again with enter form)
  sl.registerLazySingleton(() => GetLastUserInfo(sl()));
  sl.registerLazySingleton(() => CreateOrder(orderRepository: sl()));

  sl.registerLazySingleton(() => GetCustomer(customerRepository: sl()));

  /// Get customer info for CheckOut
  sl.registerLazySingleton(() => GetRemoteCustomer(checkoutRepository: sl()));
  sl.registerLazySingleton(() => GetLocalCustomer(checkoutRepository: sl()));

  // Repository
  sl.registerLazySingleton<ProductRepositoryImpl>(() => ProductRepositoryImpl());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<ShippingAddressRepository>(() => ShippingAddressRepositoryImpl(networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CheckOutRemoteDataSource>(() => CheckoutRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CheckOutLocalDataSource>(() => CheckOutLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<OrderRemoteDataSource>(() => OrderRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CustomerRemoteDataSource>(() => CustomerRemoteDataSourceImpl(client: sl()));

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