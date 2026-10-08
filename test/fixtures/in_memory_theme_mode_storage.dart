import 'package:commission_calculator/core/theme/theme_mode_storage.dart';
import 'package:flutter/material.dart';

class InMemoryThemeModeStorage implements ThemeModeStorage {
  InMemoryThemeModeStorage([this.mode = ThemeMode.system]);

  ThemeMode mode;

  @override
  ThemeMode read() => mode;

  @override
  Future<void> write(ThemeMode mode) async => this.mode = mode;
}
