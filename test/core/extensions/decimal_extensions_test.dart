import 'package:commission_calculator/core/extensions/decimal_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/commission_fixtures.dart';

void main() {
  test('toMoney groups thousands and pads to the minimum decimals', () {
    expect(d('50000').toMoney(0), '50,000');
    expect(d('1000').toMoney(2), '1,000.00');
    expect(d('0.3').toMoney(2), '0.30');
    expect(d('1234567.891').toMoney(2), '1,234,567.891');
  });

  test('toApprox marks values that had to be rounded', () {
    expect(
      d(
        '307.88177339901477832512',
      ).toApprox(minFractionDigits: 2, maxFractionDigits: 2),
      '≈ 307.88',
    );
    expect(
      d('52.56').toApprox(minFractionDigits: 0, maxFractionDigits: 6),
      '52.56',
    );
    expect(
      d('0.06').toApprox(minFractionDigits: 2, maxFractionDigits: 6),
      '0.06',
    );
  });

  test('toPercent renders the rate as a percentage', () {
    expect(d('0.0003').toPercent(), '0.03%');
    expect(d('0.003').toPercent(), '0.3%');
    expect(d('0.005').toPercent(), '0.5%');
  });
}
