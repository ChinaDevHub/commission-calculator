import 'package:decimal/decimal.dart';

class CommissionConfig {
  const CommissionConfig({
    required this.depositRate,
    required this.privateWithdrawRate,
    required this.businessWithdrawRate,
    required this.weeklyFreeAllowanceEur,
    required this.weeklyFreeWithdrawals,
  });

  final Decimal depositRate;
  final Decimal privateWithdrawRate;
  final Decimal businessWithdrawRate;
  final Decimal weeklyFreeAllowanceEur;
  final int weeklyFreeWithdrawals;

  factory CommissionConfig.standard() => CommissionConfig(
    depositRate: Decimal.parse('0.0003'),
    privateWithdrawRate: Decimal.parse('0.003'),
    businessWithdrawRate: Decimal.parse('0.005'),
    weeklyFreeAllowanceEur: Decimal.parse('1000.00'),
    weeklyFreeWithdrawals: 3,
  );
}
