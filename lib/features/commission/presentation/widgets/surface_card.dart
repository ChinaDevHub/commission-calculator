import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  static const _radius = BorderRadius.all(Radius.circular(AppRadius.md));

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Material(
      // Track the theme animation frame by frame. Material's own implicit
      // animation would otherwise chase it and leave the border and the
      // default text colour lagging behind the background.
      animationDuration: Duration.zero,
      color: palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: _radius,
        side: BorderSide(color: palette.border, width: AppSizes.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
