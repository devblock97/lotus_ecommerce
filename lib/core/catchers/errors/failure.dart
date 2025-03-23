
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ClientError extends Failure {
  final String? error;
  final int? code;

  ClientError({this.error, this.code});

  @override
  List<Object?> get props => [error, code];
}

class ServerFailure extends Failure {

  final String error;
  ServerFailure(this.error);

  @override
  String toString() => 'ServerFailure [errorMessage: $error]';

  @override
  List<Object?> get props => [error];
}

class InputInvalid extends Failure {
  final String? error;
  InputInvalid({required this.error});

  @override
  String toString() => 'UserInvalid [errorMessage: $error]';

  @override
  List<Object?> get props => [error];
}


class CacheFailure extends Failure {
  final String message;
  CacheFailure(this.message);

  @override
  String toString() => 'CacheFailure [errorMessage: $message]';

  @override
  List<Object?> get props => [message];
}

class ConnectionFailure extends Failure {
  final String error;
  ConnectionFailure(this.error);

  @override
  String toString() => 'ConnectionFailure [errorMessage: $error]';
  
  @override
  List<Object?> get props => [error];
}

class NetworkFailure extends Failure {

  final String error;
  NetworkFailure(this.error);

  @override
  String toString() => 'NetworkFailure [errorMessage: $error]';

  @override
  List<Object?> get props => [error];

}