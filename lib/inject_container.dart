
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/home/domain/usecases/get_all_product_use_case.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc


  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));

  // Use Case
  sl.registerLazySingleton(() => GetAllProductUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepositoryImpl>(() => ProductRepositoryImpl());

  // Data Source
  // sl.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(dio: sl(), constantConfig: sl()));

  /**
   * ! Core
   */
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

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
}