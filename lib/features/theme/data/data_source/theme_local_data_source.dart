import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeMode> getTheme() => throw UnimplementedError('Stub');
  Future<void> setTheme(ThemeMode theme) => throw UnimplementedError('Stun');
}

const IS_DARK_MODE = 'IS_DARK_MODE';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {

  ThemeLocalDataSourceImpl({required this.preferences});
  final SharedPreferences preferences;

  @override
  Future<ThemeMode> getTheme() async {
    debugPrint('trigger get theme local source');
    final theme = preferences.getString(IS_DARK_MODE);
    if (theme?.compareTo(ThemeMode.dark.name) == 0) {
      return ThemeMode.dark;
    } else if (theme?.compareTo(ThemeMode.light.name) == 0) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  @override
  Future<void> setTheme(ThemeMode theme) {
    debugPrint('trigger set them local source: $theme');
    return preferences.setString(IS_DARK_MODE, theme.name);
  }


}