import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';

/// A widget that displays text.
class Typography extends StatelessWidget {
  /// The primary text to display.
  final String primary;

  /// The secondary text to display.
  final String? secondary;

  /// The tertiary text to display.
  final String? tertiary;

  /// The gap between the texts in pixels.
  final double gap;

  /// The style of the [primary] text.
  final TextStyle? primaryStyle;

  /// The style of the [secondary] text.
  final TextStyle? secondaryStyle;

  /// The style of the [tertiary] text.
  final TextStyle? tertiaryStyle;

  /// The maximum number of lines for the [primary] text.
  final int maxLines;

  /// The maximum number of lines for the [secondary] text.
  final int maxLinesSecondary;

  /// The maximum number of lines for the [tertiary] text.
  final int maxLinesTertiary;

  /// Creates a [Typography] widget.
  const Typography(
    this.primary, {
    this.secondary,
    this.tertiary,
    this.gap = 8,
    this.primaryStyle,
    this.secondaryStyle,
    this.tertiaryStyle,
    this.maxLines = 1,
    this.maxLinesSecondary = 1,
    this.maxLinesTertiary = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          primary,
          style: primaryStyle ?? context.textTheme.titleLarge,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        if (secondary != null) ...[
          SizedBox(height: gap),
          Text(
            secondary!,
            style: secondaryStyle ?? context.textTheme.titleSmall,
            maxLines: maxLinesSecondary,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (tertiary != null) ...[
          SizedBox(height: gap),
          Text(
            tertiary!,
            style: tertiaryStyle ?? context.textTheme.titleSmall,
            maxLines: maxLinesTertiary,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
