import '../utils/math_utils.dart';
import '../hct/hct.dart';
import '../contrast/contrast.dart';
import '../palettes/tonal_palette.dart';

import 'color_spec.dart';
import 'color_specs.dart';
import 'tone_delta_pair.dart';
import 'contrast_curve.dart';
import 'dynamic_scheme.dart';

typedef DynamicSchemeCallback<T> = T Function(DynamicScheme s);

final class DynamicColor {
  DynamicColor({
    required this.name,
    required this.palette,
    required this.tone,
    required this.isBackground,
    this.chromaMultiplier,
    this.background,
    this.secondBackground,
    this.contrastCurve,
    this.toneDeltaPair,
    this.opacity,
  }) : assert(
         secondBackground == null || background != null,
         "Color $name has secondBackground defined,"
         " but background is not defined.",
       ),
       assert(
         contrastCurve == null || background != null,
         "Color $name has contrastCurve defined,"
         " but background is not defined.",
       ),
       assert(
         background == null || contrastCurve != null,
         "Color $name has background defined,"
         " but contrastCurve is not defined.",
       );

  DynamicColor.fromPalette({
    this.name = "",
    required this.palette,
    DynamicSchemeCallback<double>? tone,
    this.isBackground = false,
    this.chromaMultiplier,
    this.background,
    this.secondBackground,
    this.contrastCurve,
    this.toneDeltaPair,
    this.opacity,
  }) : tone = tone ?? DynamicColor.getInitialToneFromBackground(background);

  final String name;
  final DynamicSchemeCallback<TonalPalette> palette;
  final DynamicSchemeCallback<double> tone;
  final bool isBackground;
  final DynamicSchemeCallback<double>? chromaMultiplier;
  final DynamicSchemeCallback<DynamicColor?>? background;
  final DynamicSchemeCallback<DynamicColor?>? secondBackground;
  final DynamicSchemeCallback<ContrastCurve?>? contrastCurve;
  final DynamicSchemeCallback<ToneDeltaPair?>? toneDeltaPair;
  final DynamicSchemeCallback<double?>? opacity;

  final Map<DynamicScheme, Hct> _hctCache = <DynamicScheme, Hct>{};

  DynamicColor copyWith({
    String? name,
    DynamicSchemeCallback<TonalPalette>? palette,
    DynamicSchemeCallback<double>? tone,
    bool? isBackground,
  }) {
    if (name == null &&
        palette == null &&
        tone == null &&
        isBackground == null) {
      return this;
    }
    return DynamicColor(
      name: name ?? this.name,
      palette: palette ?? this.palette,
      tone: tone ?? this.tone,
      isBackground: isBackground ?? this.isBackground,
      chromaMultiplier: chromaMultiplier,
      background: background,
      secondBackground: secondBackground,
      contrastCurve: contrastCurve,
      toneDeltaPair: toneDeltaPair,
      opacity: opacity,
    );
  }

  int getArgb(DynamicScheme scheme) {
    int argb = getHct(scheme).toInt();
    final opacity = this.opacity?.call(scheme);
    if (opacity == null) return argb;
    final alpha = MathUtils.clampInt(0, 255, (opacity * 255.0).round());
    return (argb & 0x00ffffff) | (alpha << 24);
  }

  Hct getHct(DynamicScheme scheme) {
    final cachedAnswer = _hctCache[scheme];
    if (cachedAnswer != null) return cachedAnswer;
    // ignore: invalid_use_of_protected_member
    final answer = ColorSpecs.get(scheme.specVersion).getHct(scheme, this);
    if (_hctCache.length > 4) _hctCache.clear();
    _hctCache[scheme] = answer;
    return answer;
  }

  double getTone(DynamicScheme scheme) {
    // ignore: invalid_use_of_protected_member
    return ColorSpecs.get(scheme.specVersion).getTone(scheme, this);
  }

  static double foregroundTone(double bgTone, double ratio) {
    final lighterTone = Contrast.lighterUnsafe(bgTone, ratio);
    final darkerTone = Contrast.darkerUnsafe(bgTone, ratio);
    final lighterRatio = Contrast.ratioOfTones(lighterTone, bgTone);
    final darkerRatio = Contrast.ratioOfTones(darkerTone, bgTone);
    final preferLighter = tonePrefersLightForeground(bgTone);

    if (preferLighter) {
      // "Neglible difference" handles an edge case where
      // the initial contrast ratio is high (ex. 13.0),
      // and the ratio passed to the function is that high ratio,
      // and both the lighter
      // and darker ratio fails to pass that ratio.
      //
      // This was observed with Tonal Spot's On Primary Container
      // turning black momentarily between high and max contrast in light mode.
      // PC's standard tone was T90, OPC's was T10, it was light mode,
      // and the contrast level was 0.6568521221032331.
      final negligibleDifference =
          (lighterRatio - darkerRatio).abs() < 0.1 &&
          lighterRatio < ratio &&
          darkerRatio < ratio;
      if (lighterRatio >= ratio ||
          lighterRatio >= darkerRatio ||
          negligibleDifference) {
        return lighterTone;
      } else {
        return darkerTone;
      }
    } else {
      return darkerRatio >= ratio || darkerRatio >= lighterRatio
          ? darkerTone
          : lighterTone;
    }
  }

  static double enableLightForeground(double tone) {
    if (tonePrefersLightForeground(tone) && !toneAllowsLightForeground(tone)) {
      return 49.0;
    }
    return tone;
  }

  static bool tonePrefersLightForeground(double tone) {
    return tone.round() < 60;
  }

  static bool toneAllowsLightForeground(double tone) {
    return tone.round() <= 49;
  }

  static DynamicSchemeCallback<double> getInitialToneFromBackground([
    DynamicSchemeCallback<DynamicColor?>? background,
  ]) {
    if (background == null) return (s) => 50.0;
    return (s) => background.call(s)?.getTone(s) ?? 50.0;
  }

  void _validateExtendedColor(
    SpecVersion specVersion,
    DynamicColor extendedColor,
  ) {
    assert(
      name == extendedColor.name,
      "Attempting to extend color $name "
      "with color ${extendedColor.name} of different name "
      "for spec version $specVersion.",
    );
    assert(
      isBackground == extendedColor.isBackground,
      "Attempting to extend color $name as a "
      "${isBackground ? "background" : "foreground"} with color "
      "${extendedColor.name} as a "
      "${extendedColor.isBackground ? "background" : "foreground"} "
      "for spec version $specVersion.",
    );
  }

  DynamicColor extendSpecVersion(
    SpecVersion specVersion,
    DynamicColor extendedColor,
  ) {
    _validateExtendedColor(specVersion, extendedColor);
    return DynamicColor.fromPalette(
      name: name,
      isBackground: isBackground,
      palette: (s) =>
          s.specVersion == specVersion ? extendedColor.palette(s) : palette(s),
      tone: (s) =>
          s.specVersion == specVersion ? extendedColor.tone(s) : tone(s),
      chromaMultiplier: (s) {
        final chromaMultiplier = s.specVersion == specVersion
            ? extendedColor.chromaMultiplier
            : this.chromaMultiplier;
        return chromaMultiplier != null ? chromaMultiplier(s) : 1.0;
      },
      background: (s) {
        final background = s.specVersion == specVersion
            ? extendedColor.background
            : this.background;
        return background?.call(s);
      },
      secondBackground: (s) {
        final secondBackground = s.specVersion == specVersion
            ? extendedColor.secondBackground
            : this.secondBackground;
        return secondBackground?.call(s);
      },
      contrastCurve: (s) {
        final contrastCurve = s.specVersion == specVersion
            ? extendedColor.contrastCurve
            : this.contrastCurve;
        return contrastCurve?.call(s);
      },
      toneDeltaPair: (s) {
        final toneDeltaPair = s.specVersion == specVersion
            ? extendedColor.toneDeltaPair
            : this.toneDeltaPair;
        return toneDeltaPair?.call(s);
      },
      opacity: (s) {
        final opacity = s.specVersion == specVersion
            ? extendedColor.opacity
            : this.opacity;
        return opacity?.call(s);
      },
    );
  }
}
