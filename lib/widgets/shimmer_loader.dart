import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final double? height, width;
  final EdgeInsets? margin;
  final Widget? child;
  final BoxDecoration decoration;

  const ShimmerLoader({
    super.key,
    this.child,
    this.height,
    this.width,
    this.margin,
    this.decoration = const BoxDecoration(),
  });

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xff252525);
    const highlightColor = Color(0xff555555);
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 2000),
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: decoration.copyWith(color: Colors.white),
        child: child,
      ),
    );
  }
}
