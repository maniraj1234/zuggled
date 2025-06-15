import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A Custom built TransitionPage to be used in GoRouter as pageBuilder
/// for custom transition animation.
class TransitionPage extends CustomTransitionPage {
  final GoRouterState state;
  TransitionPage({required super.child, required this.state})
    : super(
        key: state.pageKey,
        transitionDuration: Durations.medium3,
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
