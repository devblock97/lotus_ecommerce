
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {

  final String error;
  ServerFailure(this.error);

  @override
  String toString() => 'ServerFailure [errorMessage: $error]';

  @override
  List<Object?> get props => [error];
}

class CacheFailure extends Failure {
  final String error;
  CacheFailure(this.error);

  @override
  String toString() => 'CacheFailure [errorMessage: $error]';

  @override
  List<Object?> get props => [error];
}

class ConnectionFailure extends Failure {
  final String error;
  ConnectionFailure(this.error);

  @override
  String toString() => 'ConnectionFailure [errorMessage: $error]';
  
  @override
  List<Object?> get props => [error];
}