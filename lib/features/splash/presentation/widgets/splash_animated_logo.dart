import 'package:commission_calculator/features/splash/presentation/widgets/pulse_rings.dart';
import 'package:commission_calculator/features/splash/presentation/widgets/splash_logo.dart';
import 'package:flutter/material.dart';

class SplashAnimatedLogo extends StatelessWidget {
  const SplashAnimatedLogo({
    required this.controller,
    this.size = 96.0,
    super.key,
  });

  final AnimationController controller;
  final double size;

  Animation<double> _createAnimation(
    double begin,
    double end, {
    double from = 0,
    Curve curve = Curves.easeOutCubic,
  }) {
    return controller.drive(
      Tween<double>(
        begin: from,
        end: 1,
      ).chain(CurveTween(curve: Interval(begin, end, curve: curve))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final opacity = _createAnimation(0, 0.4);
    final scale = _createAnimation(
      0,
      0.6,
      from: 0.8,
      curve: Curves.easeOutBack,
    );

    return SizedBox.square(
      dimension: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: PulseRings(animation: controller, innerRadius: size / 2 + 4),
          ),
          FadeTransition(
            opacity: opacity,
            child: ScaleTransition(
              scale: scale,
              child: SplashLogo(size: size),
            ),
          ),
        ],
      ),
    );
  }
}
