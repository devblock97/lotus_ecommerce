import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class AuthResponse extends Equatable {
  AuthResponseSuccess fromSuccessJson(Map<String, dynamic> json) =>
      throw UnimplementedError('Stub');

  AuthResponseError fromErrorJson(Map<String, dynamic> json) =>
      throw UnimplementedError('Stub');

}

class AuthResponseModel implements AuthResponse {

  const AuthResponseModel({this.success, this.error});

  final AuthResponseSuccess? success;
  final AuthResponseError? error;

  @override
  AuthResponseError fromErrorJson(Map<String, dynamic> json) {
    return AuthResponseError.fromJson(json);
  }

  @override
  AuthResponseSuccess fromSuccessJson(Map<String, dynamic> json) {
    return AuthResponseSuccess.fromJson(json);
  }

  @override
  List<Object?> get props => [success, error];

  @override
  bool? get stringify => false;

}

class AuthResponseSuccess extends Equatable {
  final String token;
  final String userEmail;
  final String userNiceName;
  final String userDisplayName;

  const AuthResponseSuccess(
      this.token, this.userEmail, this.userNiceName, this.userDisplayName);

  factory AuthResponseSuccess.fromJson(Map<String, dynamic> json) {

    return AuthResponseSuccess(
        json['token'],
        json['user_email'],
        json['user_nicename'],
        json['user_display_name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user_email': userEmail,
      'user_nicename': userNiceName,
      'user_display_name': userDisplayName
    };
  }

  @override
  List<Object?> get props => [token, userNiceName, userEmail, userDisplayName];
}

class AuthResponseError extends Equatable {

  final String code;
  final String message;
  final Data data;

  const AuthResponseError(this.code, this.message, this.data);

  factory AuthResponseError.fromJson(Map<String, dynamic> json) {
    return AuthResponseError(
      json['code'],
      json['message'],
      json['data']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }

  @override
  List<Object?> get props => [code, message, data];
}

class Data {
  final int status;

  Data(this.status);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      json['status']
    );
  }

  Map<String, dynamic> toJson() => {'status': status};
}