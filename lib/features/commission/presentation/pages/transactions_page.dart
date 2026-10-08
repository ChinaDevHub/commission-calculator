import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/di/locator.dart';
import 'package:commission_calculator/features/commission/presentation/cubits/transactions_cubit.dart';
import 'package:commission_calculator/features/commission/presentation/cubits/transactions_state.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/app_top_bar.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transactions_content.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transactions_empty_view.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transactions_error_view.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/transactions_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<TransactionsCubit>()..load(),
      child: Scaffold(
        appBar: const AppTopBar(title: AppKeys.transactionsTitle),
        body: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) => switch (state) {
            TransactionsInitial() ||
            TransactionsLoading() => const TransactionsLoadingView(),
            TransactionsEmpty() => const TransactionsEmptyView(),
            TransactionsError(:final message) => TransactionsErrorView(
              message: message,
              onRetry: context.read<TransactionsCubit>().load,
            ),
            TransactionsSuccess(:final results, :final totals) =>
              TransactionsContent(results: results, totals: totals),
          },
        ),
      ),
    );
  }
}
