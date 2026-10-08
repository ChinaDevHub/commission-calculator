import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/constants/app_typography.dart';
import 'package:commission_calculator/core/extensions/decimal_extensions.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/surface_card.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transaction_title.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class TransactionItemTile extends StatelessWidget {
  const TransactionItemTile({
    required this.result,
    required this.onTap,
    super.key,
  });

  final CommissionResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final precision = result.exchangeRate.precision;
    final currency = result.currency;
    final isFree = result.commission == Decimal.zero;
    final palette = context.palette;

    return SurfaceCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(child: TransactionTitle(transaction: result.transaction)),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${result.transaction.amount.toMoney(precision)} $currency',
                style: AppTypography.amount,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                '${AppKeys.fee} ${result.commission.toMoney(precision)} '
                '$currency',
                style: AppTypography.amountSmall.copyWith(
                  color: isFree ? palette.positive : palette.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
