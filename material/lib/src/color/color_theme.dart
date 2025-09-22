import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material/material_color_utilities.dart'
    show
        Hct,
        DynamicScheme,
        Variant,
        Platform,
        SpecVersion,
        Score,
        QuantizerResult,
        QuantizerCelebi;

typedef DynamicSchemePlatform = Platform;
typedef DynamicSchemeSpecVersion = SpecVersion;
typedef ColorSchemeLegacy = ColorScheme;

// TODO: replace with a typedef
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

extension on Color {
  Hct _toHct() => Hct.fromInt(toARGB32());
}

@immutable
abstract class ColorThemeDataPartial with Diagnosticable {
  const ColorThemeDataPartial();

  const factory ColorThemeDataPartial.from({
    Brightness? brightness,
    Color? primaryPaletteKeyColor,
    Color? secondaryPaletteKeyColor,
    Color? tertiaryPaletteKeyColor,
    Color? neutralPaletteKeyColor,
    Color? neutralVariantPaletteKeyColor,
    Color? errorPaletteKeyColor,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? inverseSurface,
    Color? inverseOnSurface,
    Color? shadow,
    Color? scrim,
    Color? surfaceTint,
    Color? primary,
    Color? primaryDim,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? inversePrimary,
    Color? secondary,
    Color? secondaryDim,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? tertiaryDim,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? errorDim,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? controlActivated,
    Color? controlNormal,
    Color? controlHighlight,
    Color? textPrimaryInverse,
    Color? textSecondaryAndTertiaryInverse,
    Color? textPrimaryInverseDisableOnly,
    Color? textSecondaryAndTertiaryInverseDisabled,
    Color? textHintInverse,
  }) = _ColorThemeDataPartial;

  const factory ColorThemeDataPartial.fromLegacy(
    ColorSchemeLegacy colorScheme,
  ) = _ColorThemeDataPartialFromLegacy;

  Brightness? get brightness;
  Color? get primaryPaletteKeyColor;
  Color? get secondaryPaletteKeyColor;
  Color? get tertiaryPaletteKeyColor;
  Color? get neutralPaletteKeyColor;
  Color? get neutralVariantPaletteKeyColor;
  Color? get errorPaletteKeyColor;
  Color? get background;
  Color? get onBackground;
  Color? get surface;
  Color? get surfaceDim;
  Color? get surfaceBright;
  Color? get surfaceContainerLowest;
  Color? get surfaceContainerLow;
  Color? get surfaceContainer;
  Color? get surfaceContainerHigh;
  Color? get surfaceContainerHighest;
  Color? get onSurface;
  Color? get surfaceVariant;
  Color? get onSurfaceVariant;
  Color? get outline;
  Color? get outlineVariant;
  Color? get inverseSurface;
  Color? get inverseOnSurface;
  Color? get shadow;
  Color? get scrim;
  Color? get surfaceTint;
  Color? get primary;
  Color? get primaryDim;
  Color? get onPrimary;
  Color? get primaryContainer;
  Color? get onPrimaryContainer;
  Color? get primaryFixed;
  Color? get primaryFixedDim;
  Color? get onPrimaryFixed;
  Color? get onPrimaryFixedVariant;
  Color? get inversePrimary;
  Color? get secondary;
  Color? get secondaryDim;
  Color? get onSecondary;
  Color? get secondaryContainer;
  Color? get onSecondaryContainer;
  Color? get secondaryFixed;
  Color? get secondaryFixedDim;
  Color? get onSecondaryFixed;
  Color? get onSecondaryFixedVariant;
  Color? get tertiary;
  Color? get tertiaryDim;
  Color? get onTertiary;
  Color? get tertiaryContainer;
  Color? get onTertiaryContainer;
  Color? get tertiaryFixed;
  Color? get tertiaryFixedDim;
  Color? get onTertiaryFixed;
  Color? get onTertiaryFixedVariant;
  Color? get error;
  Color? get errorDim;
  Color? get onError;
  Color? get errorContainer;
  Color? get onErrorContainer;
  Color? get controlActivated;
  Color? get controlNormal;
  Color? get controlHighlight;
  Color? get textPrimaryInverse;
  Color? get textSecondaryAndTertiaryInverse;
  Color? get textPrimaryInverseDisableOnly;
  Color? get textSecondaryAndTertiaryInverseDisabled;
  Color? get textHintInverse;

  ColorThemeDataPartial copyWith({
    Brightness? brightness,
    Color? primaryPaletteKeyColor,
    Color? secondaryPaletteKeyColor,
    Color? tertiaryPaletteKeyColor,
    Color? neutralPaletteKeyColor,
    Color? neutralVariantPaletteKeyColor,
    Color? errorPaletteKeyColor,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? inverseSurface,
    Color? inverseOnSurface,
    Color? shadow,
    Color? scrim,
    Color? surfaceTint,
    Color? primary,
    Color? primaryDim,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? inversePrimary,
    Color? secondary,
    Color? secondaryDim,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? tertiaryDim,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? errorDim,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? controlActivated,
    Color? controlNormal,
    Color? controlHighlight,
    Color? textPrimaryInverse,
    Color? textSecondaryAndTertiaryInverse,
    Color? textPrimaryInverseDisableOnly,
    Color? textSecondaryAndTertiaryInverseDisabled,
    Color? textHintInverse,
  }) {
    if (brightness == null &&
        primaryPaletteKeyColor == null &&
        secondaryPaletteKeyColor == null &&
        tertiaryPaletteKeyColor == null &&
        neutralPaletteKeyColor == null &&
        neutralVariantPaletteKeyColor == null &&
        errorPaletteKeyColor == null &&
        background == null &&
        onBackground == null &&
        surface == null &&
        surfaceDim == null &&
        surfaceBright == null &&
        surfaceContainerLowest == null &&
        surfaceContainerLow == null &&
        surfaceContainer == null &&
        surfaceContainerHigh == null &&
        surfaceContainerHighest == null &&
        onSurface == null &&
        surfaceVariant == null &&
        onSurfaceVariant == null &&
        outline == null &&
        outlineVariant == null &&
        inverseSurface == null &&
        inverseOnSurface == null &&
        shadow == null &&
        scrim == null &&
        surfaceTint == null &&
        primary == null &&
        primaryDim == null &&
        onPrimary == null &&
        primaryContainer == null &&
        onPrimaryContainer == null &&
        primaryFixed == null &&
        primaryFixedDim == null &&
        onPrimaryFixed == null &&
        onPrimaryFixedVariant == null &&
        inversePrimary == null &&
        secondary == null &&
        secondaryDim == null &&
        onSecondary == null &&
        secondaryContainer == null &&
        onSecondaryContainer == null &&
        secondaryFixed == null &&
        secondaryFixedDim == null &&
        onSecondaryFixed == null &&
        onSecondaryFixedVariant == null &&
        tertiary == null &&
        tertiaryDim == null &&
        onTertiary == null &&
        tertiaryContainer == null &&
        onTertiaryContainer == null &&
        tertiaryFixed == null &&
        tertiaryFixedDim == null &&
        onTertiaryFixed == null &&
        onTertiaryFixedVariant == null &&
        error == null &&
        errorDim == null &&
        onError == null &&
        errorContainer == null &&
        onErrorContainer == null &&
        controlActivated == null &&
        controlNormal == null &&
        controlHighlight == null &&
        textPrimaryInverse == null &&
        textSecondaryAndTertiaryInverse == null &&
        textPrimaryInverseDisableOnly == null &&
        textSecondaryAndTertiaryInverseDisabled == null &&
        textHintInverse == null) {
      return this;
    }
    return ColorThemeDataPartial.from(
      brightness: brightness ?? this.brightness,
      primaryPaletteKeyColor:
          primaryPaletteKeyColor ?? this.primaryPaletteKeyColor,
      secondaryPaletteKeyColor:
          secondaryPaletteKeyColor ?? this.secondaryPaletteKeyColor,
      tertiaryPaletteKeyColor:
          tertiaryPaletteKeyColor ?? this.tertiaryPaletteKeyColor,
      neutralPaletteKeyColor:
          neutralPaletteKeyColor ?? this.neutralPaletteKeyColor,
      neutralVariantPaletteKeyColor:
          neutralVariantPaletteKeyColor ?? this.neutralVariantPaletteKeyColor,
      errorPaletteKeyColor: errorPaletteKeyColor ?? this.errorPaletteKeyColor,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      surfaceDim: surfaceDim ?? this.surfaceDim,
      surfaceBright: surfaceBright ?? this.surfaceBright,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      inverseOnSurface: inverseOnSurface ?? this.inverseOnSurface,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      primary: primary ?? this.primary,
      primaryDim: primaryDim ?? this.primaryDim,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      primaryFixed: primaryFixed ?? this.primaryFixed,
      primaryFixedDim: primaryFixedDim ?? this.primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed ?? this.onPrimaryFixed,
      onPrimaryFixedVariant:
          onPrimaryFixedVariant ?? this.onPrimaryFixedVariant,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      secondary: secondary ?? this.secondary,
      secondaryDim: secondaryDim ?? this.secondaryDim,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      secondaryFixed: secondaryFixed ?? this.secondaryFixed,
      secondaryFixedDim: secondaryFixedDim ?? this.secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed ?? this.onSecondaryFixed,
      onSecondaryFixedVariant:
          onSecondaryFixedVariant ?? this.onSecondaryFixedVariant,
      tertiary: tertiary ?? this.tertiary,
      tertiaryDim: tertiaryDim ?? this.tertiaryDim,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      tertiaryFixed: tertiaryFixed ?? this.tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim ?? this.tertiaryFixedDim,
      onTertiaryFixed: onTertiaryFixed ?? this.onTertiaryFixed,
      onTertiaryFixedVariant:
          onTertiaryFixedVariant ?? this.onTertiaryFixedVariant,
      error: error ?? this.error,
      errorDim: errorDim ?? this.errorDim,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      controlActivated: controlActivated ?? this.controlActivated,
      controlNormal: controlNormal ?? this.controlNormal,
      controlHighlight: controlHighlight ?? this.controlHighlight,
      textPrimaryInverse: textPrimaryInverse ?? this.textPrimaryInverse,
      textSecondaryAndTertiaryInverse:
          textSecondaryAndTertiaryInverse ??
          this.textSecondaryAndTertiaryInverse,
      textPrimaryInverseDisableOnly:
          textPrimaryInverseDisableOnly ?? this.textPrimaryInverseDisableOnly,
      textSecondaryAndTertiaryInverseDisabled:
          textSecondaryAndTertiaryInverseDisabled ??
          this.textSecondaryAndTertiaryInverseDisabled,
      textHintInverse: textHintInverse ?? this.textHintInverse,
    );
  }

  ColorThemeDataPartial merge(ColorThemeDataPartial? other) {
    if (other == null) return this;
    return copyWith(
      brightness: other.brightness,
      primaryPaletteKeyColor: other.primaryPaletteKeyColor,
      secondaryPaletteKeyColor: other.secondaryPaletteKeyColor,
      tertiaryPaletteKeyColor: other.tertiaryPaletteKeyColor,
      neutralPaletteKeyColor: other.neutralPaletteKeyColor,
      neutralVariantPaletteKeyColor: other.neutralVariantPaletteKeyColor,
      errorPaletteKeyColor: other.errorPaletteKeyColor,
      background: other.background,
      onBackground: other.onBackground,
      surface: other.surface,
      surfaceDim: other.surfaceDim,
      surfaceBright: other.surfaceBright,
      surfaceContainerLowest: other.surfaceContainerLowest,
      surfaceContainerLow: other.surfaceContainerLow,
      surfaceContainer: other.surfaceContainer,
      surfaceContainerHigh: other.surfaceContainerHigh,
      surfaceContainerHighest: other.surfaceContainerHighest,
      onSurface: other.onSurface,
      surfaceVariant: other.surfaceVariant,
      onSurfaceVariant: other.onSurfaceVariant,
      outline: other.outline,
      outlineVariant: other.outlineVariant,
      inverseSurface: other.inverseSurface,
      inverseOnSurface: other.inverseOnSurface,
      shadow: other.shadow,
      scrim: other.scrim,
      surfaceTint: other.surfaceTint,
      primary: other.primary,
      primaryDim: other.primaryDim,
      onPrimary: other.onPrimary,
      primaryContainer: other.primaryContainer,
      onPrimaryContainer: other.onPrimaryContainer,
      primaryFixed: other.primaryFixed,
      primaryFixedDim: other.primaryFixedDim,
      onPrimaryFixed: other.onPrimaryFixed,
      onPrimaryFixedVariant: other.onPrimaryFixedVariant,
      inversePrimary: other.inversePrimary,
      secondary: other.secondary,
      secondaryDim: other.secondaryDim,
      onSecondary: other.onSecondary,
      secondaryContainer: other.secondaryContainer,
      onSecondaryContainer: other.onSecondaryContainer,
      secondaryFixed: other.secondaryFixed,
      secondaryFixedDim: other.secondaryFixedDim,
      onSecondaryFixed: other.onSecondaryFixed,
      onSecondaryFixedVariant: other.onSecondaryFixedVariant,
      tertiary: other.tertiary,
      tertiaryDim: other.tertiaryDim,
      onTertiary: other.onTertiary,
      tertiaryContainer: other.tertiaryContainer,
      onTertiaryContainer: other.onTertiaryContainer,
      tertiaryFixed: other.tertiaryFixed,
      tertiaryFixedDim: other.tertiaryFixedDim,
      onTertiaryFixed: other.onTertiaryFixed,
      onTertiaryFixedVariant: other.onTertiaryFixedVariant,
      error: other.error,
      errorDim: other.errorDim,
      onError: other.onError,
      errorContainer: other.errorContainer,
      onErrorContainer: other.onErrorContainer,
      controlActivated: other.controlActivated,
      controlNormal: other.controlNormal,
      controlHighlight: other.controlHighlight,
      textPrimaryInverse: other.textPrimaryInverse,
      textSecondaryAndTertiaryInverse: other.textSecondaryAndTertiaryInverse,
      textPrimaryInverseDisableOnly: other.textPrimaryInverseDisableOnly,
      textSecondaryAndTertiaryInverseDisabled:
          other.textSecondaryAndTertiaryInverseDisabled,
      textHintInverse: other.textHintInverse,
    );
  }

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
      EnumProperty<Brightness>("brightness", brightness, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "primaryPaletteKeyColor",
        primaryPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "secondaryPaletteKeyColor",
        secondaryPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "tertiaryPaletteKeyColor",
        tertiaryPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "neutralPaletteKeyColor",
        neutralPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "neutralVariantPaletteKeyColor",
        neutralVariantPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "errorPaletteKeyColor",
        errorPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("background", background, defaultValue: null));
    properties.add(
      ColorProperty("onBackground", onBackground, defaultValue: null),
    );
    properties.add(ColorProperty("surface", surface, defaultValue: null));
    properties.add(ColorProperty("surfaceDim", surfaceDim, defaultValue: null));
    properties.add(
      ColorProperty("surfaceBright", surfaceBright, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerLowest",
        surfaceContainerLowest,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerLow",
        surfaceContainerLow,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("surfaceContainer", surfaceContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerHigh",
        surfaceContainerHigh,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerHighest",
        surfaceContainerHighest,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("onSurface", onSurface, defaultValue: null));
    properties.add(
      ColorProperty("surfaceVariant", surfaceVariant, defaultValue: null),
    );
    properties.add(
      ColorProperty("onSurfaceVariant", onSurfaceVariant, defaultValue: null),
    );
    properties.add(ColorProperty("outline", outline, defaultValue: null));
    properties.add(
      ColorProperty("outlineVariant", outlineVariant, defaultValue: null),
    );
    properties.add(
      ColorProperty("inverseSurface", inverseSurface, defaultValue: null),
    );
    properties.add(
      ColorProperty("inverseOnSurface", inverseOnSurface, defaultValue: null),
    );
    properties.add(ColorProperty("shadow", shadow, defaultValue: null));
    properties.add(ColorProperty("scrim", scrim, defaultValue: null));
    properties.add(
      ColorProperty("surfaceTint", surfaceTint, defaultValue: null),
    );
    properties.add(ColorProperty("primary", primary, defaultValue: null));
    properties.add(ColorProperty("primaryDim", primaryDim, defaultValue: null));
    properties.add(ColorProperty("onPrimary", onPrimary, defaultValue: null));
    properties.add(
      ColorProperty("primaryContainer", primaryContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onPrimaryContainer",
        onPrimaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("primaryFixed", primaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty("primaryFixedDim", primaryFixedDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onPrimaryFixed", onPrimaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onPrimaryFixedVariant",
        onPrimaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("inversePrimary", inversePrimary, defaultValue: null),
    );
    properties.add(ColorProperty("secondary", secondary, defaultValue: null));
    properties.add(
      ColorProperty("secondaryDim", secondaryDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onSecondary", onSecondary, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "secondaryContainer",
        secondaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "onSecondaryContainer",
        onSecondaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("secondaryFixed", secondaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty("secondaryFixedDim", secondaryFixedDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onSecondaryFixed", onSecondaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onSecondaryFixedVariant",
        onSecondaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("tertiary", tertiary, defaultValue: null));
    properties.add(
      ColorProperty("tertiaryDim", tertiaryDim, defaultValue: null),
    );
    properties.add(ColorProperty("onTertiary", onTertiary, defaultValue: null));
    properties.add(
      ColorProperty("tertiaryContainer", tertiaryContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onTertiaryContainer",
        onTertiaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("tertiaryFixed", tertiaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty("tertiaryFixedDim", tertiaryFixedDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onTertiaryFixed", onTertiaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onTertiaryFixedVariant",
        onTertiaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("error", error, defaultValue: null));
    properties.add(ColorProperty("errorDim", errorDim, defaultValue: null));
    properties.add(ColorProperty("onError", onError, defaultValue: null));
    properties.add(
      ColorProperty("errorContainer", errorContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty("onErrorContainer", onErrorContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty("controlActivated", controlActivated, defaultValue: null),
    );
    properties.add(
      ColorProperty("controlNormal", controlNormal, defaultValue: null),
    );
    properties.add(
      ColorProperty("controlHighlight", controlHighlight, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "textPrimaryInverse",
        textPrimaryInverse,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "textSecondaryAndTertiaryInverse",
        textSecondaryAndTertiaryInverse,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "textPrimaryInverseDisableOnly",
        textPrimaryInverseDisableOnly,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "textSecondaryAndTertiaryInverseDisabled",
        textSecondaryAndTertiaryInverseDisabled,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("textHintInverse", textHintInverse, defaultValue: null),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is ColorThemeDataPartial &&
            brightness == other.brightness &&
            primaryPaletteKeyColor == other.primaryPaletteKeyColor &&
            secondaryPaletteKeyColor == other.secondaryPaletteKeyColor &&
            tertiaryPaletteKeyColor == other.tertiaryPaletteKeyColor &&
            neutralPaletteKeyColor == other.neutralPaletteKeyColor &&
            neutralVariantPaletteKeyColor ==
                other.neutralVariantPaletteKeyColor &&
            errorPaletteKeyColor == other.errorPaletteKeyColor &&
            background == other.background &&
            onBackground == other.onBackground &&
            surface == other.surface &&
            surfaceDim == other.surfaceDim &&
            surfaceBright == other.surfaceBright &&
            surfaceContainerLowest == other.surfaceContainerLowest &&
            surfaceContainerLow == other.surfaceContainerLow &&
            surfaceContainer == other.surfaceContainer &&
            surfaceContainerHigh == other.surfaceContainerHigh &&
            surfaceContainerHighest == other.surfaceContainerHighest &&
            onSurface == other.onSurface &&
            surfaceVariant == other.surfaceVariant &&
            onSurfaceVariant == other.onSurfaceVariant &&
            outline == other.outline &&
            outlineVariant == other.outlineVariant &&
            inverseSurface == other.inverseSurface &&
            inverseOnSurface == other.inverseOnSurface &&
            shadow == other.shadow &&
            scrim == other.scrim &&
            surfaceTint == other.surfaceTint &&
            primary == other.primary &&
            primaryDim == other.primaryDim &&
            onPrimary == other.onPrimary &&
            primaryContainer == other.primaryContainer &&
            onPrimaryContainer == other.onPrimaryContainer &&
            primaryFixed == other.primaryFixed &&
            primaryFixedDim == other.primaryFixedDim &&
            onPrimaryFixed == other.onPrimaryFixed &&
            onPrimaryFixedVariant == other.onPrimaryFixedVariant &&
            inversePrimary == other.inversePrimary &&
            secondary == other.secondary &&
            secondaryDim == other.secondaryDim &&
            onSecondary == other.onSecondary &&
            secondaryContainer == other.secondaryContainer &&
            onSecondaryContainer == other.onSecondaryContainer &&
            secondaryFixed == other.secondaryFixed &&
            secondaryFixedDim == other.secondaryFixedDim &&
            onSecondaryFixed == other.onSecondaryFixed &&
            onSecondaryFixedVariant == other.onSecondaryFixedVariant &&
            tertiary == other.tertiary &&
            tertiaryDim == other.tertiaryDim &&
            onTertiary == other.onTertiary &&
            tertiaryContainer == other.tertiaryContainer &&
            onTertiaryContainer == other.onTertiaryContainer &&
            tertiaryFixed == other.tertiaryFixed &&
            tertiaryFixedDim == other.tertiaryFixedDim &&
            onTertiaryFixed == other.onTertiaryFixed &&
            onTertiaryFixedVariant == other.onTertiaryFixedVariant &&
            error == other.error &&
            errorDim == other.errorDim &&
            onError == other.onError &&
            errorContainer == other.errorContainer &&
            onErrorContainer == other.onErrorContainer &&
            controlActivated == other.controlActivated &&
            controlNormal == other.controlNormal &&
            controlHighlight == other.controlHighlight &&
            textPrimaryInverse == other.textPrimaryInverse &&
            textSecondaryAndTertiaryInverse ==
                other.textSecondaryAndTertiaryInverse &&
            textPrimaryInverseDisableOnly ==
                other.textPrimaryInverseDisableOnly &&
            textSecondaryAndTertiaryInverseDisabled ==
                other.textSecondaryAndTertiaryInverseDisabled &&
            textHintInverse == other.textHintInverse;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    brightness,
    primaryPaletteKeyColor,
    secondaryPaletteKeyColor,
    tertiaryPaletteKeyColor,
    neutralPaletteKeyColor,
    neutralVariantPaletteKeyColor,
    errorPaletteKeyColor,
    background,
    onBackground,
    surface,
    surfaceDim,
    surfaceBright,
    surfaceContainerLowest,
    surfaceContainerLow,
    surfaceContainer,
    surfaceContainerHigh,
    surfaceContainerHighest,
    onSurface,
    Object.hash(
      surfaceVariant,
      onSurfaceVariant,
      outline,
      outlineVariant,
      inverseSurface,
      inverseOnSurface,
      shadow,
      scrim,
      surfaceTint,
      primary,
      primaryDim,
      onPrimary,
      primaryContainer,
      onPrimaryContainer,
      primaryFixed,
      primaryFixedDim,
      onPrimaryFixed,
      onPrimaryFixedVariant,
      inversePrimary,
      Object.hash(
        secondary,
        secondaryDim,
        onSecondary,
        secondaryContainer,
        onSecondaryContainer,
        secondaryFixed,
        secondaryFixedDim,
        onSecondaryFixed,
        onSecondaryFixedVariant,
        tertiary,
        tertiaryDim,
        onTertiary,
        tertiaryContainer,
        onTertiaryContainer,
        tertiaryFixed,
        tertiaryFixedDim,
        onTertiaryFixed,
        onTertiaryFixedVariant,
        error,
        Object.hash(
          errorDim,
          onError,
          errorContainer,
          onErrorContainer,
          controlActivated,
          controlNormal,
          controlHighlight,
          textPrimaryInverse,
          textSecondaryAndTertiaryInverse,
          textPrimaryInverseDisableOnly,
          textSecondaryAndTertiaryInverseDisabled,
          textHintInverse,
        ),
      ),
    ),
  );
}

@immutable
class _ColorThemeDataPartial extends ColorThemeDataPartial {
  const _ColorThemeDataPartial({
    this.brightness,
    this.primaryPaletteKeyColor,
    this.secondaryPaletteKeyColor,
    this.tertiaryPaletteKeyColor,
    this.neutralPaletteKeyColor,
    this.neutralVariantPaletteKeyColor,
    this.errorPaletteKeyColor,
    this.background,
    this.onBackground,
    this.surface,
    this.surfaceDim,
    this.surfaceBright,
    this.surfaceContainerLowest,
    this.surfaceContainerLow,
    this.surfaceContainer,
    this.surfaceContainerHigh,
    this.surfaceContainerHighest,
    this.onSurface,
    this.surfaceVariant,
    this.onSurfaceVariant,
    this.outline,
    this.outlineVariant,
    this.inverseSurface,
    this.inverseOnSurface,
    this.shadow,
    this.scrim,
    this.surfaceTint,
    this.primary,
    this.primaryDim,
    this.onPrimary,
    this.primaryContainer,
    this.onPrimaryContainer,
    this.primaryFixed,
    this.primaryFixedDim,
    this.onPrimaryFixed,
    this.onPrimaryFixedVariant,
    this.inversePrimary,
    this.secondary,
    this.secondaryDim,
    this.onSecondary,
    this.secondaryContainer,
    this.onSecondaryContainer,
    this.secondaryFixed,
    this.secondaryFixedDim,
    this.onSecondaryFixed,
    this.onSecondaryFixedVariant,
    this.tertiary,
    this.tertiaryDim,
    this.onTertiary,
    this.tertiaryContainer,
    this.onTertiaryContainer,
    this.tertiaryFixed,
    this.tertiaryFixedDim,
    this.onTertiaryFixed,
    this.onTertiaryFixedVariant,
    this.error,
    this.errorDim,
    this.onError,
    this.errorContainer,
    this.onErrorContainer,
    this.controlActivated,
    this.controlNormal,
    this.controlHighlight,
    this.textPrimaryInverse,
    this.textSecondaryAndTertiaryInverse,
    this.textPrimaryInverseDisableOnly,
    this.textSecondaryAndTertiaryInverseDisabled,
    this.textHintInverse,
  });

  @override
  final Brightness? brightness;

  @override
  final Color? primaryPaletteKeyColor;

  @override
  final Color? secondaryPaletteKeyColor;

  @override
  final Color? tertiaryPaletteKeyColor;

  @override
  final Color? neutralPaletteKeyColor;

  @override
  final Color? neutralVariantPaletteKeyColor;

  @override
  final Color? errorPaletteKeyColor;

  @override
  final Color? background;

  @override
  final Color? onBackground;

  @override
  final Color? surface;

  @override
  final Color? surfaceDim;

  @override
  final Color? surfaceBright;

  @override
  final Color? surfaceContainerLowest;

  @override
  final Color? surfaceContainerLow;

  @override
  final Color? surfaceContainer;

  @override
  final Color? surfaceContainerHigh;

  @override
  final Color? surfaceContainerHighest;

  @override
  final Color? onSurface;

  @override
  final Color? surfaceVariant;

  @override
  final Color? onSurfaceVariant;

  @override
  final Color? outline;

  @override
  final Color? outlineVariant;

  @override
  final Color? inverseSurface;

  @override
  final Color? inverseOnSurface;

  @override
  final Color? shadow;

  @override
  final Color? scrim;

  @override
  final Color? surfaceTint;

  @override
  final Color? primary;

  @override
  final Color? primaryDim;

  @override
  final Color? onPrimary;

  @override
  final Color? primaryContainer;

  @override
  final Color? onPrimaryContainer;

  @override
  final Color? primaryFixed;

  @override
  final Color? primaryFixedDim;

  @override
  final Color? onPrimaryFixed;

  @override
  final Color? onPrimaryFixedVariant;

  @override
  final Color? inversePrimary;

  @override
  final Color? secondary;

  @override
  final Color? secondaryDim;

  @override
  final Color? onSecondary;

  @override
  final Color? secondaryContainer;

  @override
  final Color? onSecondaryContainer;

  @override
  final Color? secondaryFixed;

  @override
  final Color? secondaryFixedDim;

  @override
  final Color? onSecondaryFixed;

  @override
  final Color? onSecondaryFixedVariant;

  @override
  final Color? tertiary;

  @override
  final Color? tertiaryDim;

  @override
  final Color? onTertiary;

  @override
  final Color? tertiaryContainer;

  @override
  final Color? onTertiaryContainer;

  @override
  final Color? tertiaryFixed;

  @override
  final Color? tertiaryFixedDim;

  @override
  final Color? onTertiaryFixed;

  @override
  final Color? onTertiaryFixedVariant;

  @override
  final Color? error;

  @override
  final Color? errorDim;

  @override
  final Color? onError;

  @override
  final Color? errorContainer;

  @override
  final Color? onErrorContainer;

  @override
  final Color? controlActivated;

  @override
  final Color? controlNormal;

  @override
  final Color? controlHighlight;

  @override
  final Color? textPrimaryInverse;

  @override
  final Color? textSecondaryAndTertiaryInverse;

  @override
  final Color? textPrimaryInverseDisableOnly;

  @override
  final Color? textSecondaryAndTertiaryInverseDisabled;

  @override
  final Color? textHintInverse;
}

@immutable
class _ColorThemeDataPartialFromLegacy extends ColorThemeDataPartial {
  const _ColorThemeDataPartialFromLegacy(
    ColorSchemeLegacy colorScheme, {
    Brightness? brightness,
    Color? primaryPaletteKeyColor,
    Color? secondaryPaletteKeyColor,
    Color? tertiaryPaletteKeyColor,
    Color? neutralPaletteKeyColor,
    Color? neutralVariantPaletteKeyColor,
    Color? errorPaletteKeyColor,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? inverseSurface,
    Color? inverseOnSurface,
    Color? shadow,
    Color? scrim,
    Color? surfaceTint,
    Color? primary,
    Color? primaryDim,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? inversePrimary,
    Color? secondary,
    Color? secondaryDim,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? tertiaryDim,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? errorDim,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? controlActivated,
    Color? controlNormal,
    Color? controlHighlight,
    Color? textPrimaryInverse,
    Color? textSecondaryAndTertiaryInverse,
    Color? textPrimaryInverseDisableOnly,
    Color? textSecondaryAndTertiaryInverseDisabled,
    Color? textHintInverse,
  }) : _colorScheme = colorScheme,
       _brightness = brightness,
       _primaryPaletteKeyColor = primaryPaletteKeyColor,
       _secondaryPaletteKeyColor = secondaryPaletteKeyColor,
       _tertiaryPaletteKeyColor = tertiaryPaletteKeyColor,
       _neutralPaletteKeyColor = neutralPaletteKeyColor,
       _neutralVariantPaletteKeyColor = neutralVariantPaletteKeyColor,
       _errorPaletteKeyColor = errorPaletteKeyColor,
       _background = background,
       _onBackground = onBackground,
       _surface = surface,
       _surfaceDim = surfaceDim,
       _surfaceBright = surfaceBright,
       _surfaceContainerLowest = surfaceContainerLowest,
       _surfaceContainerLow = surfaceContainerLow,
       _surfaceContainer = surfaceContainer,
       _surfaceContainerHigh = surfaceContainerHigh,
       _surfaceContainerHighest = surfaceContainerHighest,
       _onSurface = onSurface,
       _surfaceVariant = surfaceVariant,
       _onSurfaceVariant = onSurfaceVariant,
       _outline = outline,
       _outlineVariant = outlineVariant,
       _inverseSurface = inverseSurface,
       _inverseOnSurface = inverseOnSurface,
       _shadow = shadow,
       _scrim = scrim,
       _surfaceTint = surfaceTint,
       _primary = primary,
       _primaryDim = primaryDim,
       _onPrimary = onPrimary,
       _primaryContainer = primaryContainer,
       _onPrimaryContainer = onPrimaryContainer,
       _primaryFixed = primaryFixed,
       _primaryFixedDim = primaryFixedDim,
       _onPrimaryFixed = onPrimaryFixed,
       _onPrimaryFixedVariant = onPrimaryFixedVariant,
       _inversePrimary = inversePrimary,
       _secondary = secondary,
       _secondaryDim = secondaryDim,
       _onSecondary = onSecondary,
       _secondaryContainer = secondaryContainer,
       _onSecondaryContainer = onSecondaryContainer,
       _secondaryFixed = secondaryFixed,
       _secondaryFixedDim = secondaryFixedDim,
       _onSecondaryFixed = onSecondaryFixed,
       _onSecondaryFixedVariant = onSecondaryFixedVariant,
       _tertiary = tertiary,
       _tertiaryDim = tertiaryDim,
       _onTertiary = onTertiary,
       _tertiaryContainer = tertiaryContainer,
       _onTertiaryContainer = onTertiaryContainer,
       _tertiaryFixed = tertiaryFixed,
       _tertiaryFixedDim = tertiaryFixedDim,
       _onTertiaryFixed = onTertiaryFixed,
       _onTertiaryFixedVariant = onTertiaryFixedVariant,
       _error = error,
       _errorDim = errorDim,
       _onError = onError,
       _errorContainer = errorContainer,
       _onErrorContainer = onErrorContainer,
       _controlActivated = controlActivated,
       _controlNormal = controlNormal,
       _controlHighlight = controlHighlight,
       _textPrimaryInverse = textPrimaryInverse,
       _textSecondaryAndTertiaryInverse = textSecondaryAndTertiaryInverse,
       _textPrimaryInverseDisableOnly = textPrimaryInverseDisableOnly,
       _textSecondaryAndTertiaryInverseDisabled =
           textSecondaryAndTertiaryInverseDisabled,
       _textHintInverse = textHintInverse;

  final ColorSchemeLegacy _colorScheme;

  final Brightness? _brightness;
  final Color? _primaryPaletteKeyColor;
  final Color? _secondaryPaletteKeyColor;
  final Color? _tertiaryPaletteKeyColor;
  final Color? _neutralPaletteKeyColor;
  final Color? _neutralVariantPaletteKeyColor;
  final Color? _errorPaletteKeyColor;
  final Color? _background;
  final Color? _onBackground;
  final Color? _surface;
  final Color? _surfaceDim;
  final Color? _surfaceBright;
  final Color? _surfaceContainerLowest;
  final Color? _surfaceContainerLow;
  final Color? _surfaceContainer;
  final Color? _surfaceContainerHigh;
  final Color? _surfaceContainerHighest;
  final Color? _onSurface;
  final Color? _surfaceVariant;
  final Color? _onSurfaceVariant;
  final Color? _outline;
  final Color? _outlineVariant;
  final Color? _inverseSurface;
  final Color? _inverseOnSurface;
  final Color? _shadow;
  final Color? _scrim;
  final Color? _surfaceTint;
  final Color? _primary;
  final Color? _primaryDim;
  final Color? _onPrimary;
  final Color? _primaryContainer;
  final Color? _onPrimaryContainer;
  final Color? _primaryFixed;
  final Color? _primaryFixedDim;
  final Color? _onPrimaryFixed;
  final Color? _onPrimaryFixedVariant;
  final Color? _inversePrimary;
  final Color? _secondary;
  final Color? _secondaryDim;
  final Color? _onSecondary;
  final Color? _secondaryContainer;
  final Color? _onSecondaryContainer;
  final Color? _secondaryFixed;
  final Color? _secondaryFixedDim;
  final Color? _onSecondaryFixed;
  final Color? _onSecondaryFixedVariant;
  final Color? _tertiary;
  final Color? _tertiaryDim;
  final Color? _onTertiary;
  final Color? _tertiaryContainer;
  final Color? _onTertiaryContainer;
  final Color? _tertiaryFixed;
  final Color? _tertiaryFixedDim;
  final Color? _onTertiaryFixed;
  final Color? _onTertiaryFixedVariant;
  final Color? _error;
  final Color? _errorDim;
  final Color? _onError;
  final Color? _errorContainer;
  final Color? _onErrorContainer;
  final Color? _controlActivated;
  final Color? _controlNormal;
  final Color? _controlHighlight;
  final Color? _textPrimaryInverse;
  final Color? _textSecondaryAndTertiaryInverse;
  final Color? _textPrimaryInverseDisableOnly;
  final Color? _textSecondaryAndTertiaryInverseDisabled;
  final Color? _textHintInverse;

  @override
  Brightness? get brightness => _brightness ?? _colorScheme.brightness;

  @override
  Color? get primaryPaletteKeyColor => _primaryPaletteKeyColor;

  @override
  Color? get secondaryPaletteKeyColor => _secondaryPaletteKeyColor;

  @override
  Color? get tertiaryPaletteKeyColor => _tertiaryPaletteKeyColor;

  @override
  Color? get neutralPaletteKeyColor => _neutralPaletteKeyColor;

  @override
  Color? get neutralVariantPaletteKeyColor => _neutralVariantPaletteKeyColor;

  @override
  Color? get errorPaletteKeyColor => _errorPaletteKeyColor;

  @override
  // ignore: deprecated_member_use
  Color? get background => _background ?? _colorScheme.background;

  @override
  // ignore: deprecated_member_use
  Color? get onBackground => _onBackground ?? _colorScheme.onBackground;

  @override
  Color? get surface => _surface ?? _colorScheme.surface;

  @override
  Color? get surfaceDim => _surfaceDim ?? _colorScheme.surfaceDim;

  @override
  Color? get surfaceBright => _surfaceBright ?? _colorScheme.surfaceBright;

  @override
  Color? get surfaceContainerLowest =>
      _surfaceContainerLowest ?? _colorScheme.surfaceContainerLowest;

  @override
  Color? get surfaceContainerLow =>
      _surfaceContainerLow ?? _colorScheme.surfaceContainerLow;

  @override
  Color? get surfaceContainer =>
      _surfaceContainer ?? _colorScheme.surfaceContainer;

  @override
  Color? get surfaceContainerHigh =>
      _surfaceContainerHigh ?? _colorScheme.surfaceContainerHigh;

  @override
  Color? get surfaceContainerHighest =>
      _surfaceContainerHighest ?? _colorScheme.surfaceContainerHighest;

  @override
  Color? get onSurface => _onSurface ?? _colorScheme.onSurface;

  @override
  // ignore: deprecated_member_use
  Color? get surfaceVariant => _surfaceVariant ?? _colorScheme.surfaceVariant;

  @override
  Color? get onSurfaceVariant =>
      _onSurfaceVariant ?? _colorScheme.onSurfaceVariant;

  @override
  Color? get outline => _outline ?? _colorScheme.outline;

  @override
  Color? get outlineVariant => _outlineVariant ?? _colorScheme.outlineVariant;

  @override
  Color? get inverseSurface => _inverseSurface ?? _colorScheme.inverseSurface;

  @override
  Color? get inverseOnSurface =>
      _inverseOnSurface ?? _colorScheme.onInverseSurface;

  @override
  Color? get shadow => _shadow ?? _colorScheme.shadow;

  @override
  Color? get scrim => _scrim ?? _colorScheme.scrim;

  @override
  Color? get surfaceTint => _surfaceTint ?? _colorScheme.surfaceTint;

  @override
  Color? get primary => _primary ?? _colorScheme.primary;

  @override
  Color? get primaryDim => _primaryDim;

  @override
  Color? get onPrimary => _onPrimary ?? _colorScheme.onPrimary;

  @override
  Color? get primaryContainer =>
      _primaryContainer ?? _colorScheme.primaryContainer;

  @override
  Color? get onPrimaryContainer =>
      _onPrimaryContainer ?? _colorScheme.onPrimaryContainer;

  @override
  Color? get primaryFixed => _primaryFixed ?? _colorScheme.primaryFixed;

  @override
  Color? get primaryFixedDim =>
      _primaryFixedDim ?? _colorScheme.primaryFixedDim;

  @override
  Color? get onPrimaryFixed => _onPrimaryFixed ?? _colorScheme.onPrimaryFixed;

  @override
  Color? get onPrimaryFixedVariant =>
      _onPrimaryFixedVariant ?? _colorScheme.onPrimaryFixedVariant;

  @override
  Color? get inversePrimary => _inversePrimary ?? _colorScheme.inversePrimary;

  @override
  Color? get secondary => _secondary ?? _colorScheme.secondary;

  @override
  Color? get secondaryDim => _secondaryDim;

  @override
  Color? get onSecondary => _onSecondary ?? _colorScheme.onSecondary;

  @override
  Color? get secondaryContainer =>
      _secondaryContainer ?? _colorScheme.secondaryContainer;

  @override
  Color? get onSecondaryContainer =>
      _onSecondaryContainer ?? _colorScheme.onSecondaryContainer;

  @override
  Color? get secondaryFixed => _secondaryFixed ?? _colorScheme.secondaryFixed;

  @override
  Color? get secondaryFixedDim =>
      _secondaryFixedDim ?? _colorScheme.secondaryFixedDim;

  @override
  Color? get onSecondaryFixed =>
      _onSecondaryFixed ?? _colorScheme.onSecondaryFixed;

  @override
  Color? get onSecondaryFixedVariant =>
      _onSecondaryFixedVariant ?? _colorScheme.onSecondaryFixedVariant;

  @override
  Color? get tertiary => _tertiary ?? _colorScheme.tertiary;

  @override
  Color? get tertiaryDim => _tertiaryDim;

  @override
  Color? get onTertiary => _onTertiary ?? _colorScheme.onTertiary;

  @override
  Color? get tertiaryContainer =>
      _tertiaryContainer ?? _colorScheme.tertiaryContainer;

  @override
  Color? get onTertiaryContainer =>
      _onTertiaryContainer ?? _colorScheme.onTertiaryContainer;

  @override
  Color? get tertiaryFixed => _tertiaryFixed ?? _colorScheme.tertiaryFixed;

  @override
  Color? get tertiaryFixedDim =>
      _tertiaryFixedDim ?? _colorScheme.tertiaryFixedDim;

  @override
  Color? get onTertiaryFixed =>
      _onTertiaryFixed ?? _colorScheme.onTertiaryFixed;

  @override
  Color? get onTertiaryFixedVariant =>
      _onTertiaryFixedVariant ?? _colorScheme.onTertiaryFixedVariant;

  @override
  Color? get error => _error ?? _colorScheme.error;

  @override
  Color? get errorDim => _errorDim;

  @override
  Color? get onError => _onError ?? _colorScheme.onError;

  @override
  Color? get errorContainer => _errorContainer ?? _colorScheme.errorContainer;

  @override
  Color? get onErrorContainer =>
      _onErrorContainer ?? _colorScheme.onErrorContainer;

  @override
  Color? get controlActivated => _controlActivated;

  @override
  Color? get controlNormal => _controlNormal;

  @override
  Color? get controlHighlight => _controlHighlight;

  @override
  Color? get textPrimaryInverse => _textPrimaryInverse;

  @override
  Color? get textSecondaryAndTertiaryInverse =>
      _textSecondaryAndTertiaryInverse;

  @override
  Color? get textPrimaryInverseDisableOnly => _textPrimaryInverseDisableOnly;

  @override
  Color? get textSecondaryAndTertiaryInverseDisabled =>
      _textSecondaryAndTertiaryInverseDisabled;

  @override
  Color? get textHintInverse => _textHintInverse;

  @override
  ColorThemeDataPartial copyWith({
    Brightness? brightness,
    Color? primaryPaletteKeyColor,
    Color? secondaryPaletteKeyColor,
    Color? tertiaryPaletteKeyColor,
    Color? neutralPaletteKeyColor,
    Color? neutralVariantPaletteKeyColor,
    Color? errorPaletteKeyColor,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? inverseSurface,
    Color? inverseOnSurface,
    Color? shadow,
    Color? scrim,
    Color? surfaceTint,
    Color? primary,
    Color? primaryDim,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? inversePrimary,
    Color? secondary,
    Color? secondaryDim,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? tertiaryDim,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? errorDim,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? controlActivated,
    Color? controlNormal,
    Color? controlHighlight,
    Color? textPrimaryInverse,
    Color? textSecondaryAndTertiaryInverse,
    Color? textPrimaryInverseDisableOnly,
    Color? textSecondaryAndTertiaryInverseDisabled,
    Color? textHintInverse,
  }) {
    if (brightness == null &&
        primaryPaletteKeyColor == null &&
        secondaryPaletteKeyColor == null &&
        tertiaryPaletteKeyColor == null &&
        neutralPaletteKeyColor == null &&
        neutralVariantPaletteKeyColor == null &&
        errorPaletteKeyColor == null &&
        background == null &&
        onBackground == null &&
        surface == null &&
        surfaceDim == null &&
        surfaceBright == null &&
        surfaceContainerLowest == null &&
        surfaceContainerLow == null &&
        surfaceContainer == null &&
        surfaceContainerHigh == null &&
        surfaceContainerHighest == null &&
        onSurface == null &&
        surfaceVariant == null &&
        onSurfaceVariant == null &&
        outline == null &&
        outlineVariant == null &&
        inverseSurface == null &&
        inverseOnSurface == null &&
        shadow == null &&
        scrim == null &&
        surfaceTint == null &&
        primary == null &&
        primaryDim == null &&
        onPrimary == null &&
        primaryContainer == null &&
        onPrimaryContainer == null &&
        primaryFixed == null &&
        primaryFixedDim == null &&
        onPrimaryFixed == null &&
        onPrimaryFixedVariant == null &&
        inversePrimary == null &&
        secondary == null &&
        secondaryDim == null &&
        onSecondary == null &&
        secondaryContainer == null &&
        onSecondaryContainer == null &&
        secondaryFixed == null &&
        secondaryFixedDim == null &&
        onSecondaryFixed == null &&
        onSecondaryFixedVariant == null &&
        tertiary == null &&
        tertiaryDim == null &&
        onTertiary == null &&
        tertiaryContainer == null &&
        onTertiaryContainer == null &&
        tertiaryFixed == null &&
        tertiaryFixedDim == null &&
        onTertiaryFixed == null &&
        onTertiaryFixedVariant == null &&
        error == null &&
        errorDim == null &&
        onError == null &&
        errorContainer == null &&
        onErrorContainer == null &&
        controlActivated == null &&
        controlNormal == null &&
        controlHighlight == null &&
        textPrimaryInverse == null &&
        textSecondaryAndTertiaryInverse == null &&
        textPrimaryInverseDisableOnly == null &&
        textSecondaryAndTertiaryInverseDisabled == null &&
        textHintInverse == null) {
      return this;
    }
    if (brightness != null &&
        primaryPaletteKeyColor != null &&
        secondaryPaletteKeyColor != null &&
        tertiaryPaletteKeyColor != null &&
        neutralPaletteKeyColor != null &&
        neutralVariantPaletteKeyColor != null &&
        errorPaletteKeyColor != null &&
        background != null &&
        onBackground != null &&
        surface != null &&
        surfaceDim != null &&
        surfaceBright != null &&
        surfaceContainerLowest != null &&
        surfaceContainerLow != null &&
        surfaceContainer != null &&
        surfaceContainerHigh != null &&
        surfaceContainerHighest != null &&
        onSurface != null &&
        surfaceVariant != null &&
        onSurfaceVariant != null &&
        outline != null &&
        outlineVariant != null &&
        inverseSurface != null &&
        inverseOnSurface != null &&
        shadow != null &&
        scrim != null &&
        surfaceTint != null &&
        primary != null &&
        primaryDim != null &&
        onPrimary != null &&
        primaryContainer != null &&
        onPrimaryContainer != null &&
        primaryFixed != null &&
        primaryFixedDim != null &&
        onPrimaryFixed != null &&
        onPrimaryFixedVariant != null &&
        inversePrimary != null &&
        secondary != null &&
        secondaryDim != null &&
        onSecondary != null &&
        secondaryContainer != null &&
        onSecondaryContainer != null &&
        secondaryFixed != null &&
        secondaryFixedDim != null &&
        onSecondaryFixed != null &&
        onSecondaryFixedVariant != null &&
        tertiary != null &&
        tertiaryDim != null &&
        onTertiary != null &&
        tertiaryContainer != null &&
        onTertiaryContainer != null &&
        tertiaryFixed != null &&
        tertiaryFixedDim != null &&
        onTertiaryFixed != null &&
        onTertiaryFixedVariant != null &&
        error != null &&
        errorDim != null &&
        onError != null &&
        errorContainer != null &&
        onErrorContainer != null &&
        controlActivated != null &&
        controlNormal != null &&
        controlHighlight != null &&
        textPrimaryInverse != null &&
        textSecondaryAndTertiaryInverse != null &&
        textPrimaryInverseDisableOnly != null &&
        textSecondaryAndTertiaryInverseDisabled != null &&
        textHintInverse != null) {
      return ColorThemeData.from(
        brightness: brightness,
        primaryPaletteKeyColor: primaryPaletteKeyColor,
        secondaryPaletteKeyColor: secondaryPaletteKeyColor,
        tertiaryPaletteKeyColor: tertiaryPaletteKeyColor,
        neutralPaletteKeyColor: neutralPaletteKeyColor,
        neutralVariantPaletteKeyColor: neutralVariantPaletteKeyColor,
        errorPaletteKeyColor: errorPaletteKeyColor,
        background: background,
        onBackground: onBackground,
        surface: surface,
        surfaceDim: surfaceDim,
        surfaceBright: surfaceBright,
        surfaceContainerLowest: surfaceContainerLowest,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainer: surfaceContainer,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainerHighest: surfaceContainerHighest,
        onSurface: onSurface,
        surfaceVariant: surfaceVariant,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        inverseSurface: inverseSurface,
        inverseOnSurface: inverseOnSurface,
        shadow: shadow,
        scrim: scrim,
        surfaceTint: surfaceTint,
        primary: primary,
        primaryDim: primaryDim,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        primaryFixed: primaryFixed,
        primaryFixedDim: primaryFixedDim,
        onPrimaryFixed: onPrimaryFixed,
        onPrimaryFixedVariant: onPrimaryFixedVariant,
        inversePrimary: inversePrimary,
        secondary: secondary,
        secondaryDim: secondaryDim,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        secondaryFixed: secondaryFixed,
        secondaryFixedDim: secondaryFixedDim,
        onSecondaryFixed: onSecondaryFixed,
        onSecondaryFixedVariant: onSecondaryFixedVariant,
        tertiary: tertiary,
        tertiaryDim: tertiaryDim,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        tertiaryFixed: tertiaryFixed,
        tertiaryFixedDim: tertiaryFixedDim,
        onTertiaryFixed: onTertiaryFixed,
        onTertiaryFixedVariant: onTertiaryFixedVariant,
        error: error,
        errorDim: errorDim,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        controlActivated: controlActivated,
        controlNormal: controlNormal,
        controlHighlight: controlHighlight,
        textPrimaryInverse: textPrimaryInverse,
        textSecondaryAndTertiaryInverse: textSecondaryAndTertiaryInverse,
        textPrimaryInverseDisableOnly: textPrimaryInverseDisableOnly,
        textSecondaryAndTertiaryInverseDisabled:
            textSecondaryAndTertiaryInverseDisabled,
        textHintInverse: textHintInverse,
      );
    }
    return _ColorThemeDataPartialFromLegacy(
      _colorScheme,
      brightness: brightness,
      primaryPaletteKeyColor: primaryPaletteKeyColor,
      secondaryPaletteKeyColor: secondaryPaletteKeyColor,
      tertiaryPaletteKeyColor: tertiaryPaletteKeyColor,
      neutralPaletteKeyColor: neutralPaletteKeyColor,
      neutralVariantPaletteKeyColor: neutralVariantPaletteKeyColor,
      errorPaletteKeyColor: errorPaletteKeyColor,
      background: background,
      onBackground: onBackground,
      surface: surface,
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      inverseSurface: inverseSurface,
      inverseOnSurface: inverseOnSurface,
      shadow: shadow,
      scrim: scrim,
      surfaceTint: surfaceTint,
      primary: primary,
      primaryDim: primaryDim,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      primaryFixed: primaryFixed,
      primaryFixedDim: primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed,
      onPrimaryFixedVariant: onPrimaryFixedVariant,
      inversePrimary: inversePrimary,
      secondary: secondary,
      secondaryDim: secondaryDim,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      secondaryFixed: secondaryFixed,
      secondaryFixedDim: secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed,
      onSecondaryFixedVariant: onSecondaryFixedVariant,
      tertiary: tertiary,
      tertiaryDim: tertiaryDim,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      tertiaryFixed: tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim,
      onTertiaryFixed: onTertiaryFixed,
      onTertiaryFixedVariant: onTertiaryFixedVariant,
      error: error,
      errorDim: errorDim,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      controlActivated: controlActivated,
      controlNormal: controlNormal,
      controlHighlight: controlHighlight,
      textPrimaryInverse: textPrimaryInverse,
      textSecondaryAndTertiaryInverse: textSecondaryAndTertiaryInverse,
      textPrimaryInverseDisableOnly: textPrimaryInverseDisableOnly,
      textSecondaryAndTertiaryInverseDisabled:
          textSecondaryAndTertiaryInverseDisabled,
      textHintInverse: textHintInverse,
    );
  }

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
      DiagnosticsProperty<ColorSchemeLegacy>("color scheme", _colorScheme),
    );
    properties.add(
      EnumProperty<Brightness>("brightness", _brightness, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "primaryPaletteKeyColor",
        _primaryPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "secondaryPaletteKeyColor",
        _secondaryPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "tertiaryPaletteKeyColor",
        _tertiaryPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "neutralPaletteKeyColor",
        _neutralPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "neutralVariantPaletteKeyColor",
        _neutralVariantPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "errorPaletteKeyColor",
        _errorPaletteKeyColor,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("background", _background, defaultValue: null),
    );
    properties.add(
      ColorProperty("onBackground", _onBackground, defaultValue: null),
    );
    properties.add(ColorProperty("surface", _surface, defaultValue: null));
    properties.add(
      ColorProperty("surfaceDim", _surfaceDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("surfaceBright", _surfaceBright, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerLowest",
        _surfaceContainerLowest,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerLow",
        _surfaceContainerLow,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("surfaceContainer", _surfaceContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerHigh",
        _surfaceContainerHigh,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerHighest",
        _surfaceContainerHighest,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("onSurface", _onSurface, defaultValue: null));
    properties.add(
      ColorProperty("surfaceVariant", _surfaceVariant, defaultValue: null),
    );
    properties.add(
      ColorProperty("onSurfaceVariant", _onSurfaceVariant, defaultValue: null),
    );
    properties.add(ColorProperty("outline", _outline, defaultValue: null));
    properties.add(
      ColorProperty("outlineVariant", _outlineVariant, defaultValue: null),
    );
    properties.add(
      ColorProperty("inverseSurface", _inverseSurface, defaultValue: null),
    );
    properties.add(
      ColorProperty("inverseOnSurface", _inverseOnSurface, defaultValue: null),
    );
    properties.add(ColorProperty("shadow", _shadow, defaultValue: null));
    properties.add(ColorProperty("scrim", _scrim, defaultValue: null));
    properties.add(
      ColorProperty("surfaceTint", _surfaceTint, defaultValue: null),
    );
    properties.add(ColorProperty("primary", _primary, defaultValue: null));
    properties.add(
      ColorProperty("primaryDim", _primaryDim, defaultValue: null),
    );
    properties.add(ColorProperty("onPrimary", _onPrimary, defaultValue: null));
    properties.add(
      ColorProperty("primaryContainer", _primaryContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onPrimaryContainer",
        _onPrimaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("primaryFixed", _primaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty("primaryFixedDim", _primaryFixedDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onPrimaryFixed", _onPrimaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onPrimaryFixedVariant",
        _onPrimaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("inversePrimary", _inversePrimary, defaultValue: null),
    );
    properties.add(ColorProperty("secondary", _secondary, defaultValue: null));
    properties.add(
      ColorProperty("secondaryDim", _secondaryDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onSecondary", _onSecondary, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "secondaryContainer",
        _secondaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "onSecondaryContainer",
        _onSecondaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("secondaryFixed", _secondaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "secondaryFixedDim",
        _secondaryFixedDim,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("onSecondaryFixed", _onSecondaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onSecondaryFixedVariant",
        _onSecondaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("tertiary", _tertiary, defaultValue: null));
    properties.add(
      ColorProperty("tertiaryDim", _tertiaryDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onTertiary", _onTertiary, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "tertiaryContainer",
        _tertiaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "onTertiaryContainer",
        _onTertiaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("tertiaryFixed", _tertiaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty("tertiaryFixedDim", _tertiaryFixedDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onTertiaryFixed", _onTertiaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onTertiaryFixedVariant",
        _onTertiaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("error", _error, defaultValue: null));
    properties.add(ColorProperty("errorDim", _errorDim, defaultValue: null));
    properties.add(ColorProperty("onError", _onError, defaultValue: null));
    properties.add(
      ColorProperty("errorContainer", _errorContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty("onErrorContainer", _onErrorContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty("controlActivated", _controlActivated, defaultValue: null),
    );
    properties.add(
      ColorProperty("controlNormal", _controlNormal, defaultValue: null),
    );
    properties.add(
      ColorProperty("controlHighlight", _controlHighlight, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "textPrimaryInverse",
        _textPrimaryInverse,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "textSecondaryAndTertiaryInverse",
        _textSecondaryAndTertiaryInverse,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "textPrimaryInverseDisableOnly",
        _textPrimaryInverseDisableOnly,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "textSecondaryAndTertiaryInverseDisabled",
        _textSecondaryAndTertiaryInverseDisabled,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("textHintInverse", _textHintInverse, defaultValue: null),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is _ColorThemeDataPartialFromLegacy &&
            _colorScheme == other._colorScheme &&
            _brightness == other._brightness &&
            _primaryPaletteKeyColor == other._primaryPaletteKeyColor &&
            _secondaryPaletteKeyColor == other._secondaryPaletteKeyColor &&
            _tertiaryPaletteKeyColor == other._tertiaryPaletteKeyColor &&
            _neutralPaletteKeyColor == other._neutralPaletteKeyColor &&
            _neutralVariantPaletteKeyColor ==
                other._neutralVariantPaletteKeyColor &&
            _errorPaletteKeyColor == other._errorPaletteKeyColor &&
            _background == other._background &&
            _onBackground == other._onBackground &&
            _surface == other._surface &&
            _surfaceDim == other._surfaceDim &&
            _surfaceBright == other._surfaceBright &&
            _surfaceContainerLowest == other._surfaceContainerLowest &&
            _surfaceContainerLow == other._surfaceContainerLow &&
            _surfaceContainer == other._surfaceContainer &&
            _surfaceContainerHigh == other._surfaceContainerHigh &&
            _surfaceContainerHighest == other._surfaceContainerHighest &&
            _onSurface == other._onSurface &&
            _surfaceVariant == other._surfaceVariant &&
            _onSurfaceVariant == other._onSurfaceVariant &&
            _outline == other._outline &&
            _outlineVariant == other._outlineVariant &&
            _inverseSurface == other._inverseSurface &&
            _inverseOnSurface == other._inverseOnSurface &&
            _shadow == other._shadow &&
            _scrim == other._scrim &&
            _surfaceTint == other._surfaceTint &&
            _primary == other._primary &&
            _primaryDim == other._primaryDim &&
            _onPrimary == other._onPrimary &&
            _primaryContainer == other._primaryContainer &&
            _onPrimaryContainer == other._onPrimaryContainer &&
            _primaryFixed == other._primaryFixed &&
            _primaryFixedDim == other._primaryFixedDim &&
            _onPrimaryFixed == other._onPrimaryFixed &&
            _onPrimaryFixedVariant == other._onPrimaryFixedVariant &&
            _inversePrimary == other._inversePrimary &&
            _secondary == other._secondary &&
            _secondaryDim == other._secondaryDim &&
            _onSecondary == other._onSecondary &&
            _secondaryContainer == other._secondaryContainer &&
            _onSecondaryContainer == other._onSecondaryContainer &&
            _secondaryFixed == other._secondaryFixed &&
            _secondaryFixedDim == other._secondaryFixedDim &&
            _onSecondaryFixed == other._onSecondaryFixed &&
            _onSecondaryFixedVariant == other._onSecondaryFixedVariant &&
            _tertiary == other._tertiary &&
            _tertiaryDim == other._tertiaryDim &&
            _onTertiary == other._onTertiary &&
            _tertiaryContainer == other._tertiaryContainer &&
            _onTertiaryContainer == other._onTertiaryContainer &&
            _tertiaryFixed == other._tertiaryFixed &&
            _tertiaryFixedDim == other._tertiaryFixedDim &&
            _onTertiaryFixed == other._onTertiaryFixed &&
            _onTertiaryFixedVariant == other._onTertiaryFixedVariant &&
            _error == other._error &&
            _errorDim == other._errorDim &&
            _onError == other._onError &&
            _errorContainer == other._errorContainer &&
            _onErrorContainer == other._onErrorContainer &&
            _controlActivated == other._controlActivated &&
            _controlNormal == other._controlNormal &&
            _controlHighlight == other._controlHighlight &&
            _textPrimaryInverse == other._textPrimaryInverse &&
            _textSecondaryAndTertiaryInverse ==
                other._textSecondaryAndTertiaryInverse &&
            _textPrimaryInverseDisableOnly ==
                other._textPrimaryInverseDisableOnly &&
            _textSecondaryAndTertiaryInverseDisabled ==
                other._textSecondaryAndTertiaryInverseDisabled &&
            _textHintInverse == other._textHintInverse;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    _colorScheme,
    _brightness,
    _primaryPaletteKeyColor,
    _secondaryPaletteKeyColor,
    _tertiaryPaletteKeyColor,
    _neutralPaletteKeyColor,
    _neutralVariantPaletteKeyColor,
    _errorPaletteKeyColor,
    _background,
    _onBackground,
    _surface,
    _surfaceDim,
    _surfaceBright,
    _surfaceContainerLowest,
    _surfaceContainerLow,
    _surfaceContainer,
    _surfaceContainerHigh,
    _surfaceContainerHighest,
    Object.hash(
      _onSurface,
      _surfaceVariant,
      _onSurfaceVariant,
      _outline,
      _outlineVariant,
      _inverseSurface,
      _inverseOnSurface,
      _shadow,
      _scrim,
      _surfaceTint,
      _primary,
      _primaryDim,
      _onPrimary,
      _primaryContainer,
      _onPrimaryContainer,
      _primaryFixed,
      _primaryFixedDim,
      _onPrimaryFixed,
      _onPrimaryFixedVariant,
      Object.hash(
        _inversePrimary,
        _secondary,
        _secondaryDim,
        _onSecondary,
        _secondaryContainer,
        _onSecondaryContainer,
        _secondaryFixed,
        _secondaryFixedDim,
        _onSecondaryFixed,
        _onSecondaryFixedVariant,
        _tertiary,
        _tertiaryDim,
        _onTertiary,
        _tertiaryContainer,
        _onTertiaryContainer,
        _tertiaryFixed,
        _tertiaryFixedDim,
        _onTertiaryFixed,
        _onTertiaryFixedVariant,
        Object.hash(
          _error,
          _errorDim,
          _onError,
          _errorContainer,
          _onErrorContainer,
          _controlActivated,
          _controlNormal,
          _controlHighlight,
          _textPrimaryInverse,
          _textSecondaryAndTertiaryInverse,
          _textPrimaryInverseDisableOnly,
          _textSecondaryAndTertiaryInverseDisabled,
          _textHintInverse,
        ),
      ),
    ),
  );
}

@immutable
abstract class ColorThemeData extends ColorThemeDataPartial {
  const ColorThemeData();

  const factory ColorThemeData.from({
    required Brightness brightness,
    required Color primaryPaletteKeyColor,
    required Color secondaryPaletteKeyColor,
    required Color tertiaryPaletteKeyColor,
    required Color neutralPaletteKeyColor,
    required Color neutralVariantPaletteKeyColor,
    required Color errorPaletteKeyColor,
    required Color background,
    required Color onBackground,
    required Color surface,
    required Color surfaceDim,
    required Color surfaceBright,
    required Color surfaceContainerLowest,
    required Color surfaceContainerLow,
    required Color surfaceContainer,
    required Color surfaceContainerHigh,
    required Color surfaceContainerHighest,
    required Color onSurface,
    required Color surfaceVariant,
    required Color onSurfaceVariant,
    required Color outline,
    required Color outlineVariant,
    required Color inverseSurface,
    required Color inverseOnSurface,
    required Color shadow,
    required Color scrim,
    required Color surfaceTint,
    required Color primary,
    required Color primaryDim,
    required Color onPrimary,
    required Color primaryContainer,
    required Color onPrimaryContainer,
    required Color primaryFixed,
    required Color primaryFixedDim,
    required Color onPrimaryFixed,
    required Color onPrimaryFixedVariant,
    required Color inversePrimary,
    required Color secondary,
    required Color secondaryDim,
    required Color onSecondary,
    required Color secondaryContainer,
    required Color onSecondaryContainer,
    required Color secondaryFixed,
    required Color secondaryFixedDim,
    required Color onSecondaryFixed,
    required Color onSecondaryFixedVariant,
    required Color tertiary,
    required Color tertiaryDim,
    required Color onTertiary,
    required Color tertiaryContainer,
    required Color onTertiaryContainer,
    required Color tertiaryFixed,
    required Color tertiaryFixedDim,
    required Color onTertiaryFixed,
    required Color onTertiaryFixedVariant,
    required Color error,
    required Color errorDim,
    required Color onError,
    required Color errorContainer,
    required Color onErrorContainer,
    required Color controlActivated,
    required Color controlNormal,
    required Color controlHighlight,
    required Color textPrimaryInverse,
    required Color textSecondaryAndTertiaryInverse,
    required Color textPrimaryInverseDisableOnly,
    required Color textSecondaryAndTertiaryInverseDisabled,
    required Color textHintInverse,
  }) = _ColorThemeData;

  factory ColorThemeData.fromDynamicScheme(
    DynamicScheme scheme,
  ) => ColorThemeData.from(
    brightness: scheme.isDark ? Brightness.dark : Brightness.light,
    primaryPaletteKeyColor: Color(scheme.primaryPaletteKeyColor),
    secondaryPaletteKeyColor: Color(scheme.secondaryPaletteKeyColor),
    tertiaryPaletteKeyColor: Color(scheme.tertiaryPaletteKeyColor),
    neutralPaletteKeyColor: Color(scheme.neutralPaletteKeyColor),
    neutralVariantPaletteKeyColor: Color(scheme.neutralVariantPaletteKeyColor),
    errorPaletteKeyColor: Color(scheme.errorPaletteKeyColor),
    background: Color(scheme.background),
    onBackground: Color(scheme.onBackground),
    surface: Color(scheme.surface),
    surfaceDim: Color(scheme.surfaceDim),
    surfaceBright: Color(scheme.surfaceBright),
    surfaceContainerLowest: Color(scheme.surfaceContainerLowest),
    surfaceContainerLow: Color(scheme.surfaceContainerLow),
    surfaceContainer: Color(scheme.surfaceContainer),
    surfaceContainerHigh: Color(scheme.surfaceContainerHigh),
    surfaceContainerHighest: Color(scheme.surfaceContainerHighest),
    onSurface: Color(scheme.onSurface),
    surfaceVariant: Color(scheme.surfaceVariant),
    onSurfaceVariant: Color(scheme.onSurfaceVariant),
    outline: Color(scheme.outline),
    outlineVariant: Color(scheme.outlineVariant),
    inverseSurface: Color(scheme.inverseSurface),
    inverseOnSurface: Color(scheme.inverseOnSurface),
    shadow: Color(scheme.shadow),
    scrim: Color(scheme.scrim),
    surfaceTint: Color(scheme.surfaceTint),
    primary: Color(scheme.primary),
    primaryDim: Color(scheme.primaryDim),
    onPrimary: Color(scheme.onPrimary),
    primaryContainer: Color(scheme.primaryContainer),
    onPrimaryContainer: Color(scheme.onPrimaryContainer),
    primaryFixed: Color(scheme.primaryFixed),
    primaryFixedDim: Color(scheme.primaryFixedDim),
    onPrimaryFixed: Color(scheme.onPrimaryFixed),
    onPrimaryFixedVariant: Color(scheme.onPrimaryFixedVariant),
    inversePrimary: Color(scheme.inversePrimary),
    secondary: Color(scheme.secondary),
    secondaryDim: Color(scheme.secondaryDim),
    onSecondary: Color(scheme.onSecondary),
    secondaryContainer: Color(scheme.secondaryContainer),
    onSecondaryContainer: Color(scheme.onSecondaryContainer),
    secondaryFixed: Color(scheme.secondaryFixed),
    secondaryFixedDim: Color(scheme.secondaryFixedDim),
    onSecondaryFixed: Color(scheme.onSecondaryFixed),
    onSecondaryFixedVariant: Color(scheme.onSecondaryFixedVariant),
    tertiary: Color(scheme.tertiary),
    tertiaryDim: Color(scheme.tertiaryDim),
    onTertiary: Color(scheme.onTertiary),
    tertiaryContainer: Color(scheme.tertiaryContainer),
    onTertiaryContainer: Color(scheme.onTertiaryContainer),
    tertiaryFixed: Color(scheme.tertiaryFixed),
    tertiaryFixedDim: Color(scheme.tertiaryFixedDim),
    onTertiaryFixed: Color(scheme.onTertiaryFixed),
    onTertiaryFixedVariant: Color(scheme.onTertiaryFixedVariant),
    error: Color(scheme.error),
    errorDim: Color(scheme.errorDim),
    onError: Color(scheme.onError),
    errorContainer: Color(scheme.errorContainer),
    onErrorContainer: Color(scheme.onErrorContainer),
    controlActivated: Color(scheme.controlActivated),
    controlNormal: Color(scheme.controlNormal),
    controlHighlight: Color(scheme.controlHighlight),
    textPrimaryInverse: Color(scheme.textPrimaryInverse),
    textSecondaryAndTertiaryInverse: Color(
      scheme.textSecondaryAndTertiaryInverse,
    ),
    textPrimaryInverseDisableOnly: Color(scheme.textPrimaryInverseDisableOnly),
    textSecondaryAndTertiaryInverseDisabled: Color(
      scheme.textSecondaryAndTertiaryInverseDisabled,
    ),
    textHintInverse: Color(scheme.textHintInverse),
  );

  factory ColorThemeData.fromSeed({
    Color sourceColor = const Color(0xFF6750A4),
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
  }) {
    final isDark = brightness == Brightness.dark; // Always exhaustive
    final scheme = DynamicScheme.fromPalettesOrKeyColors(
      sourceColorHct: sourceColor._toHct(),
      variant: variant._toVariant(),
      isDark: isDark,
      platform: platform,
      contrastLevel: contrastLevel,
      specVersion: specVersion,
      primaryPaletteKeyColor: primaryPaletteKeyColor?._toHct(),
      secondaryPaletteKeyColor: secondaryPaletteKeyColor?._toHct(),
      tertiaryPaletteKeyColor: tertiaryPaletteKeyColor?._toHct(),
      neutralPaletteKeyColor: neutralPaletteKeyColor?._toHct(),
      neutralVariantPaletteKeyColor: neutralVariantPaletteKeyColor?._toHct(),
      errorPaletteKeyColor: errorPaletteKeyColor?._toHct(),
    );
    return ColorThemeData.fromDynamicScheme(scheme);
  }

  @override
  Brightness get brightness;

  @override
  Color get primaryPaletteKeyColor;

  @override
  Color get secondaryPaletteKeyColor;

  @override
  Color get tertiaryPaletteKeyColor;

  @override
  Color get neutralPaletteKeyColor;

  @override
  Color get neutralVariantPaletteKeyColor;

  @override
  Color get errorPaletteKeyColor;

  @override
  Color get background;

  @override
  Color get onBackground;

  @override
  Color get surface;

  @override
  Color get surfaceDim;

  @override
  Color get surfaceBright;

  @override
  Color get surfaceContainerLowest;

  @override
  Color get surfaceContainerLow;

  @override
  Color get surfaceContainer;

  @override
  Color get surfaceContainerHigh;

  @override
  Color get surfaceContainerHighest;

  @override
  Color get onSurface;

  @override
  Color get surfaceVariant;

  @override
  Color get onSurfaceVariant;

  @override
  Color get outline;

  @override
  Color get outlineVariant;

  @override
  Color get inverseSurface;

  @override
  Color get inverseOnSurface;

  @override
  Color get shadow;

  @override
  Color get scrim;

  @override
  Color get surfaceTint;

  @override
  Color get primary;

  @override
  Color get primaryDim;

  @override
  Color get onPrimary;

  @override
  Color get primaryContainer;

  @override
  Color get onPrimaryContainer;

  @override
  Color get primaryFixed;

  @override
  Color get primaryFixedDim;

  @override
  Color get onPrimaryFixed;

  @override
  Color get onPrimaryFixedVariant;

  @override
  Color get inversePrimary;

  @override
  Color get secondary;

  @override
  Color get secondaryDim;

  @override
  Color get onSecondary;

  @override
  Color get secondaryContainer;

  @override
  Color get onSecondaryContainer;

  @override
  Color get secondaryFixed;

  @override
  Color get secondaryFixedDim;

  @override
  Color get onSecondaryFixed;

  @override
  Color get onSecondaryFixedVariant;

  @override
  Color get tertiary;

  @override
  Color get tertiaryDim;

  @override
  Color get onTertiary;

  @override
  Color get tertiaryContainer;

  @override
  Color get onTertiaryContainer;

  @override
  Color get tertiaryFixed;

  @override
  Color get tertiaryFixedDim;

  @override
  Color get onTertiaryFixed;

  @override
  Color get onTertiaryFixedVariant;

  @override
  Color get error;

  @override
  Color get errorDim;

  @override
  Color get onError;

  @override
  Color get errorContainer;

  @override
  Color get onErrorContainer;

  @override
  Color get controlActivated;

  @override
  Color get controlNormal;

  @override
  Color get controlHighlight;

  @override
  Color get textPrimaryInverse;

  @override
  Color get textSecondaryAndTertiaryInverse;

  @override
  Color get textPrimaryInverseDisableOnly;

  @override
  Color get textSecondaryAndTertiaryInverseDisabled;

  @override
  Color get textHintInverse;

  @override
  ColorThemeData copyWith({
    Brightness? brightness,
    Color? primaryPaletteKeyColor,
    Color? secondaryPaletteKeyColor,
    Color? tertiaryPaletteKeyColor,
    Color? neutralPaletteKeyColor,
    Color? neutralVariantPaletteKeyColor,
    Color? errorPaletteKeyColor,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? inverseSurface,
    Color? inverseOnSurface,
    Color? shadow,
    Color? scrim,
    Color? surfaceTint,
    Color? primary,
    Color? primaryDim,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? inversePrimary,
    Color? secondary,
    Color? secondaryDim,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? tertiaryDim,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? errorDim,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? controlActivated,
    Color? controlNormal,
    Color? controlHighlight,
    Color? textPrimaryInverse,
    Color? textSecondaryAndTertiaryInverse,
    Color? textPrimaryInverseDisableOnly,
    Color? textSecondaryAndTertiaryInverseDisabled,
    Color? textHintInverse,
  }) {
    if (brightness == null &&
        primaryPaletteKeyColor == null &&
        secondaryPaletteKeyColor == null &&
        tertiaryPaletteKeyColor == null &&
        neutralPaletteKeyColor == null &&
        neutralVariantPaletteKeyColor == null &&
        errorPaletteKeyColor == null &&
        background == null &&
        onBackground == null &&
        surface == null &&
        surfaceDim == null &&
        surfaceBright == null &&
        surfaceContainerLowest == null &&
        surfaceContainerLow == null &&
        surfaceContainer == null &&
        surfaceContainerHigh == null &&
        surfaceContainerHighest == null &&
        onSurface == null &&
        surfaceVariant == null &&
        onSurfaceVariant == null &&
        outline == null &&
        outlineVariant == null &&
        inverseSurface == null &&
        inverseOnSurface == null &&
        shadow == null &&
        scrim == null &&
        surfaceTint == null &&
        primary == null &&
        primaryDim == null &&
        onPrimary == null &&
        primaryContainer == null &&
        onPrimaryContainer == null &&
        primaryFixed == null &&
        primaryFixedDim == null &&
        onPrimaryFixed == null &&
        onPrimaryFixedVariant == null &&
        inversePrimary == null &&
        secondary == null &&
        secondaryDim == null &&
        onSecondary == null &&
        secondaryContainer == null &&
        onSecondaryContainer == null &&
        secondaryFixed == null &&
        secondaryFixedDim == null &&
        onSecondaryFixed == null &&
        onSecondaryFixedVariant == null &&
        tertiary == null &&
        tertiaryDim == null &&
        onTertiary == null &&
        tertiaryContainer == null &&
        onTertiaryContainer == null &&
        tertiaryFixed == null &&
        tertiaryFixedDim == null &&
        onTertiaryFixed == null &&
        onTertiaryFixedVariant == null &&
        error == null &&
        errorDim == null &&
        onError == null &&
        errorContainer == null &&
        onErrorContainer == null &&
        controlActivated == null &&
        controlNormal == null &&
        controlHighlight == null &&
        textPrimaryInverse == null &&
        textSecondaryAndTertiaryInverse == null &&
        textPrimaryInverseDisableOnly == null &&
        textSecondaryAndTertiaryInverseDisabled == null &&
        textHintInverse == null) {
      return this;
    }
    return ColorThemeData.from(
      brightness: brightness ?? this.brightness,
      primaryPaletteKeyColor:
          primaryPaletteKeyColor ?? this.primaryPaletteKeyColor,
      secondaryPaletteKeyColor:
          secondaryPaletteKeyColor ?? this.secondaryPaletteKeyColor,
      tertiaryPaletteKeyColor:
          tertiaryPaletteKeyColor ?? this.tertiaryPaletteKeyColor,
      neutralPaletteKeyColor:
          neutralPaletteKeyColor ?? this.neutralPaletteKeyColor,
      neutralVariantPaletteKeyColor:
          neutralVariantPaletteKeyColor ?? this.neutralVariantPaletteKeyColor,
      errorPaletteKeyColor: errorPaletteKeyColor ?? this.errorPaletteKeyColor,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      surfaceDim: surfaceDim ?? this.surfaceDim,
      surfaceBright: surfaceBright ?? this.surfaceBright,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      inverseOnSurface: inverseOnSurface ?? this.inverseOnSurface,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      primary: primary ?? this.primary,
      primaryDim: primaryDim ?? this.primaryDim,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      primaryFixed: primaryFixed ?? this.primaryFixed,
      primaryFixedDim: primaryFixedDim ?? this.primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed ?? this.onPrimaryFixed,
      onPrimaryFixedVariant:
          onPrimaryFixedVariant ?? this.onPrimaryFixedVariant,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      secondary: secondary ?? this.secondary,
      secondaryDim: secondaryDim ?? this.secondaryDim,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      secondaryFixed: secondaryFixed ?? this.secondaryFixed,
      secondaryFixedDim: secondaryFixedDim ?? this.secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed ?? this.onSecondaryFixed,
      onSecondaryFixedVariant:
          onSecondaryFixedVariant ?? this.onSecondaryFixedVariant,
      tertiary: tertiary ?? this.tertiary,
      tertiaryDim: tertiaryDim ?? this.tertiaryDim,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      tertiaryFixed: tertiaryFixed ?? this.tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim ?? this.tertiaryFixedDim,
      onTertiaryFixed: onTertiaryFixed ?? this.onTertiaryFixed,
      onTertiaryFixedVariant:
          onTertiaryFixedVariant ?? this.onTertiaryFixedVariant,
      error: error ?? this.error,
      errorDim: errorDim ?? this.errorDim,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      controlActivated: controlActivated ?? this.controlActivated,
      controlNormal: controlNormal ?? this.controlNormal,
      controlHighlight: controlHighlight ?? this.controlHighlight,
      textPrimaryInverse: textPrimaryInverse ?? this.textPrimaryInverse,
      textSecondaryAndTertiaryInverse:
          textSecondaryAndTertiaryInverse ??
          this.textSecondaryAndTertiaryInverse,
      textPrimaryInverseDisableOnly:
          textPrimaryInverseDisableOnly ?? this.textPrimaryInverseDisableOnly,
      textSecondaryAndTertiaryInverseDisabled:
          textSecondaryAndTertiaryInverseDisabled ??
          this.textSecondaryAndTertiaryInverseDisabled,
      textHintInverse: textHintInverse ?? this.textHintInverse,
    );
  }

  @override
  ColorThemeData merge(ColorThemeDataPartial? other) {
    if (other == null) return this;
    return copyWith(
      brightness: other.brightness,
      primaryPaletteKeyColor: other.primaryPaletteKeyColor,
      secondaryPaletteKeyColor: other.secondaryPaletteKeyColor,
      tertiaryPaletteKeyColor: other.tertiaryPaletteKeyColor,
      neutralPaletteKeyColor: other.neutralPaletteKeyColor,
      neutralVariantPaletteKeyColor: other.neutralVariantPaletteKeyColor,
      errorPaletteKeyColor: other.errorPaletteKeyColor,
      background: other.background,
      onBackground: other.onBackground,
      surface: other.surface,
      surfaceDim: other.surfaceDim,
      surfaceBright: other.surfaceBright,
      surfaceContainerLowest: other.surfaceContainerLowest,
      surfaceContainerLow: other.surfaceContainerLow,
      surfaceContainer: other.surfaceContainer,
      surfaceContainerHigh: other.surfaceContainerHigh,
      surfaceContainerHighest: other.surfaceContainerHighest,
      onSurface: other.onSurface,
      surfaceVariant: other.surfaceVariant,
      onSurfaceVariant: other.onSurfaceVariant,
      outline: other.outline,
      outlineVariant: other.outlineVariant,
      inverseSurface: other.inverseSurface,
      inverseOnSurface: other.inverseOnSurface,
      shadow: other.shadow,
      scrim: other.scrim,
      surfaceTint: other.surfaceTint,
      primary: other.primary,
      primaryDim: other.primaryDim,
      onPrimary: other.onPrimary,
      primaryContainer: other.primaryContainer,
      onPrimaryContainer: other.onPrimaryContainer,
      primaryFixed: other.primaryFixed,
      primaryFixedDim: other.primaryFixedDim,
      onPrimaryFixed: other.onPrimaryFixed,
      onPrimaryFixedVariant: other.onPrimaryFixedVariant,
      inversePrimary: other.inversePrimary,
      secondary: other.secondary,
      secondaryDim: other.secondaryDim,
      onSecondary: other.onSecondary,
      secondaryContainer: other.secondaryContainer,
      onSecondaryContainer: other.onSecondaryContainer,
      secondaryFixed: other.secondaryFixed,
      secondaryFixedDim: other.secondaryFixedDim,
      onSecondaryFixed: other.onSecondaryFixed,
      onSecondaryFixedVariant: other.onSecondaryFixedVariant,
      tertiary: other.tertiary,
      tertiaryDim: other.tertiaryDim,
      onTertiary: other.onTertiary,
      tertiaryContainer: other.tertiaryContainer,
      onTertiaryContainer: other.onTertiaryContainer,
      tertiaryFixed: other.tertiaryFixed,
      tertiaryFixedDim: other.tertiaryFixedDim,
      onTertiaryFixed: other.onTertiaryFixed,
      onTertiaryFixedVariant: other.onTertiaryFixedVariant,
      error: other.error,
      errorDim: other.errorDim,
      onError: other.onError,
      errorContainer: other.errorContainer,
      onErrorContainer: other.onErrorContainer,
      controlActivated: other.controlActivated,
      controlNormal: other.controlNormal,
      controlHighlight: other.controlHighlight,
      textPrimaryInverse: other.textPrimaryInverse,
      textSecondaryAndTertiaryInverse: other.textSecondaryAndTertiaryInverse,
      textPrimaryInverseDisableOnly: other.textPrimaryInverseDisableOnly,
      textSecondaryAndTertiaryInverseDisabled:
          other.textSecondaryAndTertiaryInverseDisabled,
      textHintInverse: other.textHintInverse,
    );
  }

  ColorSchemeLegacy toLegacy() => _LegacyFromColorThemeData(this);

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(EnumProperty<Brightness>("brightness", brightness));
    properties.add(
      ColorProperty("primaryPaletteKeyColor", primaryPaletteKeyColor),
    );
    properties.add(
      ColorProperty("secondaryPaletteKeyColor", secondaryPaletteKeyColor),
    );
    properties.add(
      ColorProperty("tertiaryPaletteKeyColor", tertiaryPaletteKeyColor),
    );
    properties.add(
      ColorProperty("neutralPaletteKeyColor", neutralPaletteKeyColor),
    );
    properties.add(
      ColorProperty(
        "neutralVariantPaletteKeyColor",
        neutralVariantPaletteKeyColor,
      ),
    );
    properties.add(ColorProperty("errorPaletteKeyColor", errorPaletteKeyColor));
    properties.add(ColorProperty("background", background));
    properties.add(ColorProperty("onBackground", onBackground));
    properties.add(ColorProperty("surface", surface));
    properties.add(ColorProperty("surfaceDim", surfaceDim));
    properties.add(ColorProperty("surfaceBright", surfaceBright));
    properties.add(
      ColorProperty("surfaceContainerLowest", surfaceContainerLowest),
    );
    properties.add(ColorProperty("surfaceContainerLow", surfaceContainerLow));
    properties.add(ColorProperty("surfaceContainer", surfaceContainer));
    properties.add(ColorProperty("surfaceContainerHigh", surfaceContainerHigh));
    properties.add(
      ColorProperty("surfaceContainerHighest", surfaceContainerHighest),
    );
    properties.add(ColorProperty("onSurface", onSurface));
    properties.add(ColorProperty("surfaceVariant", surfaceVariant));
    properties.add(ColorProperty("onSurfaceVariant", onSurfaceVariant));
    properties.add(ColorProperty("outline", outline));
    properties.add(ColorProperty("outlineVariant", outlineVariant));
    properties.add(ColorProperty("inverseSurface", inverseSurface));
    properties.add(ColorProperty("inverseOnSurface", inverseOnSurface));
    properties.add(ColorProperty("shadow", shadow));
    properties.add(ColorProperty("scrim", scrim));
    properties.add(ColorProperty("surfaceTint", surfaceTint));
    properties.add(ColorProperty("primary", primary));
    properties.add(ColorProperty("primaryDim", primaryDim));
    properties.add(ColorProperty("onPrimary", onPrimary));
    properties.add(ColorProperty("primaryContainer", primaryContainer));
    properties.add(ColorProperty("onPrimaryContainer", onPrimaryContainer));
    properties.add(ColorProperty("primaryFixed", primaryFixed));
    properties.add(ColorProperty("primaryFixedDim", primaryFixedDim));
    properties.add(ColorProperty("onPrimaryFixed", onPrimaryFixed));
    properties.add(
      ColorProperty("onPrimaryFixedVariant", onPrimaryFixedVariant),
    );
    properties.add(ColorProperty("inversePrimary", inversePrimary));
    properties.add(ColorProperty("secondary", secondary));
    properties.add(ColorProperty("secondaryDim", secondaryDim));
    properties.add(ColorProperty("onSecondary", onSecondary));
    properties.add(ColorProperty("secondaryContainer", secondaryContainer));
    properties.add(ColorProperty("onSecondaryContainer", onSecondaryContainer));
    properties.add(ColorProperty("secondaryFixed", secondaryFixed));
    properties.add(ColorProperty("secondaryFixedDim", secondaryFixedDim));
    properties.add(ColorProperty("onSecondaryFixed", onSecondaryFixed));
    properties.add(
      ColorProperty("onSecondaryFixedVariant", onSecondaryFixedVariant),
    );
    properties.add(ColorProperty("tertiary", tertiary));
    properties.add(ColorProperty("tertiaryDim", tertiaryDim));
    properties.add(ColorProperty("onTertiary", onTertiary));
    properties.add(ColorProperty("tertiaryContainer", tertiaryContainer));
    properties.add(ColorProperty("onTertiaryContainer", onTertiaryContainer));
    properties.add(ColorProperty("tertiaryFixed", tertiaryFixed));
    properties.add(ColorProperty("tertiaryFixedDim", tertiaryFixedDim));
    properties.add(ColorProperty("onTertiaryFixed", onTertiaryFixed));
    properties.add(
      ColorProperty("onTertiaryFixedVariant", onTertiaryFixedVariant),
    );
    properties.add(ColorProperty("error", error));
    properties.add(ColorProperty("errorDim", errorDim));
    properties.add(ColorProperty("onError", onError));
    properties.add(ColorProperty("errorContainer", errorContainer));
    properties.add(ColorProperty("onErrorContainer", onErrorContainer));
    properties.add(ColorProperty("controlActivated", controlActivated));
    properties.add(ColorProperty("controlNormal", controlNormal));
    properties.add(ColorProperty("controlHighlight", controlHighlight));
    properties.add(ColorProperty("textPrimaryInverse", textPrimaryInverse));
    properties.add(
      ColorProperty(
        "textSecondaryAndTertiaryInverse",
        textSecondaryAndTertiaryInverse,
      ),
    );
    properties.add(
      ColorProperty(
        "textPrimaryInverseDisableOnly",
        textPrimaryInverseDisableOnly,
      ),
    );
    properties.add(
      ColorProperty(
        "textSecondaryAndTertiaryInverseDisabled",
        textSecondaryAndTertiaryInverseDisabled,
      ),
    );
    properties.add(ColorProperty("textHintInverse", textHintInverse));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is ColorThemeData &&
            brightness == other.brightness &&
            primaryPaletteKeyColor == other.primaryPaletteKeyColor &&
            secondaryPaletteKeyColor == other.secondaryPaletteKeyColor &&
            tertiaryPaletteKeyColor == other.tertiaryPaletteKeyColor &&
            neutralPaletteKeyColor == other.neutralPaletteKeyColor &&
            neutralVariantPaletteKeyColor ==
                other.neutralVariantPaletteKeyColor &&
            errorPaletteKeyColor == other.errorPaletteKeyColor &&
            background == other.background &&
            onBackground == other.onBackground &&
            surface == other.surface &&
            surfaceDim == other.surfaceDim &&
            surfaceBright == other.surfaceBright &&
            surfaceContainerLowest == other.surfaceContainerLowest &&
            surfaceContainerLow == other.surfaceContainerLow &&
            surfaceContainer == other.surfaceContainer &&
            surfaceContainerHigh == other.surfaceContainerHigh &&
            surfaceContainerHighest == other.surfaceContainerHighest &&
            onSurface == other.onSurface &&
            surfaceVariant == other.surfaceVariant &&
            onSurfaceVariant == other.onSurfaceVariant &&
            outline == other.outline &&
            outlineVariant == other.outlineVariant &&
            inverseSurface == other.inverseSurface &&
            inverseOnSurface == other.inverseOnSurface &&
            shadow == other.shadow &&
            scrim == other.scrim &&
            surfaceTint == other.surfaceTint &&
            primary == other.primary &&
            primaryDim == other.primaryDim &&
            onPrimary == other.onPrimary &&
            primaryContainer == other.primaryContainer &&
            onPrimaryContainer == other.onPrimaryContainer &&
            primaryFixed == other.primaryFixed &&
            primaryFixedDim == other.primaryFixedDim &&
            onPrimaryFixed == other.onPrimaryFixed &&
            onPrimaryFixedVariant == other.onPrimaryFixedVariant &&
            inversePrimary == other.inversePrimary &&
            secondary == other.secondary &&
            secondaryDim == other.secondaryDim &&
            onSecondary == other.onSecondary &&
            secondaryContainer == other.secondaryContainer &&
            onSecondaryContainer == other.onSecondaryContainer &&
            secondaryFixed == other.secondaryFixed &&
            secondaryFixedDim == other.secondaryFixedDim &&
            onSecondaryFixed == other.onSecondaryFixed &&
            onSecondaryFixedVariant == other.onSecondaryFixedVariant &&
            tertiary == other.tertiary &&
            tertiaryDim == other.tertiaryDim &&
            onTertiary == other.onTertiary &&
            tertiaryContainer == other.tertiaryContainer &&
            onTertiaryContainer == other.onTertiaryContainer &&
            tertiaryFixed == other.tertiaryFixed &&
            tertiaryFixedDim == other.tertiaryFixedDim &&
            onTertiaryFixed == other.onTertiaryFixed &&
            onTertiaryFixedVariant == other.onTertiaryFixedVariant &&
            error == other.error &&
            errorDim == other.errorDim &&
            onError == other.onError &&
            errorContainer == other.errorContainer &&
            onErrorContainer == other.onErrorContainer &&
            controlActivated == other.controlActivated &&
            controlNormal == other.controlNormal &&
            controlHighlight == other.controlHighlight &&
            textPrimaryInverse == other.textPrimaryInverse &&
            textSecondaryAndTertiaryInverse ==
                other.textSecondaryAndTertiaryInverse &&
            textPrimaryInverseDisableOnly ==
                other.textPrimaryInverseDisableOnly &&
            textSecondaryAndTertiaryInverseDisabled ==
                other.textSecondaryAndTertiaryInverseDisabled &&
            textHintInverse == other.textHintInverse;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    brightness,
    primaryPaletteKeyColor,
    secondaryPaletteKeyColor,
    tertiaryPaletteKeyColor,
    neutralPaletteKeyColor,
    neutralVariantPaletteKeyColor,
    errorPaletteKeyColor,
    background,
    onBackground,
    surface,
    surfaceDim,
    surfaceBright,
    surfaceContainerLowest,
    surfaceContainerLow,
    surfaceContainer,
    surfaceContainerHigh,
    surfaceContainerHighest,
    onSurface,
    Object.hash(
      surfaceVariant,
      onSurfaceVariant,
      outline,
      outlineVariant,
      inverseSurface,
      inverseOnSurface,
      shadow,
      scrim,
      surfaceTint,
      primary,
      primaryDim,
      onPrimary,
      primaryContainer,
      onPrimaryContainer,
      primaryFixed,
      primaryFixedDim,
      onPrimaryFixed,
      onPrimaryFixedVariant,
      inversePrimary,
      Object.hash(
        secondary,
        secondaryDim,
        onSecondary,
        secondaryContainer,
        onSecondaryContainer,
        secondaryFixed,
        secondaryFixedDim,
        onSecondaryFixed,
        onSecondaryFixedVariant,
        tertiary,
        tertiaryDim,
        onTertiary,
        tertiaryContainer,
        onTertiaryContainer,
        tertiaryFixed,
        tertiaryFixedDim,
        onTertiaryFixed,
        onTertiaryFixedVariant,
        error,
        Object.hash(
          errorDim,
          onError,
          errorContainer,
          onErrorContainer,
          controlActivated,
          controlNormal,
          controlHighlight,
          textPrimaryInverse,
          textSecondaryAndTertiaryInverse,
          textPrimaryInverseDisableOnly,
          textSecondaryAndTertiaryInverseDisabled,
          textHintInverse,
        ),
      ),
    ),
  );

  static Future<ColorThemeData> fromImage({
    required ImageProvider image,
    DynamicSchemeVariant variant = DynamicSchemeVariant.tonalSpot,
    required Brightness brightness,
    DynamicSchemePlatform platform = DynamicScheme.defaultPlatform,
    double contrastLevel = 0.0,
    DynamicSchemeSpecVersion? specVersion = DynamicScheme.defaultSpecVersion,
  }) async {
    final baseColor = await _contentBasedSourceColor(image);
    return ColorThemeData.fromSeed(
      sourceColor: baseColor,
      variant: variant,
      brightness: brightness,
      platform: platform,
      contrastLevel: contrastLevel,
      specVersion: specVersion,
    );
  }
}

@immutable
class _ColorThemeData extends ColorThemeData {
  const _ColorThemeData({
    required this.brightness,
    required this.primaryPaletteKeyColor,
    required this.secondaryPaletteKeyColor,
    required this.tertiaryPaletteKeyColor,
    required this.neutralPaletteKeyColor,
    required this.neutralVariantPaletteKeyColor,
    required this.errorPaletteKeyColor,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.shadow,
    required this.scrim,
    required this.surfaceTint,
    required this.primary,
    required this.primaryDim,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.primaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixed,
    required this.onPrimaryFixedVariant,
    required this.inversePrimary,
    required this.secondary,
    required this.secondaryDim,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.secondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixed,
    required this.onSecondaryFixedVariant,
    required this.tertiary,
    required this.tertiaryDim,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.tertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixed,
    required this.onTertiaryFixedVariant,
    required this.error,
    required this.errorDim,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.controlActivated,
    required this.controlNormal,
    required this.controlHighlight,
    required this.textPrimaryInverse,
    required this.textSecondaryAndTertiaryInverse,
    required this.textPrimaryInverseDisableOnly,
    required this.textSecondaryAndTertiaryInverseDisabled,
    required this.textHintInverse,
  });

  @override
  final Brightness brightness;

  @override
  final Color primaryPaletteKeyColor;

  @override
  final Color secondaryPaletteKeyColor;

  @override
  final Color tertiaryPaletteKeyColor;

  @override
  final Color neutralPaletteKeyColor;

  @override
  final Color neutralVariantPaletteKeyColor;

  @override
  final Color errorPaletteKeyColor;

  @override
  final Color background;

  @override
  final Color onBackground;

  @override
  final Color surface;

  @override
  final Color surfaceDim;

  @override
  final Color surfaceBright;

  @override
  final Color surfaceContainerLowest;

  @override
  final Color surfaceContainerLow;

  @override
  final Color surfaceContainer;

  @override
  final Color surfaceContainerHigh;

  @override
  final Color surfaceContainerHighest;

  @override
  final Color onSurface;

  @override
  final Color surfaceVariant;

  @override
  final Color onSurfaceVariant;

  @override
  final Color outline;

  @override
  final Color outlineVariant;

  @override
  final Color inverseSurface;

  @override
  final Color inverseOnSurface;

  @override
  final Color shadow;

  @override
  final Color scrim;

  @override
  final Color surfaceTint;

  @override
  final Color primary;

  @override
  final Color primaryDim;

  @override
  final Color onPrimary;

  @override
  final Color primaryContainer;

  @override
  final Color onPrimaryContainer;

  @override
  final Color primaryFixed;

  @override
  final Color primaryFixedDim;

  @override
  final Color onPrimaryFixed;

  @override
  final Color onPrimaryFixedVariant;

  @override
  final Color inversePrimary;

  @override
  final Color secondary;

  @override
  final Color secondaryDim;

  @override
  final Color onSecondary;

  @override
  final Color secondaryContainer;

  @override
  final Color onSecondaryContainer;

  @override
  final Color secondaryFixed;

  @override
  final Color secondaryFixedDim;

  @override
  final Color onSecondaryFixed;

  @override
  final Color onSecondaryFixedVariant;

  @override
  final Color tertiary;

  @override
  final Color tertiaryDim;

  @override
  final Color onTertiary;

  @override
  final Color tertiaryContainer;

  @override
  final Color onTertiaryContainer;

  @override
  final Color tertiaryFixed;

  @override
  final Color tertiaryFixedDim;

  @override
  final Color onTertiaryFixed;

  @override
  final Color onTertiaryFixedVariant;

  @override
  final Color error;

  @override
  final Color errorDim;

  @override
  final Color onError;

  @override
  final Color errorContainer;

  @override
  final Color onErrorContainer;

  @override
  final Color controlActivated;

  @override
  final Color controlNormal;

  @override
  final Color controlHighlight;

  @override
  final Color textPrimaryInverse;

  @override
  final Color textSecondaryAndTertiaryInverse;

  @override
  final Color textPrimaryInverseDisableOnly;

  @override
  final Color textSecondaryAndTertiaryInverseDisabled;

  @override
  final Color textHintInverse;
}

@immutable
class _LegacyFromColorThemeData
    with Diagnosticable
    implements ColorSchemeLegacy {
  const _LegacyFromColorThemeData(
    ColorThemeData colorTheme, {
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? surface,
    Color? onSurface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
    Color? background,
    Color? onBackground,
    Color? surfaceVariant,
  }) : _colorTheme = colorTheme,
       _brightness = brightness,
       _primary = primary,
       _onPrimary = onPrimary,
       _primaryContainer = primaryContainer,
       _onPrimaryContainer = onPrimaryContainer,
       _primaryFixed = primaryFixed,
       _primaryFixedDim = primaryFixedDim,
       _onPrimaryFixed = onPrimaryFixed,
       _onPrimaryFixedVariant = onPrimaryFixedVariant,
       _secondary = secondary,
       _onSecondary = onSecondary,
       _secondaryContainer = secondaryContainer,
       _onSecondaryContainer = onSecondaryContainer,
       _secondaryFixed = secondaryFixed,
       _secondaryFixedDim = secondaryFixedDim,
       _onSecondaryFixed = onSecondaryFixed,
       _onSecondaryFixedVariant = onSecondaryFixedVariant,
       _tertiary = tertiary,
       _onTertiary = onTertiary,
       _tertiaryContainer = tertiaryContainer,
       _onTertiaryContainer = onTertiaryContainer,
       _tertiaryFixed = tertiaryFixed,
       _tertiaryFixedDim = tertiaryFixedDim,
       _onTertiaryFixed = onTertiaryFixed,
       _onTertiaryFixedVariant = onTertiaryFixedVariant,
       _error = error,
       _onError = onError,
       _errorContainer = errorContainer,
       _onErrorContainer = onErrorContainer,
       _surface = surface,
       _onSurface = onSurface,
       _surfaceDim = surfaceDim,
       _surfaceBright = surfaceBright,
       _surfaceContainerLowest = surfaceContainerLowest,
       _surfaceContainerLow = surfaceContainerLow,
       _surfaceContainer = surfaceContainer,
       _surfaceContainerHigh = surfaceContainerHigh,
       _surfaceContainerHighest = surfaceContainerHighest,
       _onSurfaceVariant = onSurfaceVariant,
       _outline = outline,
       _outlineVariant = outlineVariant,
       _shadow = shadow,
       _scrim = scrim,
       _inverseSurface = inverseSurface,
       _onInverseSurface = onInverseSurface,
       _inversePrimary = inversePrimary,
       _surfaceTint = surfaceTint,
       _background = background,
       _onBackground = onBackground,
       _surfaceVariant = surfaceVariant;

  final ColorThemeData _colorTheme;
  final Brightness? _brightness;
  final Color? _primary;
  final Color? _onPrimary;
  final Color? _primaryContainer;
  final Color? _onPrimaryContainer;
  final Color? _primaryFixed;
  final Color? _primaryFixedDim;
  final Color? _onPrimaryFixed;
  final Color? _onPrimaryFixedVariant;
  final Color? _secondary;
  final Color? _onSecondary;
  final Color? _secondaryContainer;
  final Color? _onSecondaryContainer;
  final Color? _secondaryFixed;
  final Color? _secondaryFixedDim;
  final Color? _onSecondaryFixed;
  final Color? _onSecondaryFixedVariant;
  final Color? _tertiary;
  final Color? _onTertiary;
  final Color? _tertiaryContainer;
  final Color? _onTertiaryContainer;
  final Color? _tertiaryFixed;
  final Color? _tertiaryFixedDim;
  final Color? _onTertiaryFixed;
  final Color? _onTertiaryFixedVariant;
  final Color? _error;
  final Color? _onError;
  final Color? _errorContainer;
  final Color? _onErrorContainer;
  final Color? _surface;
  final Color? _onSurface;
  final Color? _surfaceDim;
  final Color? _surfaceBright;
  final Color? _surfaceContainerLowest;
  final Color? _surfaceContainerLow;
  final Color? _surfaceContainer;
  final Color? _surfaceContainerHigh;
  final Color? _surfaceContainerHighest;
  final Color? _onSurfaceVariant;
  final Color? _outline;
  final Color? _outlineVariant;
  final Color? _shadow;
  final Color? _scrim;
  final Color? _inverseSurface;
  final Color? _onInverseSurface;
  final Color? _inversePrimary;
  final Color? _surfaceTint;
  final Color? _background;
  final Color? _onBackground;
  final Color? _surfaceVariant;

  @override
  Brightness get brightness => _brightness ?? _colorTheme.brightness;

  @override
  Color get primary => _primary ?? _colorTheme.primary;

  @override
  Color get onPrimary => _onPrimary ?? _colorTheme.onPrimary;

  @override
  Color get primaryContainer =>
      _primaryContainer ?? _colorTheme.primaryContainer;

  @override
  Color get onPrimaryContainer =>
      _onPrimaryContainer ?? _colorTheme.onPrimaryContainer;

  @override
  Color get primaryFixed => _primaryFixed ?? _colorTheme.primaryFixed;

  @override
  Color get primaryFixedDim => _primaryFixedDim ?? _colorTheme.primaryFixedDim;

  @override
  Color get onPrimaryFixed => _onPrimaryFixed ?? _colorTheme.onPrimaryFixed;

  @override
  Color get onPrimaryFixedVariant =>
      _onPrimaryFixedVariant ?? _colorTheme.onPrimaryFixedVariant;

  @override
  Color get secondary => _secondary ?? _colorTheme.secondary;

  @override
  Color get onSecondary => _onSecondary ?? _colorTheme.onSecondary;

  @override
  Color get secondaryContainer =>
      _secondaryContainer ?? _colorTheme.secondaryContainer;

  @override
  Color get onSecondaryContainer =>
      _onSecondaryContainer ?? _colorTheme.onSecondaryContainer;

  @override
  Color get secondaryFixed => _secondaryFixed ?? _colorTheme.secondaryFixed;

  @override
  Color get secondaryFixedDim =>
      _secondaryFixedDim ?? _colorTheme.secondaryFixedDim;

  @override
  Color get onSecondaryFixed =>
      _onSecondaryFixed ?? _colorTheme.onSecondaryFixed;

  @override
  Color get onSecondaryFixedVariant =>
      _onSecondaryFixedVariant ?? _colorTheme.onSecondaryFixedVariant;

  @override
  Color get tertiary => _tertiary ?? _colorTheme.tertiary;

  @override
  Color get onTertiary => _onTertiary ?? _colorTheme.onTertiary;

  @override
  Color get tertiaryContainer =>
      _tertiaryContainer ?? _colorTheme.tertiaryContainer;

  @override
  Color get onTertiaryContainer =>
      _onTertiaryContainer ?? _colorTheme.onTertiaryContainer;

  @override
  Color get tertiaryFixed => _tertiaryFixed ?? _colorTheme.tertiaryFixed;

  @override
  Color get tertiaryFixedDim =>
      _tertiaryFixedDim ?? _colorTheme.tertiaryFixedDim;

  @override
  Color get onTertiaryFixed => _onTertiaryFixed ?? _colorTheme.onTertiaryFixed;

  @override
  Color get onTertiaryFixedVariant =>
      _onTertiaryFixedVariant ?? _colorTheme.onTertiaryFixedVariant;

  @override
  Color get error => _error ?? _colorTheme.error;

  @override
  Color get onError => _onError ?? _colorTheme.onError;

  @override
  Color get errorContainer => _errorContainer ?? _colorTheme.errorContainer;

  @override
  Color get onErrorContainer =>
      _onErrorContainer ?? _colorTheme.onErrorContainer;

  @override
  Color get surface => _surface ?? _colorTheme.surface;

  @override
  Color get onSurface => _onSurface ?? _colorTheme.onSurface;

  @override
  Color get surfaceDim => _surfaceDim ?? _colorTheme.surfaceDim;

  @override
  Color get surfaceBright => _surfaceBright ?? _colorTheme.surfaceBright;

  @override
  Color get surfaceContainerLowest =>
      _surfaceContainerLowest ?? _colorTheme.surfaceContainerLowest;

  @override
  Color get surfaceContainerLow =>
      _surfaceContainerLow ?? _colorTheme.surfaceContainerLow;

  @override
  Color get surfaceContainer =>
      _surfaceContainer ?? _colorTheme.surfaceContainer;

  @override
  Color get surfaceContainerHigh =>
      _surfaceContainerHigh ?? _colorTheme.surfaceContainerHigh;

  @override
  Color get surfaceContainerHighest =>
      _surfaceContainerHighest ?? _colorTheme.surfaceContainerHighest;

  @override
  Color get onSurfaceVariant =>
      _onSurfaceVariant ?? _colorTheme.onSurfaceVariant;

  @override
  Color get outline => _outline ?? _colorTheme.outline;

  @override
  Color get outlineVariant => _outlineVariant ?? _colorTheme.outlineVariant;

  @override
  Color get shadow => _shadow ?? _colorTheme.shadow;

  @override
  Color get scrim => _scrim ?? _colorTheme.scrim;

  @override
  Color get inverseSurface => _inverseSurface ?? _colorTheme.inverseSurface;

  @override
  Color get onInverseSurface =>
      _onInverseSurface ?? _colorTheme.inverseOnSurface;

  @override
  Color get inversePrimary => _inversePrimary ?? _colorTheme.inversePrimary;

  @override
  Color get surfaceTint => _surfaceTint ?? _colorTheme.surfaceTint;

  @override
  Color get background => _background ?? _colorTheme.background;

  @override
  Color get onBackground => _onBackground ?? _colorTheme.onBackground;

  @override
  Color get surfaceVariant => _surfaceVariant ?? _colorTheme.surfaceVariant;

  @override
  ColorSchemeLegacy copyWith({
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? surface,
    Color? onSurface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
    Color? background,
    Color? onBackground,
    Color? surfaceVariant,
  }) {
    if (brightness == null &&
        primary == null &&
        onPrimary == null &&
        primaryContainer == null &&
        onPrimaryContainer == null &&
        primaryFixed == null &&
        primaryFixedDim == null &&
        onPrimaryFixed == null &&
        onPrimaryFixedVariant == null &&
        secondary == null &&
        onSecondary == null &&
        secondaryContainer == null &&
        onSecondaryContainer == null &&
        secondaryFixed == null &&
        secondaryFixedDim == null &&
        onSecondaryFixed == null &&
        onSecondaryFixedVariant == null &&
        tertiary == null &&
        onTertiary == null &&
        tertiaryContainer == null &&
        onTertiaryContainer == null &&
        tertiaryFixed == null &&
        tertiaryFixedDim == null &&
        onTertiaryFixed == null &&
        onTertiaryFixedVariant == null &&
        error == null &&
        onError == null &&
        errorContainer == null &&
        onErrorContainer == null &&
        surface == null &&
        onSurface == null &&
        surfaceDim == null &&
        surfaceBright == null &&
        surfaceContainerLowest == null &&
        surfaceContainerLow == null &&
        surfaceContainer == null &&
        surfaceContainerHigh == null &&
        surfaceContainerHighest == null &&
        onSurfaceVariant == null &&
        outline == null &&
        outlineVariant == null &&
        shadow == null &&
        scrim == null &&
        inverseSurface == null &&
        onInverseSurface == null &&
        inversePrimary == null &&
        surfaceTint == null &&
        background == null &&
        onBackground == null &&
        surfaceVariant == null) {
      return this;
    }
    if (brightness != null &&
        primary != null &&
        onPrimary != null &&
        primaryContainer != null &&
        onPrimaryContainer != null &&
        primaryFixed != null &&
        primaryFixedDim != null &&
        onPrimaryFixed != null &&
        onPrimaryFixedVariant != null &&
        secondary != null &&
        onSecondary != null &&
        secondaryContainer != null &&
        onSecondaryContainer != null &&
        secondaryFixed != null &&
        secondaryFixedDim != null &&
        onSecondaryFixed != null &&
        onSecondaryFixedVariant != null &&
        tertiary != null &&
        onTertiary != null &&
        tertiaryContainer != null &&
        onTertiaryContainer != null &&
        tertiaryFixed != null &&
        tertiaryFixedDim != null &&
        onTertiaryFixed != null &&
        onTertiaryFixedVariant != null &&
        error != null &&
        onError != null &&
        errorContainer != null &&
        onErrorContainer != null &&
        surface != null &&
        onSurface != null &&
        surfaceDim != null &&
        surfaceBright != null &&
        surfaceContainerLowest != null &&
        surfaceContainerLow != null &&
        surfaceContainer != null &&
        surfaceContainerHigh != null &&
        surfaceContainerHighest != null &&
        onSurfaceVariant != null &&
        outline != null &&
        outlineVariant != null &&
        shadow != null &&
        scrim != null &&
        inverseSurface != null &&
        onInverseSurface != null &&
        inversePrimary != null &&
        surfaceTint != null &&
        background != null &&
        onBackground != null &&
        surfaceVariant != null) {
      return ColorSchemeLegacy(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        primaryFixed: primaryFixed,
        primaryFixedDim: primaryFixedDim,
        onPrimaryFixed: onPrimaryFixed,
        onPrimaryFixedVariant: onPrimaryFixedVariant,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        secondaryFixed: secondaryFixed,
        secondaryFixedDim: secondaryFixedDim,
        onSecondaryFixed: onSecondaryFixed,
        onSecondaryFixedVariant: onSecondaryFixedVariant,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        tertiaryFixed: tertiaryFixed,
        tertiaryFixedDim: tertiaryFixedDim,
        onTertiaryFixed: onTertiaryFixed,
        onTertiaryFixedVariant: onTertiaryFixedVariant,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        surfaceDim: surfaceDim,
        surfaceBright: surfaceBright,
        surfaceContainerLowest: surfaceContainerLowest,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainer: surfaceContainer,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainerHighest: surfaceContainerHighest,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        shadow: shadow,
        scrim: scrim,
        inverseSurface: inverseSurface,
        onInverseSurface: onInverseSurface,
        inversePrimary: inversePrimary,
        surfaceTint: surfaceTint,
        // ignore: deprecated_member_use
        background: background,
        // ignore: deprecated_member_use
        onBackground: onBackground,
        // ignore: deprecated_member_use
        surfaceVariant: surfaceVariant,
      );
    }
    return _LegacyFromColorThemeData(
      _colorTheme,
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      primaryFixed: primaryFixed,
      primaryFixedDim: primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed,
      onPrimaryFixedVariant: onPrimaryFixedVariant,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      secondaryFixed: secondaryFixed,
      secondaryFixedDim: secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed,
      onSecondaryFixedVariant: onSecondaryFixedVariant,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      tertiaryFixed: tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim,
      onTertiaryFixed: onTertiaryFixed,
      onTertiaryFixedVariant: onTertiaryFixedVariant,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
      surfaceTint: surfaceTint,
      background: background,
      onBackground: onBackground,
      surfaceVariant: surfaceVariant,
    );
  }

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
      DiagnosticsProperty<ColorThemeData>("color theme", _colorTheme),
    );
    properties.add(
      EnumProperty<Brightness>("brightness", _brightness, defaultValue: null),
    );
    properties.add(ColorProperty("primary", _primary, defaultValue: null));
    properties.add(ColorProperty("onPrimary", _onPrimary, defaultValue: null));
    properties.add(
      ColorProperty("primaryContainer", _primaryContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onPrimaryContainer",
        _onPrimaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("primaryFixed", _primaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty("primaryFixedDim", _primaryFixedDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onPrimaryFixed", _onPrimaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onPrimaryFixedVariant",
        _onPrimaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("secondary", _secondary, defaultValue: null));
    properties.add(
      ColorProperty("onSecondary", _onSecondary, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "secondaryContainer",
        _secondaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "onSecondaryContainer",
        _onSecondaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("secondaryFixed", _secondaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "secondaryFixedDim",
        _secondaryFixedDim,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("onSecondaryFixed", _onSecondaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onSecondaryFixedVariant",
        _onSecondaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("tertiary", _tertiary, defaultValue: null));
    properties.add(
      ColorProperty("onTertiary", _onTertiary, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "tertiaryContainer",
        _tertiaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "onTertiaryContainer",
        _onTertiaryContainer,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("tertiaryFixed", _tertiaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty("tertiaryFixedDim", _tertiaryFixedDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("onTertiaryFixed", _onTertiaryFixed, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "onTertiaryFixedVariant",
        _onTertiaryFixedVariant,
        defaultValue: null,
      ),
    );
    properties.add(ColorProperty("error", _error, defaultValue: null));
    properties.add(ColorProperty("onError", _onError, defaultValue: null));
    properties.add(
      ColorProperty("errorContainer", _errorContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty("onErrorContainer", _onErrorContainer, defaultValue: null),
    );
    properties.add(ColorProperty("surface", _surface, defaultValue: null));
    properties.add(ColorProperty("onSurface", _onSurface, defaultValue: null));
    properties.add(
      ColorProperty("surfaceDim", _surfaceDim, defaultValue: null),
    );
    properties.add(
      ColorProperty("surfaceBright", _surfaceBright, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerLowest",
        _surfaceContainerLowest,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerLow",
        _surfaceContainerLow,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("surfaceContainer", _surfaceContainer, defaultValue: null),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerHigh",
        _surfaceContainerHigh,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty(
        "surfaceContainerHighest",
        _surfaceContainerHighest,
        defaultValue: null,
      ),
    );
    properties.add(
      ColorProperty("onSurfaceVariant", _onSurfaceVariant, defaultValue: null),
    );
    properties.add(ColorProperty("outline", _outline, defaultValue: null));
    properties.add(
      ColorProperty("outlineVariant", _outlineVariant, defaultValue: null),
    );
    properties.add(ColorProperty("shadow", _shadow, defaultValue: null));
    properties.add(ColorProperty("scrim", _scrim, defaultValue: null));
    properties.add(
      ColorProperty("inverseSurface", _inverseSurface, defaultValue: null),
    );
    properties.add(
      ColorProperty("onInverseSurface", _onInverseSurface, defaultValue: null),
    );
    properties.add(
      ColorProperty("inversePrimary", _inversePrimary, defaultValue: null),
    );
    properties.add(
      ColorProperty("surfaceTint", _surfaceTint, defaultValue: null),
    );
    properties.add(
      ColorProperty("background", _background, defaultValue: null),
    );
    properties.add(
      ColorProperty("onBackground", _onBackground, defaultValue: null),
    );
    properties.add(
      ColorProperty("surfaceVariant", _surfaceVariant, defaultValue: null),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is _LegacyFromColorThemeData &&
            _colorTheme == other._colorTheme &&
            _brightness == other._brightness &&
            _primary == other._primary &&
            _onPrimary == other._onPrimary &&
            _primaryContainer == other._primaryContainer &&
            _onPrimaryContainer == other._onPrimaryContainer &&
            _primaryFixed == other._primaryFixed &&
            _primaryFixedDim == other._primaryFixedDim &&
            _onPrimaryFixed == other._onPrimaryFixed &&
            _onPrimaryFixedVariant == other._onPrimaryFixedVariant &&
            _secondary == other._secondary &&
            _onSecondary == other._onSecondary &&
            _secondaryContainer == other._secondaryContainer &&
            _onSecondaryContainer == other._onSecondaryContainer &&
            _secondaryFixed == other._secondaryFixed &&
            _secondaryFixedDim == other._secondaryFixedDim &&
            _onSecondaryFixed == other._onSecondaryFixed &&
            _onSecondaryFixedVariant == other._onSecondaryFixedVariant &&
            _tertiary == other._tertiary &&
            _onTertiary == other._onTertiary &&
            _tertiaryContainer == other._tertiaryContainer &&
            _onTertiaryContainer == other._onTertiaryContainer &&
            _tertiaryFixed == other._tertiaryFixed &&
            _tertiaryFixedDim == other._tertiaryFixedDim &&
            _onTertiaryFixed == other._onTertiaryFixed &&
            _onTertiaryFixedVariant == other._onTertiaryFixedVariant &&
            _error == other._error &&
            _onError == other._onError &&
            _errorContainer == other._errorContainer &&
            _onErrorContainer == other._onErrorContainer &&
            _surface == other._surface &&
            _onSurface == other._onSurface &&
            _surfaceDim == other._surfaceDim &&
            _surfaceBright == other._surfaceBright &&
            _surfaceContainerLowest == other._surfaceContainerLowest &&
            _surfaceContainerLow == other._surfaceContainerLow &&
            _surfaceContainer == other._surfaceContainer &&
            _surfaceContainerHigh == other._surfaceContainerHigh &&
            _surfaceContainerHighest == other._surfaceContainerHighest &&
            _onSurfaceVariant == other._onSurfaceVariant &&
            _outline == other._outline &&
            _outlineVariant == other._outlineVariant &&
            _shadow == other._shadow &&
            _scrim == other._scrim &&
            _inverseSurface == other._inverseSurface &&
            _onInverseSurface == other._onInverseSurface &&
            _inversePrimary == other._inversePrimary &&
            _surfaceTint == other._surfaceTint &&
            _background == other._background &&
            _onBackground == other._onBackground &&
            _surfaceVariant == other._surfaceVariant;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    _colorTheme,
    _brightness,
    _primary,
    _onPrimary,
    _primaryContainer,
    _onPrimaryContainer,
    _primaryFixed,
    _primaryFixedDim,
    _onPrimaryFixed,
    _onPrimaryFixedVariant,
    _secondary,
    _onSecondary,
    _secondaryContainer,
    _onSecondaryContainer,
    _secondaryFixed,
    _secondaryFixedDim,
    _onSecondaryFixed,
    _onSecondaryFixedVariant,
    Object.hash(
      _tertiary,
      _onTertiary,
      _tertiaryContainer,
      _onTertiaryContainer,
      _tertiaryFixed,
      _tertiaryFixedDim,
      _onTertiaryFixed,
      _onTertiaryFixedVariant,
      _error,
      _onError,
      _errorContainer,
      _onErrorContainer,
      _surface,
      _onSurface,
      _surfaceDim,
      _surfaceBright,
      _surfaceContainerLowest,
      _surfaceContainerLow,
      _surfaceContainer,
      Object.hash(
        _surfaceContainerHigh,
        _surfaceContainerHighest,
        _onSurfaceVariant,
        _outline,
        _outlineVariant,
        _shadow,
        _scrim,
        _inverseSurface,
        _onInverseSurface,
        _inversePrimary,
        _surfaceTint,
        _background,
        _onBackground,
        _surfaceVariant,
      ),
    ),
  );
}

final ColorThemeData _baselineLight = ColorThemeData.fromSeed(
  brightness: Brightness.light,
);

final ColorThemeData _baselineDark = ColorThemeData.fromSeed(
  brightness: Brightness.dark,
);

Future<Color> _contentBasedSourceColor(ImageProvider image) async {
  // Extract dominant colors from image.
  final quantizerResult = await _extractColorsFromImageProvider(image);
  final colorToCount = quantizerResult.colorToCount.map(
    (key, value) => MapEntry(_getArgbFromAbgr(key), value),
  );

  // Score colors for color scheme suitability.
  final scoredResults = Score.score(colorToCount, 1);
  final baseColor = Color(scoredResults.first);
  return baseColor;
}

/// Extracts bytes from an [ImageProvider] and returns a [QuantizerResult]
/// containing the most dominant colors.
Future<QuantizerResult> _extractColorsFromImageProvider(
  ImageProvider imageProvider,
) async {
  final scaledImage = await _imageProviderToScaled(imageProvider);
  final imageBytes = await scaledImage.toByteData();

  final quantizerResult = const QuantizerCelebi().quantize(
    imageBytes!.buffer.asUint32List(),
    128,
    // TODO: implement in upstream material-color-utilities-dart
    // returnInputPixelToClusterPixel: true,
  );
  return quantizerResult;
}

/// Scale image size down to reduce computation time of color extraction.
Future<ui.Image> _imageProviderToScaled(ImageProvider imageProvider) async {
  const double maxDimension = 112.0;
  final stream = imageProvider.resolve(
    const ImageConfiguration(size: Size.square(maxDimension)),
  );
  final imageCompleter = Completer<ui.Image>();
  late ImageStreamListener listener;
  late ui.Image scaledImage;
  Timer? loadFailureTimeout;

  listener = ImageStreamListener(
    (info, sync) async {
      loadFailureTimeout?.cancel();
      stream.removeListener(listener);
      final image = info.image;
      final width = image.width;
      final height = image.height;
      double paintWidth = width.toDouble();
      double paintHeight = height.toDouble();
      assert(width > 0 && height > 0);

      final bool rescale = width > maxDimension || height > maxDimension;
      if (rescale) {
        paintWidth = (width > height)
            ? maxDimension
            : (maxDimension / height) * width;
        paintHeight = (height > width)
            ? maxDimension
            : (maxDimension / width) * height;
      }
      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTRB(0, 0, paintWidth, paintHeight),
        image: image,
        filterQuality: FilterQuality.none,
      );

      final picture = pictureRecorder.endRecording();
      scaledImage = await picture.toImage(
        paintWidth.toInt(),
        paintHeight.toInt(),
      );
      imageCompleter.complete(info.image);
    },
    onError: (Object exception, StackTrace? stackTrace) {
      stream.removeListener(listener);
      throw Exception("Failed to render image: $exception");
    },
  );

  loadFailureTimeout = Timer(const Duration(seconds: 5), () {
    stream.removeListener(listener);
    imageCompleter.completeError(
      TimeoutException("Timeout occurred trying to load image"),
    );
  });

  stream.addListener(listener);
  await imageCompleter.future;
  return scaledImage;
}

int _getArgbFromAbgr(int abgr) {
  const int exceptRMask = 0xFF00FFFF;
  const int onlyRMask = ~exceptRMask;
  const int exceptBMask = 0xFFFFFF00;
  const int onlyBMask = ~exceptBMask;
  final r = (abgr & onlyRMask) >> 16;
  final b = abgr & onlyBMask;
  return (abgr & exceptRMask & exceptBMask) | (b << 16) | r;
}

@immutable
class ColorTheme extends InheritedTheme {
  const ColorTheme({super.key, required this.data, required super.child});

  final ColorThemeData data;

  @override
  bool updateShouldNotify(covariant ColorTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ColorTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ColorThemeData>("data", data));
  }

  static Widget merge({
    Key? key,
    required ColorThemeData data,
    required Widget child,
  }) => Builder(
    builder: (context) =>
        ColorTheme(key: key, data: of(context).merge(data), child: child),
  );

  static ColorThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorTheme>()?.data;
  }

  static ColorThemeData of(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) return result;
    final brightness =
        Theme.maybeBrightnessOf(context) ??
        MediaQuery.maybePlatformBrightnessOf(context) ??
        Brightness.light;
    return switch (brightness) {
      Brightness.light => _baselineLight,
      Brightness.dark => _baselineDark,
    };
  }
}
