import 'package:flutter/material.dart';

enum TriState { loaded, loading, error }

class TriStateVisibility extends StatelessWidget {
  final TriState state;
  final Widget child;
  final Widget loadingChild;
  final Widget errorChild;

  const TriStateVisibility({
    super.key,
    required this.child,
    this.state = TriState.loaded,
    this.loadingChild = const SizedBox.shrink(),
    this.errorChild = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) => switch (state) {
        TriState.loaded => child,
        TriState.loading => loadingChild,
        TriState.error => errorChild,
      };
}
