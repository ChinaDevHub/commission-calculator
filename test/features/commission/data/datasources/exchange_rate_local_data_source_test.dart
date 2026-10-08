import 'package:commission_calculator/features/commission/data/datasources/local/exchange/exchange_rate_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/commission_fixtures.dart';

void main() {
  test('returns the hardcoded rates and precisions from the task', () async {
    final models = await const ExchangeRateLocalDataSourceImpl()
        .getExchangeRates();

    expect([for (final model in models) model.toEntity()], testRates);
  });
}
