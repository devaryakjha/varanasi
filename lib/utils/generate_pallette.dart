import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<PaletteGenerator?> generateColorPalette(
    {String? imageUrl, Size? size, ImageProvider? imageProvider}) async {
  assert(imageUrl != null || imageProvider != null, 'Image is required');
  return await PaletteGenerator.fromImageProvider(
    imageProvider ?? NetworkImage(imageUrl ?? ''),
    size: const Size(110, 110),
    maximumColorCount: 20,
  );
}
