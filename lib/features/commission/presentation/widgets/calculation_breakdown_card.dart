import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/constants/app_typography.dart';
import 'package:commission_calculator/core/extensions/decimal_extensions.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/surface_card.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class CalculationBreakdownCard extends StatelessWidget {
  const CalculationBreakdownCard({required this.result, super.key});

  final CommissionResult result;

  static const _eurFractionDigits = 2;
  static const _rawFractionDigits = 6;

  String _money(Decimal value, {int? maxFractionDigits}) {
    final precision = result.exchangeRate.precision;
    final amount = value.toApprox(
      minFractionDigits: precision,
      maxFractionDigits: maxFractionDigits ?? precision,
    );
    return '$amount ${result.currency}';
  }

  String _eur(Decimal value) {
    final amount = value.toApprox(
      minFractionDigits: _eurFractionDigits,
      maxFractionDigits: _eurFractionDigits,
    );
    return '$amount ${AppKeys.eur}';
  }

  @override
  Widget build(BuildContext context) {
    final allowanceLeft = result.allowanceLeftEur;
    final isEur = result.currency == AppKeys.eur;

    final rows = [
      _BreakdownRow(AppKeys.amount, _money(result.transaction.amount)),
      if (!isEur)
        _BreakdownRow(
          AppKeys.exchangeRate,
          '${AppKeys.oneEurEquals}${result.exchangeRate.rateToEur} '
          '${result.currency}',
        ),
      _BreakdownRow(AppKeys.eurEquivalent, _eur(result.amountInEur)),
      if (allowanceLeft != null) ...[
        _BreakdownRow(
          AppKeys.freeAllowanceApplied,
          _money(result.freeAmount),
          caption: isEur ? null : _eur(result.freeAmountInEur),
        ),
        _BreakdownRow(AppKeys.weeklyAllowanceLeft, _eur(allowanceLeft)),
      ],
      _BreakdownRow(AppKeys.chargedAmount, _money(result.chargedAmount)),
      _BreakdownRow(AppKeys.commissionRate, result.feeRate.toPercent()),
      _BreakdownRow(
        AppKeys.rawCommission,
        _money(result.rawCommission, maxFractionDigits: _rawFractionDigits),
      ),
      _BreakdownRow(
        AppKeys.roundedCommission,
        _money(result.commission),
        highlighted: true,
      ),
    ];

    return SurfaceCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: ListTile.divideTiles(context: context, tiles: rows).toList(),
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow(
    this.label,
    this.value, {
    this.caption,
    this.highlighted = false,
  });

  final String label;
  final String value;
  final String? caption;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: highlighted
                  ? AppTypography.body
                  : AppTypography.label.copyWith(color: palette.textSecondary),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  textAlign: TextAlign.end,
                  style: highlighted
                      ? AppTypography.amount.copyWith(color: palette.accent)
                      : AppTypography.amount,
                ),
                if (caption case final caption?)
                  Text(
                    caption,
                    textAlign: TextAlign.end,
                    style: AppTypography.amountSmall.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
