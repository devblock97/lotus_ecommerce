import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/src/either.dart';

class GetThemeMode extends UseCase<ThemeMode, NoParams> {

  GetThemeMode({required this.repository});
  final ThemeRepository repository;

  @override
  Future<Either<Failure, ThemeMode>> call(NoParams params) {
    return repository.getTheme();
  }

}