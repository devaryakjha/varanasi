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
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade200,
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
