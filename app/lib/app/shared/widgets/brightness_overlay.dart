import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

class BrightnessOverlay extends StatelessWidget {
  const BrightnessOverlay._({
    required this.child,
    required this.style,
    this.isAdaptive = false,
    super.key,
  });

  const BrightnessOverlay.dark({
    required Widget child,
    Key? key,
  }) : this._(
          key: key,
          child: child,
          style: SystemUiOverlayStyle.dark,
        );

  const BrightnessOverlay.light({
    required Widget child,
    Key? key,
  }) : this._(
          key: key,
          child: child,
          style: SystemUiOverlayStyle.light,
        );

  const BrightnessOverlay.adaptive({
    required Widget child,
    Key? key,
  }) : this._(
          key: key,
          child: child,
          style: SystemUiOverlayStyle.light,
          isAdaptive: true,
        );

  final Widget child;
  final SystemUiOverlayStyle style;
  final bool isAdaptive;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = !isAdaptive
        ? style
        : (context.theme.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);

    return AnnotatedRegion(
      value: effectiveStyle,
      child: child,
    );
  }
}
