import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/enums/commission_explanation.dart';
import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';

extension OperationTypeLabel on OperationType {
  String get label => switch (this) {
    OperationType.deposit => AppKeys.deposit,
    OperationType.withdraw => AppKeys.withdraw,
  };
}

extension UserTypeLabel on UserType {
  String get label => switch (this) {
    UserType.private => AppKeys.private,
    UserType.business => AppKeys.business,
  };
}

extension CommissionExplanationText on CommissionExplanation {
  String get description => switch (this) {
    CommissionExplanation.deposit => AppKeys.depositExplanation,
    CommissionExplanation.businessWithdraw =>
      AppKeys.businessWithdrawExplanation,
    CommissionExplanation.privateWithdrawFree =>
      AppKeys.privateWithdrawFreeExplanation,
    CommissionExplanation.privateWithdrawAllowanceExceeded =>
      AppKeys.allowanceExceededExplanation,
    CommissionExplanation.privateWithdrawAllowanceExhausted =>
      AppKeys.allowanceExhaustedExplanation,
    CommissionExplanation.privateWithdrawFreeCountExceeded =>
      AppKeys.freeCountExceededExplanation,
  };
}
