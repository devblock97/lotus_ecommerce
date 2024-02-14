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

class AuthResponseModel extends Equatable {
  final bool success;
  final int statusCode;
  final String message;
  final Data data;

  const AuthResponseModel(
      this.success, this.statusCode, this.message, this.data);

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(json['success'], json['statusCode'],
        json['message'], Data.fromJson(json['data']));
  }

  @override
  List<Object?> get props => [success, statusCode, message, data];
}

class Data {
  final String token;
  final int id;
  final String email;
  final String nicename;
  final String firstName;
  final String lastName;
  final String displayName;

  const Data(this.token, this.id, this.email, this.nicename, this.firstName,
      this.lastName, this.displayName);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        json['token'] as String,
        json['id'] as int,
        json['email'] as String,
        json['nicename'] as String,
        json['firstName'] as String,
        json['lastName'] as String,
        json['displayName'] as String);
  }
}
