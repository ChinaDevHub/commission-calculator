import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_typography.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/tinted_icon_badge.dart';
import 'package:flutter/material.dart';

class StatusView extends StatelessWidget {
  const StatusView({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    this.action,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TintedIconBadge(
                icon: icon,
                color: color,
                size: AppSizes.statusBadge,
                iconSize: AppSizes.iconLg,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                title,
                style: AppTypography.title.copyWith(
                  color: context.palette.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                style: AppTypography.caption.copyWith(
                  color: context.palette.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              if (action case final action?) ...[
                const SizedBox(height: AppSpacing.xl),
                action,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
