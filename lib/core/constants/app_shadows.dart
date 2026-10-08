import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:commission_calculator/core/constants/app_durations.dart';
import 'package:flutter/widgets.dart';

class AppShadows {
  AppShadows._();

  static const glow = [
    BoxShadow(
      color: AppColors.indigoGlow,
      blurRadius: 32,
      offset: Offset(0, 12),
    ),
  ];

  static const themeAnimation = AnimationStyle(
    duration: AppDurations.ms300,
    curve: Curves.easeInOut,
  );
}
