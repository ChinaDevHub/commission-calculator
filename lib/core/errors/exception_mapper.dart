import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/core/errors/failures.dart';

extension AppExceptionMapper on AppException {
  Failure toFailure() => switch (this) {
    InvalidInputException(:final message) => InvalidInputFailure(message),
    DataLoadException(:final message) => DataLoadFailure(message),
  };
}
