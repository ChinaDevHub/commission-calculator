import 'package:commission_calculator/core/constants/app_icons.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/status_view.dart';
import 'package:flutter/material.dart';

class TransactionsEmptyView extends StatelessWidget {
  const TransactionsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusView(
      icon: AppIcons.empty,
      color: context.palette.textSecondary,
      title: AppKeys.emptyTitle,
      message: AppKeys.emptyMessage,
    );
  }
}
