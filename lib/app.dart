import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/constants/app_shadows.dart';
import 'package:commission_calculator/core/theme/app_theme.dart';
import 'package:commission_calculator/core/theme/theme_cubit.dart';
import 'package:commission_calculator/core/theme/theme_mode_storage.dart';
import 'package:commission_calculator/features/commission/presentation/pages/transactions_page.dart';
import 'package:commission_calculator/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({required this.themeModeStorage, super.key});

  final ThemeModeStorage themeModeStorage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(themeModeStorage),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppKeys.appTitle,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            themeAnimationStyle: AppShadows.themeAnimation,
            home: SplashPage(nextPageBuilder: (_) => const TransactionsPage()),
          ),
        ),
      ),
    );
  }
}
