import 'dart:async';
import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  Completer<void>? _refreshingCompleter;

  Future<void> storeToken(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  Future<void> refreshToken() async {
    if (_refreshingCompleter != null) {
      await _refreshingCompleter!.future;
      return;
    }

    _refreshingCompleter = Completer<void>();
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        final response = await http.post(
          Uri.parse('${ApiConfig.apiUrl}/wp-json/jwt-auth/v1/token/refresh')
        );
      }
    } finally {
      _refreshingCompleter!.complete();
      _refreshingCompleter = null;
    }
  }
}