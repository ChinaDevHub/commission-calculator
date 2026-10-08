import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:flutter/material.dart';

class TintedIconBadge extends StatelessWidget {
  const TintedIconBadge({
    required this.icon,
    required this.color,
    this.size = AppSizes.badge,
    this.iconSize = AppSizes.icon,
    super.key,
  });

  final IconData icon;
  final Color color;
  final double size;
  final double iconSize;

  static const _fillOpacity = 0.14;
  static const _borderOpacity = 0.28;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: _fillOpacity),
        border: Border.all(color: color.withValues(alpha: _borderOpacity)),
      ),
      child: Icon(icon, size: iconSize, color: color),
    );
  }
}
