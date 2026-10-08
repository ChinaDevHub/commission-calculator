import 'package:commission_calculator/app.dart';
import 'package:commission_calculator/core/di/locator.dart';
import 'package:commission_calculator/core/theme/theme_mode_storage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeModeStorage = await SharedPreferencesThemeModeStorage.create();
  setupLocator();
  runApp(MyApp(themeModeStorage: themeModeStorage));
}
