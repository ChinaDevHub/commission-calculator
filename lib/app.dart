import 'package:commission_calculator/features/commission/presentation/pages/transactions_page.dart';
import 'package:commission_calculator/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: SplashPage(nextPageBuilder: (_) => const TransactionsPage()),
    );
  }
}
