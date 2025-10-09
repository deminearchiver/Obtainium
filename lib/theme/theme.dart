import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:material/material_color_utilities.dart';
import 'package:obtainium/flutter.dart';

// ignore: implementation_imports
import 'package:obtainium_fonts/src/assets/fonts.gen.dart';

const String _roboto = "Roboto";
const String _robotoFlex = Fonts.robotoFlex;
const String _googleSans = Fonts.googleSans;
const String _googleSansFlex = Fonts.googleSansFlex;

@immutable
class TypographyDefaults with Diagnosticable {
  const TypographyDefaults.from({
    this.typeface = const TypefaceThemeDataPartial.from(),
    this.typescale = const TypescaleThemeDataPartial.from(),
  });

  // TODO: implement TypographyDefaults.fromPlatform
  factory TypographyDefaults.fromPlatform(TargetPlatform platform) =>
      switch (platform) {
        _ => const TypographyDefaults.from(),
      };

  final TypefaceThemeDataPartial typeface;
  final TypescaleThemeDataPartial typescale;

  TypographyDefaults copyWith({
    covariant TypefaceThemeDataPartial? typeface,
    covariant TypescaleThemeDataPartial? typescale,
  }) {
    if (typeface == null && typescale == null) {
      return this;
    }
    return TypographyDefaults.from(
      typeface: typeface ?? this.typeface,
      typescale: typescale ?? this.typescale,
    );
  }

  TypographyDefaults mergeWith({
    TypefaceThemeDataPartial? typeface,
    TypescaleThemeDataPartial? typescale,
  }) {
    if (typeface == null && typescale == null) {
      return this;
    }
    return TypographyDefaults.from(
      typeface: this.typeface.merge(typeface),
      typescale: this.typescale.merge(typescale),
    );
  }

  TypographyDefaults merge(TypographyDefaults? other) {
    if (other == null) return this;
    return mergeWith(typeface: other.typeface, typescale: other.typescale);
  }

  Widget build(BuildContext context, Widget child) {
    return TypefaceTheme.merge(
      data: typeface,
      child: TypescaleTheme.merge(data: typescale, child: child),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TypefaceThemeDataPartial>(
        "typeface",
        typeface,
        defaultValue: const TypefaceThemeDataPartial.from(),
      ),
    );
    properties.add(
      DiagnosticsProperty<TypescaleThemeDataPartial>(
        "typescale",
        typescale,
        defaultValue: const TypescaleThemeDataPartial.from(),
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is TypographyDefaults &&
            typeface == other.typeface &&
            typescale == other.typescale;
  }

  @override
  int get hashCode => Object.hash(runtimeType, typeface, typescale);

  static const TypographyDefaults material3Baseline = TypographyDefaults.from(
    typeface: TypefaceThemeDataPartial.from(
      // Roboto was the default typeface for M3 Baseline
      brand: [_roboto],
      plain: [_roboto],
    ),
  );

  static const TypographyDefaults material3Expressive = TypographyDefaults.from(
    typeface: TypefaceThemeDataPartial.from(
      // M3 Expressive introduced variable font support
      brand: [_robotoFlex, _roboto],
      plain: [_robotoFlex, _roboto],
    ),
  );

  static const TypographyDefaults googleMaterial3Baseline =
      TypographyDefaults.from(
        typeface: TypefaceThemeDataPartial.from(
          // Google Sans (not "Flex") doesn't support ROND.
          brand: [_googleSans, _roboto],
          plain: [_googleSans, _roboto],
        ),
        typescale: TypescaleThemeDataPartial.from(
          // ROND wasn't used before the introduction of GM3 Expressive.
          // We explicitly set this axis to 0 here to avoid confusion.
          displayLarge: TypeStylePartial.from(rond: 0.0),
          displayMedium: TypeStylePartial.from(rond: 0.0),
          displaySmall: TypeStylePartial.from(rond: 0.0),
          headlineLarge: TypeStylePartial.from(rond: 0.0),
          headlineMedium: TypeStylePartial.from(rond: 0.0),
          headlineSmall: TypeStylePartial.from(rond: 0.0),
          titleLarge: TypeStylePartial.from(rond: 0.0),
          titleMedium: TypeStylePartial.from(rond: 0.0),
          titleSmall: TypeStylePartial.from(rond: 0.0),
          bodyLarge: TypeStylePartial.from(rond: 0.0),
          bodyMedium: TypeStylePartial.from(rond: 0.0),
          bodySmall: TypeStylePartial.from(rond: 0.0),
          labelLarge: TypeStylePartial.from(rond: 0.0),
          labelMedium: TypeStylePartial.from(rond: 0.0),
          labelSmall: TypeStylePartial.from(rond: 0.0),
          displayLargeEmphasized: TypeStylePartial.from(rond: 0.0),
          displayMediumEmphasized: TypeStylePartial.from(rond: 0.0),
          displaySmallEmphasized: TypeStylePartial.from(rond: 0.0),
          headlineLargeEmphasized: TypeStylePartial.from(rond: 0.0),
          headlineMediumEmphasized: TypeStylePartial.from(rond: 0.0),
          headlineSmallEmphasized: TypeStylePartial.from(rond: 0.0),
          titleLargeEmphasized: TypeStylePartial.from(rond: 0.0),
          titleMediumEmphasized: TypeStylePartial.from(rond: 0.0),
          titleSmallEmphasized: TypeStylePartial.from(rond: 0.0),
          bodyLargeEmphasized: TypeStylePartial.from(rond: 0.0),
          bodyMediumEmphasized: TypeStylePartial.from(rond: 0.0),
          bodySmallEmphasized: TypeStylePartial.from(rond: 0.0),
          labelLargeEmphasized: TypeStylePartial.from(rond: 0.0),
          labelMediumEmphasized: TypeStylePartial.from(rond: 0.0),
          labelSmallEmphasized: TypeStylePartial.from(rond: 0.0),
        ),
      );

  static const TypographyDefaults
  googleMaterial3Expressive = TypographyDefaults.from(
    typeface: TypefaceThemeDataPartial.from(
      // The ROND axis is currently only available for Google Sans Flex,
      // making it a no-op for most of the other possibly installed fonts.
      // This particular information was ripped from a file
      // located at the path "/product/etc/fonts_customization.xml"
      // on a Google Pixel with Android 16 QPR1 beta 3 (Material 3 Expressive)
      brand: [_googleSansFlex, _robotoFlex, _googleSans, _roboto],
      plain: [_googleSansFlex, _robotoFlex, _googleSans, _roboto],
    ),
    typescale: TypescaleThemeDataPartial.from(
      displayLarge: TypeStylePartial.from(rond: 0.0),
      displayMedium: TypeStylePartial.from(rond: 0.0),
      displaySmall: TypeStylePartial.from(rond: 0.0),
      headlineLarge: TypeStylePartial.from(rond: 0.0),
      headlineMedium: TypeStylePartial.from(rond: 0.0),
      headlineSmall: TypeStylePartial.from(rond: 0.0),
      titleLarge: TypeStylePartial.from(rond: 0.0),
      titleMedium: TypeStylePartial.from(rond: 0.0),
      titleSmall: TypeStylePartial.from(rond: 0.0),
      bodyLarge: TypeStylePartial.from(rond: 0.0),
      bodyMedium: TypeStylePartial.from(rond: 0.0),
      bodySmall: TypeStylePartial.from(rond: 0.0),
      labelLarge: TypeStylePartial.from(rond: 0.0),
      labelMedium: TypeStylePartial.from(rond: 0.0),
      labelSmall: TypeStylePartial.from(rond: 0.0),
      displayLargeEmphasized: TypeStylePartial.from(rond: 100.0),
      displayMediumEmphasized: TypeStylePartial.from(rond: 100.0),
      displaySmallEmphasized: TypeStylePartial.from(rond: 100.0),
      headlineLargeEmphasized: TypeStylePartial.from(rond: 100.0),
      headlineMediumEmphasized: TypeStylePartial.from(rond: 100.0),
      headlineSmallEmphasized: TypeStylePartial.from(rond: 100.0),
      titleLargeEmphasized: TypeStylePartial.from(rond: 100.0),
      titleMediumEmphasized: TypeStylePartial.from(rond: 100.0),
      titleSmallEmphasized: TypeStylePartial.from(rond: 100.0),
      bodyLargeEmphasized: TypeStylePartial.from(rond: 100.0),
      bodyMediumEmphasized: TypeStylePartial.from(rond: 100.0),
      bodySmallEmphasized: TypeStylePartial.from(rond: 100.0),
      labelLargeEmphasized: TypeStylePartial.from(rond: 100.0),
      labelMediumEmphasized: TypeStylePartial.from(rond: 100.0),
      labelSmallEmphasized: TypeStylePartial.from(rond: 100.0),
    ),
  );
}

abstract final class MarkdownThemeFactory {
  static MarkdownStyleSheet defaultStylesheetOf(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);

    return MarkdownStyleSheet(
      p: typescaleTheme.bodyMedium.toTextStyle(color: colorTheme.onSurface),
      a: TextStyle(color: colorTheme.primary),
      h3: typescaleTheme.headlineSmall.toTextStyle(color: colorTheme.onSurface),
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: const TextStyle(fontWeight: FontWeight.bold),
      del: const TextStyle(decoration: TextDecoration.lineThrough),
    );
  }
}

extension on DynamicSchemeVariant {
  Variant _toVariant() => switch (this) {
    DynamicSchemeVariant.monochrome => Variant.monochrome,
    DynamicSchemeVariant.neutral => Variant.neutral,
    DynamicSchemeVariant.tonalSpot => Variant.tonalSpot,
    DynamicSchemeVariant.vibrant => Variant.vibrant,
    DynamicSchemeVariant.expressive => Variant.expressive,
    DynamicSchemeVariant.fidelity => Variant.fidelity,
    DynamicSchemeVariant.content => Variant.content,
    DynamicSchemeVariant.rainbow => Variant.rainbow,
    DynamicSchemeVariant.fruitSalad => Variant.fruitSalad,
  };
}

Color _harmonizeColor(Color designColor, Color sourceColor) {
  if (designColor == sourceColor) return designColor;
  return Color(Blend.harmonize(designColor.toARGB32(), sourceColor.toARGB32()));
}

extension on Color {
  Hct _toHct() => Hct.fromInt(toARGB32());

  Color _harmonizeWith(Color sourceColor) => _harmonizeColor(this, sourceColor);
}

// extension on ColorThemeDataPartial {
//   Color _harmonizeWithPrimary(Color designColor) {
//     final sourceColor = primary;
//     return sourceColor != null
//         ? designColor._harmonizeWith(sourceColor)
//         : designColor;
//   }
// }

enum ExtendedColorPalette { primary, secondary, tertiary }

abstract class ExtendedColor with Diagnosticable {
  const ExtendedColor();

  const factory ExtendedColor.from({
    required Color color,
    required Color onColor,
    required Color colorContainer,
    required Color onColorContainer,
    required Color colorFixed,
    required Color colorFixedDim,
    required Color onColorFixed,
    required Color onColorFixedVariant,
  }) = _ExtendedColor;

  factory ExtendedColor.fromDynamicScheme(
    DynamicScheme scheme, {
    ExtendedColorPalette palette = ExtendedColorPalette.primary,
  }) => switch (palette) {
    ExtendedColorPalette.primary => ExtendedColor.from(
      color: Color(scheme.primary),
      onColor: Color(scheme.onPrimary),
      colorContainer: Color(scheme.primaryContainer),
      onColorContainer: Color(scheme.onPrimaryContainer),
      colorFixed: Color(scheme.primaryFixed),
      colorFixedDim: Color(scheme.primaryFixedDim),
      onColorFixed: Color(scheme.onPrimaryFixed),
      onColorFixedVariant: Color(scheme.onPrimaryFixedVariant),
    ),
    ExtendedColorPalette.secondary => ExtendedColor.from(
      color: Color(scheme.secondary),
      onColor: Color(scheme.onSecondary),
      colorContainer: Color(scheme.secondaryContainer),
      onColorContainer: Color(scheme.onSecondaryContainer),
      colorFixed: Color(scheme.secondaryFixed),
      colorFixedDim: Color(scheme.secondaryFixedDim),
      onColorFixed: Color(scheme.onSecondaryFixed),
      onColorFixedVariant: Color(scheme.onSecondaryFixedVariant),
    ),
    ExtendedColorPalette.tertiary => ExtendedColor.from(
      color: Color(scheme.tertiary),
      onColor: Color(scheme.onTertiary),
      colorContainer: Color(scheme.tertiaryContainer),
      onColorContainer: Color(scheme.onTertiaryContainer),
      colorFixed: Color(scheme.tertiaryFixed),
      colorFixedDim: Color(scheme.tertiaryFixedDim),
      onColorFixed: Color(scheme.onTertiaryFixed),
      onColorFixedVariant: Color(scheme.onTertiaryFixedVariant),
    ),
  };

  factory ExtendedColor.fromSeed({
    required Color sourceColor,
    DynamicSchemeVariant variant = DynamicSchemeVariant.tonalSpot,
    required Brightness brightness,
    DynamicSchemePlatform platform = DynamicScheme.defaultPlatform,
    double contrastLevel = 0.0,
    DynamicSchemeSpecVersion? specVersion = DynamicScheme.defaultSpecVersion,
    Color? primaryPaletteKeyColor,
    Color? secondaryPaletteKeyColor,
    Color? tertiaryPaletteKeyColor,
    Color? neutralPaletteKeyColor,
    Color? neutralVariantPaletteKeyColor,
    Color? errorPaletteKeyColor,
    ExtendedColorPalette palette = ExtendedColorPalette.primary,
  }) => ExtendedColor.fromDynamicScheme(
    DynamicScheme.fromPalettesOrKeyColors(
      sourceColorHct: sourceColor._toHct(),
      variant: variant._toVariant(),
      isDark: brightness == Brightness.dark, // Always exhaustive
      platform: platform,
      contrastLevel: contrastLevel,
      specVersion: specVersion,
      primaryPaletteKeyColor: primaryPaletteKeyColor?._toHct(),
      secondaryPaletteKeyColor: secondaryPaletteKeyColor?._toHct(),
      tertiaryPaletteKeyColor: tertiaryPaletteKeyColor?._toHct(),
      neutralPaletteKeyColor: neutralPaletteKeyColor?._toHct(),
      neutralVariantPaletteKeyColor: neutralVariantPaletteKeyColor?._toHct(),
      errorPaletteKeyColor: errorPaletteKeyColor?._toHct(),
    ),
    palette: palette,
  );

  factory ExtendedColor.fromColorTheme(
    ColorThemeData colorTheme, {
    ExtendedColorPalette palette = ExtendedColorPalette.primary,
  }) => switch (palette) {
    ExtendedColorPalette.primary => ExtendedColor.from(
      color: colorTheme.primary,
      onColor: colorTheme.onPrimary,
      colorContainer: colorTheme.primaryContainer,
      onColorContainer: colorTheme.onPrimaryContainer,
      colorFixed: colorTheme.primaryFixed,
      colorFixedDim: colorTheme.primaryFixedDim,
      onColorFixed: colorTheme.onPrimaryFixed,
      onColorFixedVariant: colorTheme.onPrimaryFixedVariant,
    ),
    ExtendedColorPalette.secondary => ExtendedColor.from(
      color: colorTheme.secondary,
      onColor: colorTheme.onSecondary,
      colorContainer: colorTheme.secondaryContainer,
      onColorContainer: colorTheme.onSecondaryContainer,
      colorFixed: colorTheme.secondaryFixed,
      colorFixedDim: colorTheme.secondaryFixedDim,
      onColorFixed: colorTheme.onSecondaryFixed,
      onColorFixedVariant: colorTheme.onSecondaryFixedVariant,
    ),
    ExtendedColorPalette.tertiary => ExtendedColor.from(
      color: colorTheme.tertiary,
      onColor: colorTheme.onTertiary,
      colorContainer: colorTheme.tertiaryContainer,
      onColorContainer: colorTheme.onTertiaryContainer,
      colorFixed: colorTheme.tertiaryFixed,
      colorFixedDim: colorTheme.tertiaryFixedDim,
      onColorFixed: colorTheme.onTertiaryFixed,
      onColorFixedVariant: colorTheme.onTertiaryFixedVariant,
    ),
  };

  Color get color;
  Color get onColor;
  Color get colorContainer;
  Color get onColorContainer;
  Color get colorFixed;
  Color get colorFixedDim;
  Color get onColorFixed;
  Color get onColorFixedVariant;

  ExtendedColor copyWith({
    Color? color,
    Color? onColor,
    Color? colorContainer,
    Color? onColorContainer,
    Color? colorFixed,
    Color? colorFixedDim,
    Color? onColorFixed,
    Color? onColorFixedVariant,
  }) {
    if (color == null &&
        onColor == null &&
        colorContainer == null &&
        onColorContainer == null &&
        colorFixed == null &&
        colorFixedDim == null &&
        onColorFixed == null &&
        onColorFixedVariant == null) {
      return this;
    }
    return ExtendedColor.from(
      color: color ?? this.color,
      onColor: onColor ?? this.onColor,
      colorContainer: colorContainer ?? this.colorContainer,
      onColorContainer: onColorContainer ?? this.onColorContainer,
      colorFixed: colorFixed ?? this.colorFixed,
      colorFixedDim: colorFixedDim ?? this.colorFixedDim,
      onColorFixed: onColorFixed ?? this.onColorFixed,
      onColorFixedVariant: onColorFixedVariant ?? this.onColorFixedVariant,
    );
  }

  ExtendedColor harmonizeWith(Color sourceColor) => copyWith(
    color: color._harmonizeWith(sourceColor),
    onColor: onColor._harmonizeWith(sourceColor),
    colorContainer: colorContainer._harmonizeWith(sourceColor),
    onColorContainer: onColorContainer._harmonizeWith(sourceColor),
  );

  ExtendedColor harmonizeWithPrimary(ColorThemeDataPartial colorTheme) {
    final sourceColor = colorTheme.primary;
    return sourceColor != null ? harmonizeWith(sourceColor) : this;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is ExtendedColor &&
            color == other.color &&
            onColor == other.onColor &&
            colorContainer == other.colorContainer &&
            onColorContainer == other.onColorContainer &&
            colorFixed == other.colorFixed &&
            colorFixedDim == other.colorFixedDim &&
            onColorFixed == other.onColorFixed &&
            onColorFixedVariant == other.onColorFixedVariant;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    color,
    onColor,
    colorContainer,
    onColorContainer,
    colorFixed,
    colorFixedDim,
    onColorFixed,
    onColorFixedVariant,
  );
}

class _ExtendedColor extends ExtendedColor {
  const _ExtendedColor({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
    required this.colorFixed,
    required this.colorFixedDim,
    required this.onColorFixed,
    required this.onColorFixedVariant,
  });

  @override
  final Color color;

  @override
  final Color onColor;

  @override
  final Color colorContainer;

  @override
  final Color onColorContainer;

  @override
  final Color colorFixed;

  @override
  final Color colorFixedDim;

  @override
  final Color onColorFixed;

  @override
  final Color onColorFixedVariant;
}

abstract class SemanticColorsData with Diagnosticable {
  const SemanticColorsData();

  const factory SemanticColorsData.from({
    required ExtendedColor success,
    required ExtendedColor warning,
  }) = _SemanticColorsData;

  factory SemanticColorsData.fallback({
    DynamicSchemeVariant variant = DynamicSchemeVariant.tonalSpot,
    required Brightness brightness,
    DynamicSchemePlatform platform = DynamicScheme.defaultPlatform,
    double contrastLevel = 0.0,
    DynamicSchemeSpecVersion? specVersion = DynamicScheme.defaultSpecVersion,
  }) => SemanticColorsData.from(
    success: ExtendedColor.fromSeed(
      sourceColor: const Color(0xFF4E7D4D),
      variant: variant,
      brightness: brightness,
      platform: platform,
      contrastLevel: contrastLevel,
      specVersion: specVersion,
      palette: ExtendedColorPalette.primary,
    ),
    warning: ExtendedColor.fromSeed(
      sourceColor: const Color(0xFFFFC107),
      variant: variant,
      brightness: brightness,
      platform: platform,
      contrastLevel: contrastLevel,
      specVersion: specVersion,
      palette: ExtendedColorPalette.primary,
    ),
  );

  ExtendedColor get success;
  ExtendedColor get warning;

  SemanticColorsData copyWith({
    ExtendedColor? success,
    ExtendedColor? warning,
  }) {
    if (success == null && warning == null) {
      return this;
    }
    return SemanticColorsData.from(
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  SemanticColorsData harmonizeWith(Color sourceColor) =>
      SemanticColorsData.from(
        success: success.harmonizeWith(sourceColor),
        warning: warning.harmonizeWith(sourceColor),
      );

  SemanticColorsData harmonizeWithPrimary(ColorThemeDataPartial colorTheme) {
    final sourceColor = colorTheme.primary;
    return sourceColor != null ? harmonizeWith(sourceColor) : this;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is SemanticColorsData &&
            success == other.success &&
            warning == other.warning;
  }

  @override
  int get hashCode => Object.hash(runtimeType, success, warning);
}

class _SemanticColorsData extends SemanticColorsData {
  const _SemanticColorsData({required this.success, required this.warning});

  @override
  final ExtendedColor success;

  @override
  final ExtendedColor warning;
}
