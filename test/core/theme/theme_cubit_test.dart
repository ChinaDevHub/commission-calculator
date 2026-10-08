import 'package:commission_calculator/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/in_memory_theme_mode_storage.dart';

void main() {
  test('starts with the stored mode', () {
    final cubit = ThemeCubit(InMemoryThemeModeStorage(ThemeMode.dark));
    addTearDown(cubit.close);

    expect(cubit.state, ThemeMode.dark);
  });

  test('toggles away from the system brightness and persists it', () async {
    final storage = InMemoryThemeModeStorage();
    final cubit = ThemeCubit(storage);
    addTearDown(cubit.close);

    await cubit.toggle(Brightness.dark);

    expect(cubit.state, ThemeMode.light);
    expect(storage.mode, ThemeMode.light);
  });

  test('an explicit mode wins over the system brightness', () async {
    final cubit = ThemeCubit(InMemoryThemeModeStorage(ThemeMode.light));
    addTearDown(cubit.close);

    await cubit.toggle(Brightness.light);
    expect(cubit.state, ThemeMode.dark);

    await cubit.toggle(Brightness.light);
    expect(cubit.state, ThemeMode.light);
  });

  test('resolves each mode against the platform brightness', () {
    expect(ThemeMode.system.resolve(Brightness.dark), Brightness.dark);
    expect(ThemeMode.light.resolve(Brightness.dark), Brightness.light);
    expect(ThemeMode.dark.resolve(Brightness.light), Brightness.dark);
  });
}
