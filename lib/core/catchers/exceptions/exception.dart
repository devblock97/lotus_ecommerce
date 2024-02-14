
import 'package:ecommerce_app/core/catchers/errors/failure.dart';

class ServerException implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class CacheException implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}