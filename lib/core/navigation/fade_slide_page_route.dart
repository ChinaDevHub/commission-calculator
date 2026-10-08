import 'package:flutter/material.dart';

class FadeSlidePageRoute<T> extends PageRouteBuilder<T> {
  FadeSlidePageRoute({required WidgetBuilder builder, super.settings})
    : super(
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, _, _) => builder(context),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: animation.drive(_curve),
          child: SlideTransition(
            position: animation.drive(_slide.chain(_curve)),
            child: child,
          ),
        ),
      );

  static final _curve = CurveTween(curve: Curves.easeOutCubic);
  static final _slide = Tween(begin: const Offset(0, 0.04), end: Offset.zero);
}
