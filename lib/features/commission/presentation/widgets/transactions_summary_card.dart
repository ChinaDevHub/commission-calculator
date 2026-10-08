import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_gradients.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/constants/app_shadows.dart';
import 'package:commission_calculator/core/constants/app_typography.dart';
import 'package:commission_calculator/core/extensions/decimal_extensions.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_total.dart';
import 'package:flutter/material.dart';

class TransactionsSummaryCard extends StatelessWidget {
  const TransactionsSummaryCard({required this.totals, super.key});

  final List<CommissionTotal> totals;

  static const _radius = BorderRadius.all(Radius.circular(AppRadius.lg));
  static const _columns = 2;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppGradients.card,
        borderRadius: _radius,
        boxShadow: AppShadows.glow,
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppGradients.cardSheen,
          borderRadius: _radius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppKeys.totalCommission,
                style: AppTypography.overline.copyWith(
                  color: AppColors.whiteMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth =
                      (constraints.maxWidth - AppSpacing.lg * (_columns - 1)) /
                      _columns;
                  return Wrap(
                    spacing: AppSpacing.lg,
                    runSpacing: AppSpacing.lg,
                    children: [
                      for (final total in totals)
                        SizedBox(
                          width: itemWidth,
                          child: _CurrencyTotal(total),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencyTotal extends StatelessWidget {
  const _CurrencyTotal(this.total);

  final CommissionTotal total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          total.currency,
          style: AppTypography.overline.copyWith(color: AppColors.whiteMuted),
        ),
        const SizedBox(height: AppSpacing.xs),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            total.amount.toMoney(total.precision),
            style: AppTypography.amountLarge.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
