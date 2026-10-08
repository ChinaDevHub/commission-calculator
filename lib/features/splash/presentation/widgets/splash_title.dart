import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:flutter/material.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({required this.controller, super.key});

  final AnimationController controller;

  Animation<double> _createAnimation(
    double begin,
    double end, {
    double from = 0.0,
  }) {
    return controller.drive(
      Tween<double>(begin: from, end: 1).chain(
        CurveTween(curve: Interval(begin, end, curve: Curves.easeOutCubic)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final opacity = _createAnimation(0.25, 0.65);
    final scale = _createAnimation(0.25, 0.7, from: 0.92);

    return FadeTransition(
      opacity: opacity,
      child: ScaleTransition(
        scale: scale,
        child: const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: AppKeys.commissionText),
              TextSpan(
                text: AppKeys.calcText,
                style: TextStyle(color: AppColors.silver),
              ),
            ],
          ),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.6,
          ),
        ),
      ),
    );
  }
}
