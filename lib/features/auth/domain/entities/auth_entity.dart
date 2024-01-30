
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {

  final String username;
  final String password;

  const AuthEntity(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}