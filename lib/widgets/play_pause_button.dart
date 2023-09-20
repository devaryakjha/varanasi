import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlayPauseMediaButton extends StatefulHookWidget {
  const PlayPauseMediaButton({
    super.key,
    required this.onPressed,
    this.isPlaying = false,
    this.backgroundColor,
    this.foregroundColor,
  });
  final VoidCallback onPressed;
  final bool isPlaying;
  final Color? backgroundColor, foregroundColor;

  @override
  State<PlayPauseMediaButton> createState() => _PlayPauseMediaButtonState();
}

class _PlayPauseMediaButtonState extends State<PlayPauseMediaButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.isPlaying ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(covariant PlayPauseMediaButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPlaying != widget.isPlaying) {
      if (widget.isPlaying) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      onPressed: widget.onPressed,
      shape: const CircleBorder(),
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: _controller,
      ),
    );
  }
}
