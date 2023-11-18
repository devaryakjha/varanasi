/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/app_icon_monotone.svg
  SvgGenImage get appIconMonotone =>
      const SvgGenImage('assets/icon/app_icon_monotone.svg');

  /// File path: assets/icon/circular_loader.json
  LottieGenImage get circularLoader =>
      const LottieGenImage('assets/icon/circular_loader.json');

  /// File path: assets/icon/download.svg
  SvgGenImage get download => const SvgGenImage('assets/icon/download.svg');

  /// File path: assets/icon/download_filled.svg
  SvgGenImage get downloadFilled =>
      const SvgGenImage('assets/icon/download_filled.svg');

  /// File path: assets/icon/downloading.svg
  SvgGenImage get downloading =>
      const SvgGenImage('assets/icon/downloading.svg');

  /// File path: assets/icon/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icon/google.svg');

  $AssetsIconNavGen get nav => const $AssetsIconNavGen();

  /// File path: assets/icon/shuffle.svg
  SvgGenImage get shuffle => const SvgGenImage('assets/icon/shuffle.svg');

  /// List of all assets
  List<dynamic> get values => [
        appIconMonotone,
        circularLoader,
        download,
        downloadFilled,
        downloading,
        google,
        shuffle
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();
}

class $AssetsIconNavGen {
  const $AssetsIconNavGen();

  /// File path: assets/icon/nav/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icon/nav/home.svg');

  /// File path: assets/icon/nav/home_selected.svg
  SvgGenImage get homeSelected =>
      const SvgGenImage('assets/icon/nav/home_selected.svg');

  /// File path: assets/icon/nav/library.svg
  SvgGenImage get library => const SvgGenImage('assets/icon/nav/library.svg');

  /// File path: assets/icon/nav/library_selected.svg
  SvgGenImage get librarySelected =>
      const SvgGenImage('assets/icon/nav/library_selected.svg');

  /// File path: assets/icon/nav/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icon/nav/search.svg');

  /// File path: assets/icon/nav/search_selected.svg
  SvgGenImage get searchSelected =>
      const SvgGenImage('assets/icon/nav/search_selected.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [home, homeSelected, library, librarySelected, search, searchSelected];
}

class Assets {
  Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
