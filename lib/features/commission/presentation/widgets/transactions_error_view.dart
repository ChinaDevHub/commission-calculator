import 'package:commission_calculator/core/constants/app_icons.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/status_view.dart';
import 'package:flutter/material.dart';

class TransactionsErrorView extends StatelessWidget {
  const TransactionsErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return StatusView(
      icon: AppIcons.error,
      color: context.palette.negative,
      title: AppKeys.errorTitle,
      message: message,
      action: FilledButton(
        onPressed: onRetry,
        child: const Text(AppKeys.retry),
      ),
    );
  }
}
