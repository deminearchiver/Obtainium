// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsCaGen {
  const $AssetsCaGen();

  /// File path: assets/ca/lets-encrypt-r3.pem
  String get letsEncryptR3 => 'assets/ca/lets-encrypt-r3.pem';

  /// Directory path: assets/ca
  String get path => 'assets/ca';

  /// List of all assets
  List<String> get values => [letsEncryptR3];
}

class $AssetsGraphicsGen {
  const $AssetsGraphicsGen();

  /// File path: assets/graphics/badge_obtainium.png
  AssetGenImage get badgeObtainium => const AssetGenImage(
    'assets/graphics/badge_obtainium.png',
    size: const Size(564.0, 168.0),
  );

  /// File path: assets/graphics/banner.png
  AssetGenImage get banner => const AssetGenImage(
    'assets/graphics/banner.png',
    size: const Size(1024.0, 500.0),
  );

  /// File path: assets/graphics/icon-512x512.png
  AssetGenImage get icon512x512 => const AssetGenImage(
    'assets/graphics/icon-512x512.png',
    size: const Size(512.0, 512.0),
  );

  /// File path: assets/graphics/icon.png
  AssetGenImage get iconPng => const AssetGenImage(
    'assets/graphics/icon.png',
    size: const Size(1024.0, 1024.0),
  );

  /// File path: assets/graphics/icon.svg
  SvgGenImage get iconSvg => const SvgGenImage(
    'assets/graphics/icon.svg',
    size: Size(142.12897, 142.12897),
  );

  /// File path: assets/graphics/icon_small.png
  AssetGenImage get iconSmall => const AssetGenImage(
    'assets/graphics/icon_small.png',
    size: const Size(72.0, 72.0),
  );

  /// File path: assets/graphics/obtainium.psd
  String get obtainium => 'assets/graphics/obtainium.psd';

  /// Directory path: assets/graphics
  String get path => 'assets/graphics';

  /// List of all assets
  List<dynamic> get values => [
    badgeObtainium,
    banner,
    icon512x512,
    iconPng,
    iconSvg,
    iconSmall,
    obtainium,
  ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/bs.json
  String get bs => 'assets/translations/bs.json';

  /// File path: assets/translations/ca.json
  String get ca => 'assets/translations/ca.json';

  /// File path: assets/translations/cs.json
  String get cs => 'assets/translations/cs.json';

  /// File path: assets/translations/da.json
  String get da => 'assets/translations/da.json';

  /// File path: assets/translations/de.json
  String get de => 'assets/translations/de.json';

  /// File path: assets/translations/en-EO.json
  String get enEO => 'assets/translations/en-EO.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// File path: assets/translations/es.json
  String get es => 'assets/translations/es.json';

  /// File path: assets/translations/fa.json
  String get fa => 'assets/translations/fa.json';

  /// File path: assets/translations/fr.json
  String get fr => 'assets/translations/fr.json';

  /// File path: assets/translations/hu.json
  String get hu => 'assets/translations/hu.json';

  /// File path: assets/translations/id.json
  String get id => 'assets/translations/id.json';

  /// File path: assets/translations/it.json
  String get it => 'assets/translations/it.json';

  /// File path: assets/translations/ja.json
  String get ja => 'assets/translations/ja.json';

  /// File path: assets/translations/ko.json
  String get ko => 'assets/translations/ko.json';

  /// File path: assets/translations/ml.json
  String get ml => 'assets/translations/ml.json';

  /// File path: assets/translations/nl.json
  String get nl => 'assets/translations/nl.json';

  /// File path: assets/translations/pl.json
  String get pl => 'assets/translations/pl.json';

  /// File path: assets/translations/pt-BR.json
  String get ptBR => 'assets/translations/pt-BR.json';

  /// File path: assets/translations/pt.json
  String get pt => 'assets/translations/pt.json';

  /// File path: assets/translations/ru.json
  String get ru => 'assets/translations/ru.json';

  /// File path: assets/translations/standardize.js
  String get standardize => 'assets/translations/standardize.js';

  /// File path: assets/translations/sv.json
  String get sv => 'assets/translations/sv.json';

  /// File path: assets/translations/tr.json
  String get tr => 'assets/translations/tr.json';

  /// File path: assets/translations/uk.json
  String get uk => 'assets/translations/uk.json';

  /// File path: assets/translations/vi.json
  String get vi => 'assets/translations/vi.json';

  /// File path: assets/translations/zh-Hant-TW.json
  String get zhHantTW => 'assets/translations/zh-Hant-TW.json';

  /// File path: assets/translations/zh.json
  String get zh => 'assets/translations/zh.json';

  /// Directory path: assets/translations
  String get path => 'assets/translations';

  /// List of all assets
  List<String> get values => [
    ar,
    bs,
    ca,
    cs,
    da,
    de,
    enEO,
    en,
    es,
    fa,
    fr,
    hu,
    id,
    it,
    ja,
    ko,
    ml,
    nl,
    pl,
    ptBR,
    pt,
    ru,
    standardize,
    sv,
    tr,
    uk,
    vi,
    zhHantTW,
    zh,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsCaGen ca = $AssetsCaGen();
  static const $AssetsGraphicsGen graphics = $AssetsGraphicsGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
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
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
