import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_icons.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/constants/app_typography.dart';
import 'package:commission_calculator/core/extensions/decimal_extensions.dart';
import 'package:commission_calculator/core/extensions/enum_label_extensions.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/section_label.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/surface_card.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transaction_title.dart';
import 'package:flutter/material.dart';

class TransactionOverviewCard extends StatelessWidget {
  const TransactionOverviewCard({required this.result, super.key});

  final CommissionResult result;

  @override
  Widget build(BuildContext context) {
    final precision = result.exchangeRate.precision;
    final currency = result.currency;
    final secondary = context.palette.textSecondary;
    final caption = AppTypography.caption.copyWith(color: secondary);

    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TransactionTitle(transaction: result.transaction),
          const SizedBox(height: AppSpacing.xl),
          SectionLabel(AppKeys.commission.toUpperCase()),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${result.commission.toMoney(precision)} $currency',
            style: AppTypography.amountHero,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            '${AppKeys.onAmount}'
            '${result.transaction.amount.toMoney(precision)} $currency',
            style: caption,
          ),
          const SizedBox(height: AppSpacing.lg),
          const Divider(),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(AppIcons.info, size: AppSizes.iconSm, color: secondary),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(result.explanation.description, style: caption),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
