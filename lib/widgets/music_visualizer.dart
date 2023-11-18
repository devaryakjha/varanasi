import "package:flutter/material.dart";
import "package:varanasi_mobile_app/utils/extensions/theme.dart";

const List<int> duration = [900, 800, 700, 600, 500];

class MiniMusicVisualizer extends StatelessWidget {
  const MiniMusicVisualizer({
    super.key,
    this.color,
    this.width,
    this.height,
    this.animating = true,
    this.numberOfBars = 3,
  });

  /// Color of bars
  final Color? color;

  /// width of visualizer widget
  final double? width;

  /// height of visualizer widget
  final double? height;

  /// is visualizer animating
  final bool animating;

  final int numberOfBars;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        numberOfBars,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: VisualComponent(
            key: ValueKey(index),
            curve: Curves.bounceOut,
            duration: duration[index % 5],
            color: color ?? context.colorScheme.secondary,
            width: width,
            height: height,
            animating: animating,
          ),
        ),
      ),
    );
  }
}

class VisualComponent extends StatefulWidget {
  const VisualComponent({
    super.key,
    required this.duration,
    required this.color,
    required this.curve,
    this.width,
    this.height,
    required this.animating,
  });

  final int duration;
  final Color color;
  final Curve curve;
  final double? width;
  final double? height;
  final bool animating;

  @override
  VisualComponentState createState() => VisualComponentState();
}

class VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    width = widget.width ?? 4;
    height = widget.height ?? 15;
    animate();
    _handleAnimationChange(widget.animating);
  }

  _handleAnimationChange(bool animating) {
    if (animating) {
      animationController.repeat(reverse: true);
    } else {
      animationController.reset();
      animationController.stop();
    }
  }

  @override
  void didUpdateWidget(covariant VisualComponent oldWidget) {
    _handleAnimationChange(widget.animating);
    super.didUpdateWidget(oldWidget);
  }

  void animate() {
    animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: widget.curve);
    animation = Tween<double>(begin: 2, end: height).animate(curvedAnimation)
      ..addListener(() => update());
  }

  void update() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: animation.value,
          decoration: BoxDecoration(
            color: widget.color,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.animating) {
      animation.removeListener(() {});
      animation.removeStatusListener((status) {});
      animationController.stop();
      animationController.reset();
      animationController.dispose();
    }
    super.dispose();
  }
}
