import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String username;
  final String password;

  const AuthModel(this.username, this.password);

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password
    };
  }

  @override
  List<Object?> get props => [];
}
