
import 'dart:convert';

import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sign_in_model.dart';

abstract class AuthLocalDataSource {
  Future<AuthResponseModel>? getUserInfo() => throw UnimplementedError('Stub!');
  Future<bool>? cacheUserInfo(AuthResponseModel? userInfo) => throw UnimplementedError('Stub!');
}

const CACHED_USER_INFO = 'CACHED_USER_INFO';


class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool>? cacheUserInfo(AuthResponseModel? userInfo) async {
    print('user info: $userInfo');
    if (userInfo != null) {
      await sharedPreferences.setString(CACHED_USER_INFO, jsonEncode(userInfo.toJson()));
      return true;
    }
    await sharedPreferences.remove(CACHED_USER_INFO);
    print('remove done');
    return false;
  }

  @override
  Future<AuthResponseModel>? getUserInfo() {
    final jsonString = sharedPreferences.getString(CACHED_USER_INFO);
    if (jsonString != null) {
      return Future.value(AuthResponseModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

}