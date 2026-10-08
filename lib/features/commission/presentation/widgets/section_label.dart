import 'package:commission_calculator/core/constants/app_typography.dart';
import 'package:commission_calculator/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Text(
        text,
        style: AppTypography.overline.copyWith(
          color: context.palette.textSecondary,
        ),
      ),
    );
  }
}
