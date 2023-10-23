import 'package:flutter/material.dart';

class DisableChild extends StatelessWidget {
  const DisableChild({
    super.key,
    this.disabled = true,
    required this.child,
  });
  final bool disabled;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Opacity(
        opacity: disabled ? 0.5 : 1,
        child: child,
      ),
    );
  }
}
