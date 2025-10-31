import 'dart:math' as math;

import '../hct/hct.dart';
import '../palettes/tonal_palette.dart';
import '../utils/math_utils.dart';
import 'color_spec.dart';
import 'color_specs.dart';
import 'dynamic_color.dart';
import 'material_dynamic_colors.dart';
import 'variant.dart';

enum Platform { phone, watch }

class DynamicScheme {
  static const SpecVersion defaultSpecVersion = SpecVersion.spec2021;
  static const Platform defaultPlatform = Platform.phone;

  DynamicScheme({
    required this.sourceColorHct,
    required this.variant,
    required this.isDark,
    required this.contrastLevel,
    this.platform = defaultPlatform,
    SpecVersion specVersion = defaultSpecVersion,
    required this.primaryPalette,
    required this.secondaryPalette,
    required this.tertiaryPalette,
    required this.neutralPalette,
    required this.neutralVariantPalette,
    TonalPalette? errorPalette,
  }) : sourceColorArgb = sourceColorHct.toInt(),
       specVersion = _maybeFallbackSpecVersion(specVersion, variant),
       errorPalette = errorPalette ?? TonalPalette.fromHueAndChroma(25.0, 84.0);

  DynamicScheme._fromPalettesOrKeyColors({
    required this.sourceColorHct,
    required this.isDark,
    required this.contrastLevel,
    required this.specVersion,
    required this.platform,
    required this.variant,
    TonalPalette? primaryPalette,
    TonalPalette? secondaryPalette,
    TonalPalette? tertiaryPalette,
    TonalPalette? neutralPalette,
    TonalPalette? neutralVariantPalette,
    TonalPalette? errorPalette,
    Hct? primaryPaletteKeyColor,
    Hct? secondaryPaletteKeyColor,
    Hct? tertiaryPaletteKeyColor,
    Hct? neutralPaletteKeyColor,
    Hct? neutralVariantPaletteKeyColor,
    Hct? errorPaletteKeyColor,
  }) : assert(primaryPalette == null || primaryPaletteKeyColor == null),
       assert(secondaryPalette == null || secondaryPaletteKeyColor == null),
       assert(tertiaryPalette == null || tertiaryPaletteKeyColor == null),
       assert(neutralPalette == null || neutralPaletteKeyColor == null),
       assert(
         neutralVariantPalette == null || neutralVariantPaletteKeyColor == null,
       ),
       assert(errorPalette == null || errorPaletteKeyColor == null),
       sourceColorArgb = sourceColorHct.toInt(),
       primaryPalette =
           primaryPalette ??
           ColorSpecs.get(specVersion).getPrimaryPalette(
             variant,
             primaryPaletteKeyColor ?? sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       secondaryPalette =
           secondaryPalette ??
           ColorSpecs.get(specVersion).getSecondaryPalette(
             variant,
             secondaryPaletteKeyColor ?? sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       tertiaryPalette =
           tertiaryPalette ??
           ColorSpecs.get(specVersion).getTertiaryPalette(
             variant,
             tertiaryPaletteKeyColor ?? sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       neutralPalette =
           neutralPalette ??
           ColorSpecs.get(specVersion).getNeutralPalette(
             variant,
             neutralPaletteKeyColor ?? sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       neutralVariantPalette =
           neutralVariantPalette ??
           ColorSpecs.get(specVersion).getNeutralVariantPalette(
             variant,
             neutralVariantPaletteKeyColor ?? sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       errorPalette =
           errorPalette ??
           ColorSpecs.get(specVersion).getErrorPalette(
             variant,
             errorPaletteKeyColor ?? sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ) ??
           TonalPalette.fromHueAndChroma(25.0, 84.0);

  DynamicScheme.fromPalettesOrKeyColors({
    required bool isDark,
    Hct? sourceColorHct,
    double? contrastLevel,
    Variant? variant,
    Platform? platform,
    SpecVersion? specVersion,
    TonalPalette? primaryPalette,
    TonalPalette? secondaryPalette,
    TonalPalette? tertiaryPalette,
    TonalPalette? neutralPalette,
    TonalPalette? neutralVariantPalette,
    TonalPalette? errorPalette,
    Hct? primaryPaletteKeyColor,
    Hct? secondaryPaletteKeyColor,
    Hct? tertiaryPaletteKeyColor,
    Hct? neutralPaletteKeyColor,
    Hct? neutralVariantPaletteKeyColor,
    Hct? errorPaletteKeyColor,
  }) : this._fromPalettesOrKeyColors(
         sourceColorHct: sourceColorHct ?? Hct.fromInt(0xFF6750A4),
         isDark: isDark,
         contrastLevel: contrastLevel ?? 0.0,
         variant: variant ?? Variant.tonalSpot,
         platform: platform ?? defaultPlatform,
         specVersion: _maybeFallbackSpecVersion(
           specVersion ?? defaultSpecVersion,
           variant ?? Variant.tonalSpot,
         ),
         primaryPalette: primaryPalette,
         secondaryPalette: secondaryPalette,
         tertiaryPalette: tertiaryPalette,
         neutralPalette: neutralPalette,
         neutralVariantPalette: neutralVariantPalette,
         errorPalette: errorPalette,
         primaryPaletteKeyColor: primaryPaletteKeyColor,
         secondaryPaletteKeyColor: secondaryPaletteKeyColor,
         tertiaryPaletteKeyColor: tertiaryPaletteKeyColor,
         neutralPaletteKeyColor: neutralPaletteKeyColor,
         neutralVariantPaletteKeyColor: neutralVariantPaletteKeyColor,
         errorPaletteKeyColor: errorPaletteKeyColor,
       );

  @Deprecated("Use fromPalettesOrKeyColors instead")
  DynamicScheme.fromPalettes({
    required bool isDark,
    Hct? sourceColorHct,
    double? contrastLevel,
    Variant? variant,
    Platform? platform,
    SpecVersion? specVersion,
    TonalPalette? primaryPalette,
    TonalPalette? secondaryPalette,
    TonalPalette? tertiaryPalette,
    TonalPalette? neutralPalette,
    TonalPalette? neutralVariantPalette,
    TonalPalette? errorPalette,
  }) : this.fromPalettesOrKeyColors(
         sourceColorHct: sourceColorHct,
         isDark: isDark,
         contrastLevel: contrastLevel,
         specVersion: specVersion,
         platform: platform,
         variant: variant,
         primaryPalette: primaryPalette,
         secondaryPalette: secondaryPalette,
         tertiaryPalette: tertiaryPalette,
         neutralPalette: neutralPalette,
         neutralVariantPalette: neutralVariantPalette,
         errorPalette: errorPalette,
       );

  @Deprecated("Use fromPalettesOrKeyColors instead")
  DynamicScheme.fromKeyColors({
    required bool isDark,
    Hct? sourceColorHct,
    double? contrastLevel,
    Variant? variant,
    Platform? platform,
    SpecVersion? specVersion,
    Hct? primaryPaletteKeyColor,
    Hct? secondaryPaletteKeyColor,
    Hct? tertiaryPaletteKeyColor,
    Hct? neutralPaletteKeyColor,
    Hct? neutralVariantPaletteKeyColor,
    Hct? errorPaletteKeyColor,
  }) : this.fromPalettesOrKeyColors(
         sourceColorHct: sourceColorHct,
         isDark: isDark,
         contrastLevel: contrastLevel,
         specVersion: specVersion,
         platform: platform,
         variant: variant,
         primaryPaletteKeyColor: primaryPaletteKeyColor,
         secondaryPaletteKeyColor: secondaryPaletteKeyColor,
         tertiaryPaletteKeyColor: tertiaryPaletteKeyColor,
         neutralPaletteKeyColor: neutralPaletteKeyColor,
         neutralVariantPaletteKeyColor: neutralVariantPaletteKeyColor,
         errorPaletteKeyColor: errorPaletteKeyColor,
       );

  final int sourceColorArgb;
  final Hct sourceColorHct;
  final Variant variant;
  final bool isDark;
  final Platform platform;
  final double contrastLevel;
  final SpecVersion specVersion;
  final TonalPalette primaryPalette;
  final TonalPalette secondaryPalette;
  final TonalPalette tertiaryPalette;
  final TonalPalette neutralPalette;
  final TonalPalette neutralVariantPalette;
  final TonalPalette errorPalette;

  Hct getHct(DynamicColor dynamicColor) => dynamicColor.getHct(this);

  int getArgb(DynamicColor dynamicColor) => dynamicColor.getArgb(this);

  int get primaryPaletteKeyColor => getArgb(_colors.primaryPaletteKeyColor());
  int get secondaryPaletteKeyColor =>
      getArgb(_colors.secondaryPaletteKeyColor());
  int get tertiaryPaletteKeyColor => getArgb(_colors.tertiaryPaletteKeyColor());
  int get neutralPaletteKeyColor => getArgb(_colors.neutralPaletteKeyColor());
  int get neutralVariantPaletteKeyColor =>
      getArgb(_colors.neutralVariantPaletteKeyColor());
  int get errorPaletteKeyColor => getArgb(_colors.errorPaletteKeyColor());
  int get background => getArgb(_colors.background());
  int get onBackground => getArgb(_colors.onBackground());
  int get surface => getArgb(_colors.surface());
  int get surfaceDim => getArgb(_colors.surfaceDim());
  int get surfaceBright => getArgb(_colors.surfaceBright());
  int get surfaceContainerLowest => getArgb(_colors.surfaceContainerLowest());
  int get surfaceContainerLow => getArgb(_colors.surfaceContainerLow());
  int get surfaceContainer => getArgb(_colors.surfaceContainer());
  int get surfaceContainerHigh => getArgb(_colors.surfaceContainerHigh());
  int get surfaceContainerHighest => getArgb(_colors.surfaceContainerHighest());
  int get onSurface => getArgb(_colors.onSurface());
  int get surfaceVariant => getArgb(_colors.surfaceVariant());
  int get onSurfaceVariant => getArgb(_colors.onSurfaceVariant());
  int get outline => getArgb(_colors.outline());
  int get outlineVariant => getArgb(_colors.outlineVariant());
  int get inverseSurface => getArgb(_colors.inverseSurface());
  int get inverseOnSurface => getArgb(_colors.inverseOnSurface());
  int get shadow => getArgb(_colors.shadow());
  int get scrim => getArgb(_colors.scrim());
  int get surfaceTint => getArgb(_colors.surfaceTint());
  int get primary => getArgb(_colors.primary());
  int get primaryDim => getArgb(_colors.primaryDim());
  int get onPrimary => getArgb(_colors.onPrimary());
  int get primaryContainer => getArgb(_colors.primaryContainer());
  int get onPrimaryContainer => getArgb(_colors.onPrimaryContainer());
  int get primaryFixed => getArgb(_colors.primaryFixed());
  int get primaryFixedDim => getArgb(_colors.primaryFixedDim());
  int get onPrimaryFixed => getArgb(_colors.onPrimaryFixed());
  int get onPrimaryFixedVariant => getArgb(_colors.onPrimaryFixedVariant());
  int get inversePrimary => getArgb(_colors.inversePrimary());
  int get secondary => getArgb(_colors.secondary());
  int get secondaryDim => getArgb(_colors.secondaryDim());
  int get onSecondary => getArgb(_colors.onSecondary());
  int get secondaryContainer => getArgb(_colors.secondaryContainer());
  int get onSecondaryContainer => getArgb(_colors.onSecondaryContainer());
  int get secondaryFixed => getArgb(_colors.secondaryFixed());
  int get secondaryFixedDim => getArgb(_colors.secondaryFixedDim());
  int get onSecondaryFixed => getArgb(_colors.onSecondaryFixed());
  int get onSecondaryFixedVariant => getArgb(_colors.onSecondaryFixedVariant());
  int get tertiary => getArgb(_colors.tertiary());
  int get tertiaryDim => getArgb(_colors.tertiaryDim());
  int get onTertiary => getArgb(_colors.onTertiary());
  int get tertiaryContainer => getArgb(_colors.tertiaryContainer());
  int get onTertiaryContainer => getArgb(_colors.onTertiaryContainer());
  int get tertiaryFixed => getArgb(_colors.tertiaryFixed());
  int get tertiaryFixedDim => getArgb(_colors.tertiaryFixedDim());
  int get onTertiaryFixed => getArgb(_colors.onTertiaryFixed());
  int get onTertiaryFixedVariant => getArgb(_colors.onTertiaryFixedVariant());
  int get error => getArgb(_colors.error());
  int get errorDim => getArgb(_colors.errorDim());
  int get onError => getArgb(_colors.onError());
  int get errorContainer => getArgb(_colors.errorContainer());
  int get onErrorContainer => getArgb(_colors.onErrorContainer());
  int get controlActivated => getArgb(_colors.controlActivated());
  int get controlNormal => getArgb(_colors.controlNormal());
  int get controlHighlight => getArgb(_colors.controlHighlight());
  int get textPrimaryInverse => getArgb(_colors.textPrimaryInverse());
  int get textSecondaryAndTertiaryInverse =>
      getArgb(_colors.textSecondaryAndTertiaryInverse());
  int get textPrimaryInverseDisableOnly =>
      getArgb(_colors.textPrimaryInverseDisableOnly());
  int get textSecondaryAndTertiaryInverseDisabled =>
      getArgb(_colors.textSecondaryAndTertiaryInverseDisabled());
  int get textHintInverse => getArgb(_colors.textHintInverse());

  @override
  String toString() =>
      "Scheme: variant=${variant.name}, "
      "mode=${isDark ? "dark" : "light"}, "
      "platform=${platform.name}, "
      "contrastLevel=${contrastLevel.toStringAsFixed(1)}, "
      "seed=$sourceColorHct, "
      "specVersion=$specVersion";

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is DynamicScheme &&
            sourceColorArgb == other.sourceColorArgb &&
            sourceColorHct == other.sourceColorHct &&
            variant == other.variant &&
            isDark == other.isDark &&
            platform == other.platform &&
            contrastLevel == other.contrastLevel &&
            specVersion == other.specVersion &&
            primaryPalette == other.primaryPalette &&
            secondaryPalette == other.secondaryPalette &&
            tertiaryPalette == other.tertiaryPalette &&
            neutralPalette == other.neutralPalette &&
            neutralVariantPalette == other.neutralVariantPalette &&
            errorPalette == other.errorPalette;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sourceColorArgb,
    sourceColorHct,
    variant,
    isDark,
    platform,
    contrastLevel,
    specVersion,
    primaryPalette,
    secondaryPalette,
    tertiaryPalette,
    neutralPalette,
    neutralVariantPalette,
    errorPalette,
  );

  static const MaterialDynamicColors _colors = MaterialDynamicColors();

  static DynamicScheme from(
    DynamicScheme other,
    bool isDark, [
    double? contrastLevel,
  ]) {
    return DynamicScheme(
      sourceColorHct: other.sourceColorHct,
      variant: other.variant,
      isDark: isDark,
      contrastLevel: contrastLevel ?? other.contrastLevel,
      platform: other.platform,
      specVersion: other.specVersion,
      primaryPalette: other.primaryPalette,
      secondaryPalette: other.secondaryPalette,
      tertiaryPalette: other.tertiaryPalette,
      neutralPalette: other.neutralPalette,
      neutralVariantPalette: other.neutralVariantPalette,
      errorPalette: other.errorPalette,
    );
  }

  static double getPiecewiseValue(
    Hct sourceColorHct,
    List<double> hueBreakpoints,
    List<double> hues,
  ) {
    final size = math.min(hueBreakpoints.length - 1, hues.length);
    final sourceHue = sourceColorHct.hue;
    for (int i = 0; i < size; i++) {
      if (sourceHue >= hueBreakpoints[i] && sourceHue < hueBreakpoints[i + 1]) {
        return MathUtils.sanitizeDegreesDouble(hues[i]);
      }
    }
    // No condition matched, return the source value.
    return sourceHue;
  }

  static double getRotatedHue(
    Hct sourceColorHct,
    List<double> hueBreakpoints,
    List<double> rotations,
  ) {
    double rotation = getPiecewiseValue(
      sourceColorHct,
      hueBreakpoints,
      rotations,
    );
    if (math.min(hueBreakpoints.length - 1, rotations.length) <= 0) {
      // No condition matched, return the source hue.
      rotation = 0.0;
    }
    return MathUtils.sanitizeDegreesDouble(sourceColorHct.hue + rotation);
  }

  /// Returns the spec version to use for the given variant.
  /// If the variant is not supported by the given spec version,
  /// the fallback spec version is returned.
  static SpecVersion _maybeFallbackSpecVersion(
    SpecVersion specVersion,
    Variant variant,
  ) => switch (variant) {
    Variant.expressive ||
    Variant.vibrant ||
    Variant.tonalSpot ||
    Variant.neutral => specVersion,
    _ => SpecVersion.spec2021,
  };
}
