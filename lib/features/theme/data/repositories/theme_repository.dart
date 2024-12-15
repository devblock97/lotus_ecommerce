import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/features/theme/data/data_source/theme_local_data_source.dart';
import 'package:ecommerce_app/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/src/material/app.dart';
import 'package:fpdart/src/either.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.localDataSource});
  final ThemeLocalDataSource localDataSource;

  @override
  Future<Either<Failure, ThemeMode>> getTheme() async {
    return Right(await localDataSource.getTheme());
  }

  @override
  Future<Either<Failure, ThemeMode>> setTheme(ThemeMode theme) async {
    return Right(theme);
  }

}