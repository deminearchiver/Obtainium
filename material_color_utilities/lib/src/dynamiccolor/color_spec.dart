import 'package:meta/meta.dart';

import '../hct/hct.dart';
import '../palettes/tonal_palette.dart';
import 'dynamic_color.dart';
import 'dynamic_scheme.dart';
import 'variant.dart';

/// All available spec versions.
enum SpecVersion { spec2021, spec2025 }

/// An interface defining all the necessary methods that could be different between specs.
abstract interface class ColorSpec {
  ////////////////////////////////////////////////////////////////
  // Main Palettes                                              //
  ////////////////////////////////////////////////////////////////

  DynamicColor primaryPaletteKeyColor();

  DynamicColor secondaryPaletteKeyColor();

  DynamicColor tertiaryPaletteKeyColor();

  DynamicColor neutralPaletteKeyColor();

  DynamicColor neutralVariantPaletteKeyColor();

  DynamicColor errorPaletteKeyColor();

  ////////////////////////////////////////////////////////////////
  // Surfaces [S]                                               //
  ////////////////////////////////////////////////////////////////

  DynamicColor background();

  DynamicColor onBackground();

  DynamicColor surface();

  DynamicColor surfaceDim();

  DynamicColor surfaceBright();

  DynamicColor surfaceContainerLowest();

  DynamicColor surfaceContainerLow();

  DynamicColor surfaceContainer();

  DynamicColor surfaceContainerHigh();

  DynamicColor surfaceContainerHighest();

  DynamicColor onSurface();

  DynamicColor surfaceVariant();

  DynamicColor onSurfaceVariant();

  DynamicColor inverseSurface();

  DynamicColor inverseOnSurface();

  DynamicColor outline();

  DynamicColor outlineVariant();

  DynamicColor shadow();

  DynamicColor scrim();

  DynamicColor surfaceTint();

  ////////////////////////////////////////////////////////////////
  // Primaries [P]                                              //
  ////////////////////////////////////////////////////////////////

  DynamicColor primary();

  DynamicColor? primaryDim();

  DynamicColor onPrimary();

  DynamicColor primaryContainer();

  DynamicColor onPrimaryContainer();

  DynamicColor inversePrimary();

  ////////////////////////////////////////////////////////////////
  // Secondaries [Q]                                            //
  ////////////////////////////////////////////////////////////////

  DynamicColor secondary();

  DynamicColor? secondaryDim();

  DynamicColor onSecondary();

  DynamicColor secondaryContainer();

  DynamicColor onSecondaryContainer();

  ////////////////////////////////////////////////////////////////
  // Tertiaries [T]                                             //
  ////////////////////////////////////////////////////////////////

  DynamicColor tertiary();

  DynamicColor? tertiaryDim();

  DynamicColor onTertiary();

  DynamicColor tertiaryContainer();

  DynamicColor onTertiaryContainer();

  ////////////////////////////////////////////////////////////////
  // Errors [E]                                                 //
  ////////////////////////////////////////////////////////////////

  DynamicColor error();

  DynamicColor? errorDim();

  DynamicColor onError();

  DynamicColor errorContainer();

  DynamicColor onErrorContainer();

  ////////////////////////////////////////////////////////////////
  // Primary Fixed Colors [PF]                                  //
  ////////////////////////////////////////////////////////////////

  DynamicColor primaryFixed();

  DynamicColor primaryFixedDim();

  DynamicColor onPrimaryFixed();

  DynamicColor onPrimaryFixedVariant();

  ////////////////////////////////////////////////////////////////
  // Secondary Fixed Colors [QF]                                //
  ////////////////////////////////////////////////////////////////

  DynamicColor secondaryFixed();

  DynamicColor secondaryFixedDim();

  DynamicColor onSecondaryFixed();

  DynamicColor onSecondaryFixedVariant();

  ////////////////////////////////////////////////////////////////
  // Tertiary Fixed Colors [TF]                                 //
  ////////////////////////////////////////////////////////////////

  DynamicColor tertiaryFixed();

  DynamicColor tertiaryFixedDim();

  DynamicColor onTertiaryFixed();

  DynamicColor onTertiaryFixedVariant();

  ////////////////////////////////////////////////////////////////
  // Other                                                      //
  ////////////////////////////////////////////////////////////////

  DynamicColor highestSurface(DynamicScheme s);

  /////////////////////////////////////////////////////////////////
  // Color value calculations                                    //
  /////////////////////////////////////////////////////////////////

  @protected
  Hct getHct(DynamicScheme scheme, DynamicColor color);

  @protected
  double getTone(DynamicScheme scheme, DynamicColor color);

  //////////////////////////////////////////////////////////////////
  // Scheme Palettes                                              //
  //////////////////////////////////////////////////////////////////

  TonalPalette getPrimaryPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  );

  TonalPalette getSecondaryPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  );

  TonalPalette getTertiaryPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  );

  TonalPalette getNeutralPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  );

  TonalPalette getNeutralVariantPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  );

  TonalPalette? getErrorPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  );
}
