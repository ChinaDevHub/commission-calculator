import 'package:commission_calculator/core/constants/app_icons.dart';
import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/extensions/enum_label_extensions.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:commission_calculator/features/commission/presentation/widgets/tinted_icon_badge.dart';
import 'package:flutter/material.dart';

class OperationTypeBadge extends StatelessWidget {
  const OperationTypeBadge({required this.type, super.key});

  final OperationType type;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final (icon, color) = switch (type) {
      OperationType.deposit => (AppIcons.deposit, palette.positive),
      OperationType.withdraw => (AppIcons.withdraw, palette.warning),
    };

    return Semantics(
      label: type.label,
      child: TintedIconBadge(icon: icon, color: color),
    );
  }
}
