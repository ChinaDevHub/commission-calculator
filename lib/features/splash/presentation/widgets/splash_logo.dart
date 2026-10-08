import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({this.size = 96, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedSuperellipseBorder(
      borderRadius: BorderRadius.circular(size * 0.3),
      side: BorderSide(color: AppColors.white.withValues(alpha: 0.18)),
    );

    return Semantics(
      label: AppKeys.splashLogoLabel,
      child: SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            shape: shape,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.indigoLight,
                AppColors.indigo,
                AppColors.indigoDeep,
              ],
            ),
            shadows: [
              BoxShadow(
                color: AppColors.indigo.withValues(alpha: 0.55),
                blurRadius: size * 0.4,
                offset: Offset(0, size * 0.14),
              ),
            ],
          ),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: shape,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.center,
                colors: [
                  AppColors.white.withValues(alpha: 0.24),
                  AppColors.white.withValues(alpha: 0),
                ],
              ),
            ),
            child: Center(
              child: Text(
                '%',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: size * 0.46,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  shadows: [
                    Shadow(
                      color: AppColors.indigoDeep.withValues(alpha: 0.6),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
