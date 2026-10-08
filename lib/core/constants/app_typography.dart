import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:flutter/painting.dart';

class AppTypography {
  AppTypography._();

  static const _tabular = [FontFeature.tabularFigures()];

  static const headline = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );

  static const title = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );

  static const body = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static const label = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const caption = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static const overline = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.6,
  );

  static const amountHero = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
    fontFeatures: _tabular,
  );

  static const amountLarge = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    fontFeatures: _tabular,
  );

  static const amount = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFeatures: _tabular,
  );

  static const amountSmall = TextStyle(
    fontFamily: AppKeys.fontName,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    fontFeatures: _tabular,
  );
}
