import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ThemeModeStorage {
  ThemeMode read();

  Future<void> write(ThemeMode mode);
}

class SharedPreferencesThemeModeStorage implements ThemeModeStorage {
  const SharedPreferencesThemeModeStorage(this._preferences);

  static Future<SharedPreferencesThemeModeStorage> create() async =>
      SharedPreferencesThemeModeStorage(
        await SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
            allowList: {AppKeys.themeModeKey},
          ),
        ),
      );

  final SharedPreferencesWithCache _preferences;

  @override
  ThemeMode read() =>
      ThemeMode.values.asNameMap()[_preferences.getString(
        AppKeys.themeModeKey,
      )] ??
      ThemeMode.system;

  @override
  Future<void> write(ThemeMode mode) =>
      _preferences.setString(AppKeys.themeModeKey, mode.name);
}
