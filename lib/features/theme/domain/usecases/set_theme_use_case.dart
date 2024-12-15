import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/src/either.dart';

class SetThemeMode extends UseCase<ThemeMode, SetThemeParam> {

  SetThemeMode({required this.repository});
  final ThemeRepository repository;

  @override
  Future<Either<Failure, ThemeMode>> call(SetThemeParam params) {
    return repository.setTheme(params.theme);
  }

}

class SetThemeParam {
  const SetThemeParam({required this.theme});
  final ThemeMode theme;
}