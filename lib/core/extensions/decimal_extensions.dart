import 'dart:math';

import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:decimal/decimal.dart';

extension DecimalFormatting on Decimal {
  static final _thousands = RegExp(r'(\d)(?=(\d{3})+$)');
  static final _hundred = Decimal.fromInt(100);

  /// The exact value with at least [minFractionDigits] decimals and thousands
  /// separators: 50000 → 50,000 · 1000 → 1,000.00.
  String toMoney(int minFractionDigits) {
    final fixed = toStringAsFixed(max(minFractionDigits, scale));
    final [whole, ...fraction] = fixed.split('.');
    final grouped = whole.replaceAllMapped(
      _thousands,
      (match) => '${match[1]},',
    );
    return [grouped, ...fraction].join('.');
  }

  /// Rounded to at most [maxFractionDigits] decimals for display, prefixed
  /// with ≈ when rounding changed the value.
  String toApprox({
    required int minFractionDigits,
    required int maxFractionDigits,
  }) {
    final rounded = round(scale: maxFractionDigits);
    final text = rounded.toMoney(minFractionDigits);
    return rounded == this ? text : '${AppKeys.approximately}$text';
  }

  String toPercent() => '${this * _hundred}%';
}
