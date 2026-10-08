import 'package:commission_calculator/features/commission/commission_locator.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  setupCommissionLocator();
}
