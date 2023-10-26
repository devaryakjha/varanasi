import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

class DownloadsIcon extends StatelessWidget {
  const DownloadsIcon({
    super.key,
    this.dimension = 48,
  });

  final double dimension;

  double get iconSize => dimension * 0.4;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimension,
      width: dimension,
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.download_rounded,
        color: context.theme.colorScheme.onSecondaryContainer,
        size: iconSize,
      ),
    );
  }
}
