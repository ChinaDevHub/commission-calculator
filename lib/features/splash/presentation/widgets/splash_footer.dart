import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashFooter extends StatelessWidget {
  const SplashFooter({required this.controller, super.key});

  final AnimationController controller;

  Animation<double> get _opacity => controller.drive(
    Tween<double>(begin: 0, end: 1).chain(
      CurveTween(curve: const Interval(0.55, 0.9, curve: Curves.easeOutCubic)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final color = AppColors.silver.withValues(alpha: 0.55);

    return FadeTransition(
      opacity: _opacity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_rounded, size: 12, color: color),
          6.horizontalSpace,
          Text(
            AppKeys.splashFooterText,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.2,
            ),
          ),
        ],
      ),
    );
  }
}
