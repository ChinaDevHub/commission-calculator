import 'package:commission_calculator/core/theme/theme_mode_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._storage) : super(_storage.read());

  final ThemeModeStorage _storage;

  /// Switches to the opposite of the theme currently on screen. The new mode
  /// is emitted first and persisted afterwards, so the UI never waits on disk.
  Future<void> toggle(Brightness platformBrightness) {
    final next = state.resolve(platformBrightness) == Brightness.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(next);
    return _storage.write(next);
  }
}

extension ThemeModeBrightness on ThemeMode {
  Brightness resolve(Brightness platformBrightness) => switch (this) {
    ThemeMode.system => platformBrightness,
    ThemeMode.light => Brightness.light,
    ThemeMode.dark => Brightness.dark,
  };
}
