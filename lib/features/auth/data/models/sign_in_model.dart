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
  final Data? data;

  const AuthResponseModel(
      this.success, this.statusCode, this.message, this.data);

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // When login failure then "data" field will be return []
    // if successful login then "data" return json value
    bool isLoginFailure = (json['data'] is List);
    return AuthResponseModel(
        json['success'] as bool,
        json['statusCode'] as int,
        json['message'] as String,
        isLoginFailure ? null : Data.fromJson(json['data'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data!.toJson()
    };
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

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'email': email,
      'nicename': nicename,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName
    };
  }
}
