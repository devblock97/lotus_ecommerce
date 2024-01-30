
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/post_sign_in.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/post_sign_up.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/domain/usecases/get_all_product_use_case.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));

  // Use Case
  sl.registerLazySingleton(() => GetAllProductUseCase(sl()));
  /// Sign In
  sl.registerLazySingleton(() => PostSignIn(authRepository: sl()));
  /// Sign Up
  sl.registerLazySingleton(() => PostSignUp(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepositoryImpl>(() => ProductRepositoryImpl());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Data Source
  // sl.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(dio: sl(), constantConfig: sl()));

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
  sl.registerLazySingleton(() => InternetConnectionChecker());
}