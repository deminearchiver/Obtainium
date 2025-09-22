import 'color_spec_2025.dart';
import 'dynamic_color.dart';
import 'dynamic_scheme.dart';

final class MaterialDynamicColors {
  const MaterialDynamicColors();

  static const ColorSpec2025 _colorSpec = ColorSpec2025();

  DynamicColor highestSurface(DynamicScheme s) {
    return _colorSpec.highestSurface(s);
  }

  ////////////////////////////////////////////////////////////////
  // Main Palettes                                              //
  ////////////////////////////////////////////////////////////////

  DynamicColor primaryPaletteKeyColor() {
    return _colorSpec.primaryPaletteKeyColor();
  }

  DynamicColor secondaryPaletteKeyColor() {
    return _colorSpec.secondaryPaletteKeyColor();
  }

  DynamicColor tertiaryPaletteKeyColor() {
    return _colorSpec.tertiaryPaletteKeyColor();
  }

  DynamicColor neutralPaletteKeyColor() {
    return _colorSpec.neutralPaletteKeyColor();
  }

  DynamicColor neutralVariantPaletteKeyColor() {
    return _colorSpec.neutralVariantPaletteKeyColor();
  }

  DynamicColor errorPaletteKeyColor() {
    return _colorSpec.errorPaletteKeyColor();
  }

  ////////////////////////////////////////////////////////////////
  // Surfaces [S]                                               //
  ////////////////////////////////////////////////////////////////

  DynamicColor background() {
    return _colorSpec.background();
  }

  DynamicColor onBackground() {
    return _colorSpec.onBackground();
  }

  DynamicColor surface() {
    return _colorSpec.surface();
  }

  DynamicColor surfaceDim() {
    return _colorSpec.surfaceDim();
  }

  DynamicColor surfaceBright() {
    return _colorSpec.surfaceBright();
  }

  DynamicColor surfaceContainerLowest() {
    return _colorSpec.surfaceContainerLowest();
  }

  DynamicColor surfaceContainerLow() {
    return _colorSpec.surfaceContainerLow();
  }

  DynamicColor surfaceContainer() {
    return _colorSpec.surfaceContainer();
  }

  DynamicColor surfaceContainerHigh() {
    return _colorSpec.surfaceContainerHigh();
  }

  DynamicColor surfaceContainerHighest() {
    return _colorSpec.surfaceContainerHighest();
  }

  DynamicColor onSurface() {
    return _colorSpec.onSurface();
  }

  DynamicColor surfaceVariant() {
    return _colorSpec.surfaceVariant();
  }

  DynamicColor onSurfaceVariant() {
    return _colorSpec.onSurfaceVariant();
  }

  DynamicColor inverseSurface() {
    return _colorSpec.inverseSurface();
  }

  DynamicColor inverseOnSurface() {
    return _colorSpec.inverseOnSurface();
  }

  DynamicColor outline() {
    return _colorSpec.outline();
  }

  DynamicColor outlineVariant() {
    return _colorSpec.outlineVariant();
  }

  DynamicColor shadow() {
    return _colorSpec.shadow();
  }

  DynamicColor scrim() {
    return _colorSpec.scrim();
  }

  DynamicColor surfaceTint() {
    return _colorSpec.surfaceTint();
  }

  ////////////////////////////////////////////////////////////////
  // Primaries [P]                                              //
  ////////////////////////////////////////////////////////////////

  DynamicColor primary() {
    return _colorSpec.primary();
  }

  DynamicColor primaryDim() {
    return _colorSpec.primaryDim();
  }

  DynamicColor onPrimary() {
    return _colorSpec.onPrimary();
  }

  DynamicColor primaryContainer() {
    return _colorSpec.primaryContainer();
  }

  DynamicColor onPrimaryContainer() {
    return _colorSpec.onPrimaryContainer();
  }

  DynamicColor inversePrimary() {
    return _colorSpec.inversePrimary();
  }

  /////////////////////////////////////////////////////////////////
  // Primary Fixed Colors [PF]                                   //
  /////////////////////////////////////////////////////////////////

  DynamicColor primaryFixed() {
    return _colorSpec.primaryFixed();
  }

  DynamicColor primaryFixedDim() {
    return _colorSpec.primaryFixedDim();
  }

  DynamicColor onPrimaryFixed() {
    return _colorSpec.onPrimaryFixed();
  }

  DynamicColor onPrimaryFixedVariant() {
    return _colorSpec.onPrimaryFixedVariant();
  }

  ////////////////////////////////////////////////////////////////
  // Secondaries [Q]                                            //
  ////////////////////////////////////////////////////////////////

  DynamicColor secondary() {
    return _colorSpec.secondary();
  }

  DynamicColor secondaryDim() {
    return _colorSpec.secondaryDim();
  }

  DynamicColor onSecondary() {
    return _colorSpec.onSecondary();
  }

  DynamicColor secondaryContainer() {
    return _colorSpec.secondaryContainer();
  }

  DynamicColor onSecondaryContainer() {
    return _colorSpec.onSecondaryContainer();
  }

  /////////////////////////////////////////////////////////////////
  // Secondary Fixed Colors [QF]                                 //
  /////////////////////////////////////////////////////////////////

  DynamicColor secondaryFixed() {
    return _colorSpec.secondaryFixed();
  }

  DynamicColor secondaryFixedDim() {
    return _colorSpec.secondaryFixedDim();
  }

  DynamicColor onSecondaryFixed() {
    return _colorSpec.onSecondaryFixed();
  }

  DynamicColor onSecondaryFixedVariant() {
    return _colorSpec.onSecondaryFixedVariant();
  }

  ////////////////////////////////////////////////////////////////
  // Tertiaries [T]                                             //
  ////////////////////////////////////////////////////////////////

  DynamicColor tertiary() {
    return _colorSpec.tertiary();
  }

  DynamicColor tertiaryDim() {
    return _colorSpec.tertiaryDim();
  }

  DynamicColor onTertiary() {
    return _colorSpec.onTertiary();
  }

  DynamicColor tertiaryContainer() {
    return _colorSpec.tertiaryContainer();
  }

  DynamicColor onTertiaryContainer() {
    return _colorSpec.onTertiaryContainer();
  }

  /////////////////////////////////////////////////////////////////
  // Tertiary Fixed Colors [TF]                                  //
  /////////////////////////////////////////////////////////////////

  DynamicColor tertiaryFixed() {
    return _colorSpec.tertiaryFixed();
  }

  DynamicColor tertiaryFixedDim() {
    return _colorSpec.tertiaryFixedDim();
  }

  DynamicColor onTertiaryFixed() {
    return _colorSpec.onTertiaryFixed();
  }

  DynamicColor onTertiaryFixedVariant() {
    return _colorSpec.onTertiaryFixedVariant();
  }

  ////////////////////////////////////////////////////////////////
  // Errors [E]                                                 //
  ////////////////////////////////////////////////////////////////

  DynamicColor error() {
    return _colorSpec.error();
  }

  DynamicColor errorDim() {
    return _colorSpec.errorDim();
  }

  DynamicColor onError() {
    return _colorSpec.onError();
  }

  DynamicColor errorContainer() {
    return _colorSpec.errorContainer();
  }

  DynamicColor onErrorContainer() {
    return _colorSpec.onErrorContainer();
  }

  ////////////////////////////////////////////////////////////////
  // Android-only colors                                        //
  ////////////////////////////////////////////////////////////////

  // These colors were present in Android framework before Android U, and used by MDC controls. They
  // should be avoided, if possible. It's unclear if they're used on multiple backgrounds, and if
  // they are, they can't be adjusted for contrast.* For now, they will be set with no background,
  // and those won't adjust for contrast, avoiding issues.
  //
  // <p>* For example, if the same color is on a white background _and_ black background, there's no
  // way to increase contrast with either without losing contrast with the other.

  // colorControlActivated documented as colorAccent in M3 & GM3.
  // colorAccent documented as colorSecondary in M3 and colorPrimary in GM3.
  // Android used Material's Container as Primary/Secondary/Tertiary at launch.
  // Therefore, this is a duplicated version of Primary Container.

  DynamicColor controlActivated() {
    return _colorSpec.controlActivated();
  }

  // colorControlNormal documented as textColorSecondary in M3 & GM3.
  // In Material, textColorSecondary points to onSurfaceVariant in the non-disabled state,
  // which is Neutral Variant T30/80 in light/dark.

  DynamicColor controlNormal() {
    return _colorSpec.controlNormal();
  }

  // colorControlHighlight documented, in both M3 & GM3:
  // Light mode: #1f000000 dark mode: #33ffffff.
  // These are black and white with some alpha.
  // 1F hex = 31 decimal; 31 / 255 = 12% alpha.
  // 33 hex = 51 decimal; 51 / 255 = 20% alpha.
  // DynamicColors do not support alpha currently, and _may_ not need it for this use case,
  // depending on how MDC resolved alpha for the other cases.
  // Returning black in dark mode, white in light mode.

  DynamicColor controlHighlight() {
    return _colorSpec.controlHighlight();
  }

  // textColorPrimaryInverse documented, in both M3 & GM3, documented as N10/N90.

  DynamicColor textPrimaryInverse() {
    return _colorSpec.textPrimaryInverse();
  }

  // textColorSecondaryInverse and textColorTertiaryInverse both documented, in both M3 & GM3, as
  // NV30/NV80

  DynamicColor textSecondaryAndTertiaryInverse() {
    return _colorSpec.textSecondaryAndTertiaryInverse();
  }

  // textColorPrimaryInverseDisableOnly documented, in both M3 & GM3, as N10/N90

  DynamicColor textPrimaryInverseDisableOnly() {
    return _colorSpec.textPrimaryInverseDisableOnly();
  }

  // textColorSecondaryInverse and textColorTertiaryInverse in disabled state both documented,
  // in both M3 & GM3, as N10/N90

  DynamicColor textSecondaryAndTertiaryInverseDisabled() {
    return _colorSpec.textSecondaryAndTertiaryInverseDisabled();
  }

  // textColorHintInverse documented, in both M3 & GM3, as N10/N90

  DynamicColor textHintInverse() {
    return _colorSpec.textHintInverse();
  }

  ////////////////////////////////////////////////////////////////
  // All Colors                                                 //
  ////////////////////////////////////////////////////////////////

  /// All dynamic colors in Material Design system.
  List<DynamicColor> get allDynamicColors => [
    primaryPaletteKeyColor(),
    secondaryPaletteKeyColor(),
    tertiaryPaletteKeyColor(),
    neutralPaletteKeyColor(),
    neutralVariantPaletteKeyColor(),
    errorPaletteKeyColor(),
    background(),
    onBackground(),
    surface(),
    surfaceDim(),
    surfaceBright(),
    surfaceContainerLowest(),
    surfaceContainerLow(),
    surfaceContainer(),
    surfaceContainerHigh(),
    surfaceContainerHighest(),
    onSurface(),
    surfaceVariant(),
    onSurfaceVariant(),
    outline(),
    outlineVariant(),
    inverseSurface(),
    inverseOnSurface(),
    shadow(),
    scrim(),
    surfaceTint(),
    primary(),
    primaryDim(),
    onPrimary(),
    primaryContainer(),
    onPrimaryContainer(),
    primaryFixed(),
    primaryFixedDim(),
    onPrimaryFixed(),
    onPrimaryFixedVariant(),
    inversePrimary(),
    secondary(),
    secondaryDim(),
    onSecondary(),
    secondaryContainer(),
    onSecondaryContainer(),
    secondaryFixed(),
    secondaryFixedDim(),
    onSecondaryFixed(),
    onSecondaryFixedVariant(),
    tertiary(),
    tertiaryDim(),
    onTertiary(),
    tertiaryContainer(),
    onTertiaryContainer(),
    tertiaryFixed(),
    tertiaryFixedDim(),
    onTertiaryFixed(),
    onTertiaryFixedVariant(),
    error(),
    errorDim(),
    onError(),
    errorContainer(),
    onErrorContainer(),
    controlActivated(),
    controlNormal(),
    controlHighlight(),
    textPrimaryInverse(),
    textSecondaryAndTertiaryInverse(),
    textPrimaryInverseDisableOnly(),
    textSecondaryAndTertiaryInverseDisabled(),
    textHintInverse(),
  ];
}
