import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/commission_fixtures.dart';

void main() {
  final eur = testRates.firstWhere((rate) => rate.currency == 'EUR');
  final usd = testRates.firstWhere((rate) => rate.currency == 'USD');
  final jpy = testRates.firstWhere((rate) => rate.currency == 'JPY');

  test('converts between the currency and EUR', () {
    expect(usd.toEur(d('1085.00')), d('1000'));
    expect(jpy.fromEur(d('200')), d('32480'));
  });

  test('keeps EUR conversions unrounded to the currency precision', () {
    expect(jpy.toEur(d('50000')), d('307.88177339901477832512'));
  });

  test('rounds up (ceiling) to the currency precision', () {
    expect(eur.roundUp(d('0.0003')), d('0.01'));
    expect(eur.roundUp(d('0.365')), d('0.37'));
    expect(jpy.roundUp(d('52.56')), d('53'));
  });

  test('keeps values already at the currency precision', () {
    expect(eur.roundUp(d('0.30')), d('0.30'));
    expect(jpy.roundUp(d('0')), d('0'));
  });
}
