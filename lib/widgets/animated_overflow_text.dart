import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AnimatedText extends StatelessWidget {
  /// Creates a [AnimatedText] widget.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing [DefaultTextStyle].
  const AnimatedText(
    String this.data, {
    super.key,
    this.autoSizeTextKey,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.overflowReplacement,
    this.maxLines,
    this.semanticsLabel,
  }) : textSpan = null;

  /// Creates a [AnimatedText] widget with a [TextSpan].
  const AnimatedText.rich(
    TextSpan this.textSpan, {
    super.key,
    this.autoSizeTextKey,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.overflowReplacement,
    this.maxLines,
    this.semanticsLabel,
  }) : data = null;

  /// Sets the key for the resulting [Text] widget.
  ///
  /// This allows you to find the actual `Text` widget built by `AnimatedText`.
  final Key? textKey;

  /// Sets the key for the resulting [AnimatedText] widget.
  ///
  /// This allows you to find the actual `Text` widget built by `AnimatedText`.
  final Key? autoSizeTextKey;

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String? data;

  /// The text to display as a [TextSpan].
  ///
  /// This will be null if [data] is provided instead.
  final TextSpan? textSpan;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  /// The strut style to use. Strut style defines the strut, which sets minimum
  /// vertical layout metrics.
  ///
  /// Omitting or providing null will disable strut.
  ///
  /// Omitting or providing null for any properties of [StrutStyle] will result
  /// in default values being used. It is highly recommended to at least specify
  /// a font size.
  ///
  /// See [StrutStyle] for details.
  final StrutStyle? strutStyle;

  /// The minimum text size constraint to be used when auto-sizing text.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double minFontSize;

  /// The maximum text size constraint to be used when auto-sizing text.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double maxFontSize;

  /// The step size in which the font size is being adapted to constraints.
  ///
  /// The Text scales uniformly in a range between [minFontSize] and
  /// [maxFontSize].
  /// Each increment occurs as per the step size set in stepGranularity.
  ///
  /// Most of the time you don't want a stepGranularity below 1.0.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double stepGranularity;

  /// Predefines all the possible font sizes.
  ///
  /// **Important:** PresetFontSizes have to be in descending order.
  final List<double>? presetFontSizes;

  /// Synchronizes the size of multiple [AnimatedText]s.
  ///
  /// If you want multiple [AnimatedText]s to have the same text size, give all
  /// of them the same [AutoSizeGroup] instance. All of them will have the
  /// size of the smallest [AnimatedText]
  final AutoSizeGroup? group;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was
  /// unlimited horizontal space.
  final bool? softWrap;

  /// Whether words which don't fit in one line should be wrapped.
  ///
  /// If false, the fontSize is lowered as far as possible until all words fit
  /// into a single line.
  final bool wrapWords;

  /// How visual overflow should be handled.
  ///
  /// Defaults to retrieving the value from the nearest [DefaultTextStyle] ancestor.
  final TextOverflow? overflow;

  /// If the text is overflowing and does not fit its bounds, this widget is
  /// displayed instead.
  final Widget? overflowReplacement;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be resized according
  /// to the specified bounds and if necessary truncated according to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// AnimatedText(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String? semanticsLabel;

  Widget buildDefaultOverfowReplacement() {
    return Marquee(
      text: data ?? textSpan!.toPlainText(),
      startAfter: const Duration(seconds: 1),
      pauseAfterRound: const Duration(seconds: 2),
      blankSpace: 8,
      accelerationDuration: const Duration(seconds: 2),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      style: style?.copyWith(fontSize: minFontSize),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (textSpan == null) {
      return AutoSizeText(
        data!,
        key: autoSizeTextKey,
        textKey: textKey,
        style: style,
        strutStyle: strutStyle,
        minFontSize: minFontSize,
        maxFontSize: maxFontSize,
        stepGranularity: stepGranularity,
        presetFontSizes: presetFontSizes,
        group: group,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        wrapWords: wrapWords,
        overflow: overflow,
        overflowReplacement:
            overflowReplacement ?? buildDefaultOverfowReplacement(),
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
      );
    }
    return AutoSizeText.rich(
      textSpan!,
      key: autoSizeTextKey,
      textKey: textKey,
      style: style,
      strutStyle: strutStyle,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes,
      group: group,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      wrapWords: wrapWords,
      overflow: overflow,
      overflowReplacement:
          overflowReplacement ?? buildDefaultOverfowReplacement(),
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }
}
