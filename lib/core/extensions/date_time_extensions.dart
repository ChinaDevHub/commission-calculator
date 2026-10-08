import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  static final _displayFormat = DateFormat(AppKeys.displayDateFormat);

  String toDisplayDate() => _displayFormat.format(this);
}
