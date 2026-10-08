import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_total.dart';
import 'package:commission_calculator/features/commission/presentation/pages/transaction_details_page.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/section_label.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transaction_item_tile.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transactions_summary_card.dart';
import 'package:flutter/material.dart';

class TransactionsContent extends StatelessWidget {
  const TransactionsContent({
    required this.results,
    required this.totals,
    super.key,
  });

  final List<CommissionResult> results;
  final List<CommissionTotal> totals;

  void _openDetails(BuildContext context, CommissionResult result) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TransactionDetailsPage(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          sliver: SliverList.list(
            children: [
              TransactionsSummaryCard(totals: totals),
              const SizedBox(height: AppSpacing.xxl),
              const SectionLabel(AppKeys.activity),
            ],
          ),
        ),
        SliverSafeArea(
          top: false,
          minimum: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          sliver: SliverList.separated(
            itemCount: results.length,
            itemBuilder: (context, index) => TransactionItemTile(
              result: results[index],
              onTap: () => _openDetails(context, results[index]),
            ),
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
          ),
        ),
      ],
    );
  }
}
