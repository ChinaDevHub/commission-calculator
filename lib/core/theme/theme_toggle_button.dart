import 'package:commission_calculator/core/constants/app_durations.dart';
import 'package:commission_calculator/core/constants/app_icons.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  static final _turns = Tween<double>(begin: 0.75, end: 1);

  @override
  Widget build(BuildContext context) {
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final isDark = context.select(
      (ThemeCubit cubit) =>
          cubit.state.resolve(platformBrightness) == Brightness.dark,
    );

    return IconButton(
      tooltip: isDark ? AppKeys.switchToLightTheme : AppKeys.switchToDarkTheme,
      onPressed: () => context.read<ThemeCubit>().toggle(platformBrightness),
      icon: AnimatedSwitcher(
        duration: AppDurations.ms300,
        transitionBuilder: (child, animation) => RotationTransition(
          turns: animation.drive(_turns),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          isDark ? AppIcons.lightMode : AppIcons.darkMode,
          key: ValueKey(isDark),
        ),
      ),
    );
  }
}
