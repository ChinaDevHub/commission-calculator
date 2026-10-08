import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:flutter/painting.dart';

class AppGradients {
  AppGradients._();

  static const card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.indigoLight, AppColors.indigo, AppColors.indigoDeep],
  );

  static const cardSheen = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.center,
    colors: [Color(0x33FFFFFF), AppColors.transparent],
  );
}
