import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/constants/app_typography.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  static final light = _build(Brightness.light, AppPalette.light);
  static final dark = _build(Brightness.dark, AppPalette.dark);

  static ThemeData _build(Brightness brightness, AppPalette palette) {
    return ThemeData(
      brightness: brightness,
      fontFamily: AppKeys.fontName,
      scaffoldBackgroundColor: palette.background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.indigo,
        onPrimary: AppColors.white,
        secondary: palette.accent,
        onSecondary: AppColors.white,
        error: palette.negative,
        onError: AppColors.white,
        surface: palette.background,
        onSurface: palette.textPrimary,
      ),
      extensions: [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.headline.copyWith(
          color: palette.textPrimary,
        ),
        systemOverlayStyle: brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      dividerColor: palette.divider,
      dividerTheme: DividerThemeData(
        color: palette.divider,
        thickness: AppSizes.border,
        space: AppSizes.border,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.indigo,
          foregroundColor: AppColors.white,
          textStyle: AppTypography.body,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
        ),
      ),
    );
  }
}
