import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Semantic colors that change with the theme. Interpolated by [lerp], so a
/// theme switch animates instead of jumping.
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.border,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.positive,
    required this.warning,
    required this.negative,
    required this.skeletonBase,
    required this.skeletonHighlight,
  });

  static const dark = AppPalette(
    background: AppColors.midnight,
    surface: AppColors.cardFill,
    border: AppColors.cardBorder,
    divider: AppColors.divider,
    textPrimary: AppColors.white,
    textSecondary: AppColors.silverMuted,
    accent: AppColors.sky,
    positive: AppColors.mint,
    warning: AppColors.amber,
    negative: AppColors.rose,
    skeletonBase: AppColors.skeletonBase,
    skeletonHighlight: AppColors.skeletonHighlight,
  );

  static const light = AppPalette(
    background: AppColors.cloud,
    surface: AppColors.white,
    border: AppColors.mist,
    divider: AppColors.haze,
    textPrimary: AppColors.navy,
    textSecondary: AppColors.slate,
    accent: AppColors.indigo,
    positive: AppColors.emerald,
    warning: AppColors.amberDeep,
    negative: AppColors.roseDeep,
    skeletonBase: AppColors.skeletonLightBase,
    skeletonHighlight: AppColors.skeletonLightHighlight,
  );

  final Color background;
  final Color surface;
  final Color border;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color positive;
  final Color warning;
  final Color negative;
  final Color skeletonBase;
  final Color skeletonHighlight;

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? border,
    Color? divider,
    Color? textPrimary,
    Color? textSecondary,
    Color? accent,
    Color? positive,
    Color? warning,
    Color? negative,
    Color? skeletonBase,
    Color? skeletonHighlight,
  }) => AppPalette(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    border: border ?? this.border,
    divider: divider ?? this.divider,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    accent: accent ?? this.accent,
    positive: positive ?? this.positive,
    warning: warning ?? this.warning,
    negative: negative ?? this.negative,
    skeletonBase: skeletonBase ?? this.skeletonBase,
    skeletonHighlight: skeletonHighlight ?? this.skeletonHighlight,
  );

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      background: mix(background, other.background),
      surface: mix(surface, other.surface),
      border: mix(border, other.border),
      divider: mix(divider, other.divider),
      textPrimary: mix(textPrimary, other.textPrimary),
      textSecondary: mix(textSecondary, other.textSecondary),
      accent: mix(accent, other.accent),
      positive: mix(positive, other.positive),
      warning: mix(warning, other.warning),
      negative: mix(negative, other.negative),
      skeletonBase: mix(skeletonBase, other.skeletonBase),
      skeletonHighlight: mix(skeletonHighlight, other.skeletonHighlight),
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
