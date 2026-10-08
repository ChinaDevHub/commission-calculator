import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundGlow extends StatelessWidget {
  const BackgroundGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.12),
          radius: 0.75,
          colors: [
            AppColors.indigo.withValues(alpha: 0.32),
            AppColors.indigo.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}
