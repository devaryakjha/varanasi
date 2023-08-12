import 'dart:ui';

import 'package:varanasi_mobile_app/utils/color.dart';

extension ColorExtension on Color {
  // Darken a color by a given amount, on a scale of 0.0 to 1.0.
  Color get dark => darken(this, 0.1);
  Color get dark200 => darken(this, 0.2);
  Color get dark300 => darken(this, 0.3);
  Color get dark400 => darken(this, 0.4);
  Color get dark500 => darken(this, 0.5);
  Color get dark600 => darken(this, 0.6);
  Color get dark700 => darken(this, 0.7);
  Color get dark800 => darken(this, 0.8);
  Color get dark900 => darken(this, 0.9);
  Color get dark1000 => darken(this, 1.0);

  // Lighten a color by a given amount, on a scale of 0.0 to 1.0.
  Color get light => lighten(this, 0.1);
  Color get light200 => lighten(this, 0.2);
  Color get light300 => lighten(this, 0.3);
  Color get light400 => lighten(this, 0.4);
  Color get light500 => lighten(this, 0.5);
  Color get light600 => lighten(this, 0.6);
  Color get light700 => lighten(this, 0.7);
  Color get light800 => lighten(this, 0.8);
  Color get light900 => lighten(this, 0.9);
  Color get light1000 => lighten(this, 1.0);
}
