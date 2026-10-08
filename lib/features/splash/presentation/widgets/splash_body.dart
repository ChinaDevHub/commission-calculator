import 'package:commission_calculator/core/constants/app_colors.dart';
import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/features/splash/presentation/widgets/background_glow.dart';
import 'package:commission_calculator/features/splash/presentation/widgets/splash_animated_logo.dart';
import 'package:commission_calculator/features/splash/presentation/widgets/splash_footer.dart';
import 'package:commission_calculator/features/splash/presentation/widgets/splash_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({required this.controller, super.key});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.navyLight, AppColors.navy, AppColors.midnight],
            stops: [0, 0.55, 1],
          ),
        ),
        child: DefaultTextStyle.merge(
          style: const TextStyle(
            fontFamily: AppKeys.fontName,
            color: AppColors.white,
          ),
          child: Stack(
            children: [
              const Positioned.fill(child: BackgroundGlow()),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SplashAnimatedLogo(controller: controller),
                    40.verticalSpace,
                    SplashTitle(controller: controller),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  minimum: const EdgeInsets.only(bottom: 28),
                  child: SplashFooter(controller: controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
