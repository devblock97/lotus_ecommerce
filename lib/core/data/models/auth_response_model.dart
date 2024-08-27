import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
  final bool? success;
  final int? statusCode;
  final String? message;
  final String? code;
  final Data data;

  const AuthResponseSuccess({required this.statusCode, required this.data, required this.success, this.message, this.code,});

  factory AuthResponseSuccess.fromJson(Map<String, dynamic> json) {
    debugPrint('success: ${json['success']}');
    debugPrint('code: ${json['code']}');
    debugPrint('status code: ${json['statusCode']}');
    debugPrint('message: ${json['message']}');

    return AuthResponseSuccess(
      success: json['success'],
      code: json['code'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: Data.fromJson(json['data'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'code': code,
      'data': data.toJson()
    };
  }

  @override
  List<Object?> get props => [success, statusCode, code, message, data];
}

class AuthResponseError extends Equatable {

  final String code;
  final String message;
  final int statusCode;
  final bool success;

  const AuthResponseError(this.code, this.message, this.statusCode, this.success);

  factory AuthResponseError.fromJson(Map<String, dynamic> json) {
    return AuthResponseError(
      json['code'],
      json['message'],
      json['statusCode'],
      json['success']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'statusCode': statusCode,
      'success': success
    };
  }

  @override
  List<Object?> get props => [code, message, statusCode, success];
}

class Data {
  final String token;
  final int id;
  final String? email;
  final String? niceName;
  final String? firstName;
  final String? lastName;
  final String? displayName;

  Data({
    required this.token,
    required this.id,
    this.email,
    this.niceName,
    this.firstName,
    this.lastName,
    this.displayName
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      id: json['id'],
      email: json['email'],
      niceName: json['nicename'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      displayName: json['displayName']
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'id': id,
    'email': email,
    'nicename': niceName,
    'firstName': firstName,
    'lastName': lastName,
    'displayName': displayName
  };
}