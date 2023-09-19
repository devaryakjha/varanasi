import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  // size
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;
  double get aspectRatio => size.aspectRatio;

  // padding
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  double get topPadding => padding.top;
  double get bottomPadding => padding.bottom;
  double get leftPadding => padding.left;
  double get rightPadding => padding.right;
}
