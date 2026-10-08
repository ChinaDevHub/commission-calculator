import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/app_top_bar.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/calculation_breakdown_card.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/section_label.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transaction_overview_card.dart';
import 'package:flutter/material.dart';

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage({required this.result, super.key});

  final CommissionResult result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: AppKeys.detailsTitle),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            TransactionOverviewCard(result: result),
            const SizedBox(height: AppSpacing.xxl),
            const SectionLabel(AppKeys.breakdown),
            const SizedBox(height: AppSpacing.md),
            CalculationBreakdownCard(result: result),
          ],
        ),
      ),
    );
  }
}
