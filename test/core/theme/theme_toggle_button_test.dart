import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/core/theme/app_theme.dart';
import 'package:commission_calculator/core/theme/theme_cubit.dart';
import 'package:commission_calculator/core/theme/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/in_memory_theme_mode_storage.dart';

void main() {
  testWidgets('switches the whole app between light and dark', (tester) async {
    final storage = InMemoryThemeModeStorage(ThemeMode.light);
    late BuildContext pageContext;

    await tester.pumpWidget(
      BlocProvider(
        create: (_) => ThemeCubit(storage),
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            home: Builder(
              builder: (context) {
                pageContext = context;
                return Scaffold(
                  appBar: AppBar(actions: const [ThemeToggleButton()]),
                );
              },
            ),
          ),
        ),
      ),
    );

    expect(Theme.of(pageContext).brightness, Brightness.light);
    expect(find.byTooltip('Switch to dark theme'), findsOneWidget);

    await tester.tap(find.byType(ThemeToggleButton));
    await tester.pumpAndSettle();

    expect(Theme.of(pageContext).brightness, Brightness.dark);
    expect(pageContext.palette, AppPalette.dark);
    expect(find.byTooltip('Switch to light theme'), findsOneWidget);
    expect(storage.mode, ThemeMode.dark);
  });

  test('palette interpolates between the themes', () {
    final halfway = AppPalette.light.lerp(AppPalette.dark, 0.5);

    expect(
      halfway.background,
      Color.lerp(AppPalette.light.background, AppPalette.dark.background, 0.5),
    );
  });
}
