import 'dart:math';

import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PulseRings extends StatelessWidget {
  const PulseRings({
    required this.animation,
    required this.innerRadius,
    this.diameter = 260,
    this.ringCount = 3,
    this.pulses = 2,
    super.key,
  });

  final Animation<double> animation;
  final double innerRadius;
  final double diameter;
  final int ringCount;
  final int pulses;

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: CustomPaint(
      size: Size.square(diameter),
      painter: _PulseRingsPainter(
        animation,
        innerRadius: innerRadius,
        ringCount: ringCount,
        pulses: pulses,
      ),
    ),
  );
}

class _PulseRingsPainter extends CustomPainter {
  _PulseRingsPainter(
    this.animation, {
    required this.innerRadius,
    required this.ringCount,
    required this.pulses,
  }) : super(repaint: animation);

  static const _colors = [
    AppColors.silver,
    AppColors.sky,
    AppColors.indigoLight,
    AppColors.silver,
  ];
  static const _maxOpacity = 0.6;
  static const _fadeInPortion = 0.2;

  final Animation<double> animation;
  final double innerRadius;
  final int ringCount;
  final int pulses;

  @override
  void paint(Canvas canvas, Size size) {
    final progress = animation.value;
    final fadeIn = Curves.easeOut.transform(
      (progress / _fadeInPortion).clamp(0.0, 1.0),
    );
    final bounds = Offset.zero & size;
    final outerRadius = size.shortestSide / 2;

    for (var ring = 0; ring < ringCount; ring++) {
      final phase = (progress * pulses + ring / ringCount) % 1;
      final spread = Curves.easeOutCubic.transform(phase);
      final fadeOut = (1 - phase) * (1 - phase);
      final opacity = _maxOpacity * fadeIn * fadeOut;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2 - 1.6 * phase
        ..shader = SweepGradient(
          colors: [
            for (final color in _colors) color.withValues(alpha: opacity),
          ],
          transform: GradientRotation(progress * 2 * pi),
        ).createShader(bounds);

      canvas.drawCircle(
        bounds.center,
        innerRadius + (outerRadius - innerRadius) * spread,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_PulseRingsPainter oldDelegate) =>
      oldDelegate.animation != animation ||
      oldDelegate.innerRadius != innerRadius ||
      oldDelegate.ringCount != ringCount ||
      oldDelegate.pulses != pulses;
}
