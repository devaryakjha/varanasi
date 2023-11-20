import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage<void> {
  const FadeTransitionPage({
    super.key,
    required super.child,
    super.transitionDuration = const Duration(milliseconds: 300),
  }) : super(transitionsBuilder: _transitionBuilder);

  static Widget _transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);
}

class PageWithBottomSheet extends CustomTransitionPage<void> {
  const PageWithBottomSheet({
    super.key,
    required super.child,
    super.transitionDuration = const Duration(milliseconds: 300),
  }) : super(transitionsBuilder: _transitionBuilder);

  static Widget _transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
