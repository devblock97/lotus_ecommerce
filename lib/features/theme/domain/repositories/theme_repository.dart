import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

abstract class ThemeRepository {
  Future<Either<Failure, ThemeMode>> getTheme() => throw UnimplementedError('Stub');
  Future<Either<Failure, ThemeMode>> setTheme(ThemeMode theme) => throw UnimplementedError('Stub');
}