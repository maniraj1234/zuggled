import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransitionPage extends CustomTransitionPage {
  final GoRouterState state;
  TransitionPage({required super.child, required this.state})
    : super(
        key: state.pageKey,
        transitionDuration: Durations.short4,
        reverseTransitionDuration: Durations.short1,
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) =>
                FadeThroughTransition(
                  secondaryAnimation: secondaryAnimation,
                  animation: animation,
                  child: child,
                ),
      );
}
