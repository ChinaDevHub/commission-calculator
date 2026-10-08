import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TransactionsLoadingView extends StatelessWidget {
  const TransactionsLoadingView({super.key});

  static const _placeholderTiles = 6;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Shimmer.fromColors(
      baseColor: palette.skeletonBase,
      highlightColor: palette.skeletonHighlight,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        children: [
          const _Bone(height: AppSizes.summaryCardHeight, radius: AppRadius.lg),
          const SizedBox(height: AppSpacing.xxl),
          for (var tile = 0; tile < _placeholderTiles; tile++) ...[
            const _Bone(height: AppSizes.tileHeight, radius: AppRadius.md),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _Bone extends StatelessWidget {
  const _Bone({required this.height, required this.radius});

  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: context.palette.skeletonBase,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
