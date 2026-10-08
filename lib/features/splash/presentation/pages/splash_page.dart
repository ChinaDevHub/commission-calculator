import 'package:commission_calculator/core/constants/app_durations.dart';
import 'package:commission_calculator/core/navigation/fade_slide_page_route.dart';
import 'package:commission_calculator/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({required this.nextPageBuilder, super.key});

  static const duration = AppDurations.ms1900;
  final WidgetBuilder nextPageBuilder;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SplashPage.duration,
  );

  @override
  void initState() {
    super.initState();
    _playIntro();
  }

  Future<void> _playIntro() async {
    await _controller.forward();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      FadeSlidePageRoute<void>(builder: widget.nextPageBuilder),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashBody(controller: _controller));
  }
}
