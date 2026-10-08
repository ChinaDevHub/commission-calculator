import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/constants/app_typography.dart';
import 'package:commission_calculator/core/extensions/date_time_extensions.dart';
import 'package:commission_calculator/core/extensions/enum_label_extensions.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/operation_type_badge.dart';
import 'package:flutter/material.dart';

class TransactionTitle extends StatelessWidget {
  const TransactionTitle({required this.transaction, super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OperationTypeBadge(type: transaction.operationType),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                [
                  transaction.operationType.label,
                  transaction.userType.label,
                ].join(AppKeys.separator),
                style: AppTypography.body,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                [
                  '${AppKeys.userPrefix}${transaction.userId}',
                  transaction.date.toDisplayDate(),
                ].join(AppKeys.separator),
                style: AppTypography.caption.copyWith(
                  color: context.palette.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
