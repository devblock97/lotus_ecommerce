
import 'dart:convert';

import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/core/utils/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<AuthResponseModel?> getUserInfo() => throw UnimplementedError('Stub!');
  Future<void> cacheUserInfo(AuthResponseModel userInfo) => throw UnimplementedError('Stub!');
  Future<bool> clearCacheUser(String key) => throw UnimplementedError('Stub!');
}

const CACHED_USER_INFO = 'CACHED_USER_INFO';


class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUserInfo(AuthResponseModel userInfo) async {
    if (userInfo.success is AuthResponseSuccess) {
      debugPrint('trigger cache user info: ${userInfo.success?.data}');
      await sharedPreferences.setString(CACHED_USER_INFO, jsonEncode(userInfo.success!.toJson()));
    }
  }

  @override
  Future<bool> clearCacheUser(String key) async {
    debugPrint('check clear cache user');
    final secureStorage = SecureStorage();
    await secureStorage.removeToken();
    return await sharedPreferences.remove(CACHED_USER_INFO);
  }

  @override
  Future<AuthResponseModel?> getUserInfo() async {
    final jsonString = sharedPreferences.getString(CACHED_USER_INFO);
    debugPrint('check get user info: $jsonString');
    if (jsonString != null) {
      return AuthResponseModel(success: AuthResponseSuccess.fromJson(jsonDecode(jsonString)));
    } else {
      return null;
    }
  }

}