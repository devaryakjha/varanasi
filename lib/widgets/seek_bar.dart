import 'dart:math';

import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Color? color;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    super.key,
    required this.duration,
    required this.position,
    this.color,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    final value = min(
      _dragValue ?? widget.position.inMilliseconds.toDouble(),
      widget.duration.inMilliseconds.toDouble(),
    );
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Slider(
          activeColor: widget.color ?? context.colorScheme.primary,
          inactiveColor: widget.color?.withOpacity(0.25) ??
              context.colorScheme.primary.withOpacity(0.25),
          max: widget.duration.inMilliseconds.toDouble(),
          value: value,
          onChangeStart: (value) {
            _dragging = true;
          },
          onChanged: (value) {
            setState(() => _dragValue = value);
            widget.onChanged?.call(Duration(milliseconds: value.round()));
          },
          onChangeEnd: (value) {
            widget.onChangeEnd?.call(Duration(milliseconds: value.round()));
            _dragging = false;
          },
        ),
        Positioned(
          right: 24.0,
          bottom: -8.0,
          left: 24.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                        .firstMatch("${widget.position}")
                        ?.group(1) ??
                    '$_remaining',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: widget.color),
              ),
              Text(
                '-${RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch("$_remaining")?.group(1) ?? '$_remaining'}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: widget.color),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}
