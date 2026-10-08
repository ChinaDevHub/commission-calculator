import 'package:commission_calculator/core/constants/app_dimens.dart';
import 'package:commission_calculator/core/theme/theme_toggle_button.dart';
import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({required this.title, super.key});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: const [
        ThemeToggleButton(),
        SizedBox(width: AppSpacing.xs),
      ],
    );
  }
}
