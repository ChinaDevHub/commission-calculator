import 'package:commission_calculator/app.dart';
import 'package:commission_calculator/core/di/locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(const MyApp());
}
