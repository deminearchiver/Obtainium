import 'color_spec_2025.dart';
import 'dynamic_color.dart';
import 'dynamic_scheme.dart';

final class MaterialDynamicColors {
  const MaterialDynamicColors();

  static const ColorSpec2025 _colorSpec = ColorSpec2025();

  DynamicColor highestSurface(DynamicScheme s) => _colorSpec.highestSurface(s);

  DynamicColor primaryPaletteKeyColor() => _colorSpec.primaryPaletteKeyColor();

  DynamicColor secondaryPaletteKeyColor() =>
      _colorSpec.secondaryPaletteKeyColor();

  DynamicColor tertiaryPaletteKeyColor() =>
      _colorSpec.tertiaryPaletteKeyColor();

  DynamicColor neutralPaletteKeyColor() => _colorSpec.neutralPaletteKeyColor();

  DynamicColor neutralVariantPaletteKeyColor() =>
      _colorSpec.neutralVariantPaletteKeyColor();

  DynamicColor errorPaletteKeyColor() => _colorSpec.errorPaletteKeyColor();

  DynamicColor background() => _colorSpec.background();

  DynamicColor onBackground() => _colorSpec.onBackground();

  DynamicColor surface() => _colorSpec.surface();

  DynamicColor surfaceDim() => _colorSpec.surfaceDim();

  DynamicColor surfaceBright() => _colorSpec.surfaceBright();

  DynamicColor surfaceContainerLowest() => _colorSpec.surfaceContainerLowest();

  DynamicColor surfaceContainerLow() => _colorSpec.surfaceContainerLow();

  DynamicColor surfaceContainer() => _colorSpec.surfaceContainer();

  DynamicColor surfaceContainerHigh() => _colorSpec.surfaceContainerHigh();

  DynamicColor surfaceContainerHighest() =>
      _colorSpec.surfaceContainerHighest();

  DynamicColor onSurface() => _colorSpec.onSurface();

  DynamicColor surfaceVariant() => _colorSpec.surfaceVariant();

  DynamicColor onSurfaceVariant() => _colorSpec.onSurfaceVariant();

  DynamicColor inverseSurface() => _colorSpec.inverseSurface();

  DynamicColor inverseOnSurface() => _colorSpec.inverseOnSurface();

  DynamicColor outline() => _colorSpec.outline();

  DynamicColor outlineVariant() => _colorSpec.outlineVariant();

  DynamicColor shadow() => _colorSpec.shadow();

  DynamicColor scrim() => _colorSpec.scrim();

  DynamicColor surfaceTint() => _colorSpec.surfaceTint();

  DynamicColor primary() => _colorSpec.primary();

  DynamicColor primaryDim() => _colorSpec.primaryDim();

  DynamicColor onPrimary() => _colorSpec.onPrimary();

  DynamicColor primaryContainer() => _colorSpec.primaryContainer();

  DynamicColor onPrimaryContainer() => _colorSpec.onPrimaryContainer();

  DynamicColor inversePrimary() => _colorSpec.inversePrimary();

  DynamicColor primaryFixed() => _colorSpec.primaryFixed();

  DynamicColor primaryFixedDim() => _colorSpec.primaryFixedDim();

  DynamicColor onPrimaryFixed() => _colorSpec.onPrimaryFixed();

  DynamicColor onPrimaryFixedVariant() => _colorSpec.onPrimaryFixedVariant();

  DynamicColor secondary() => _colorSpec.secondary();

  DynamicColor secondaryDim() => _colorSpec.secondaryDim();

  DynamicColor onSecondary() => _colorSpec.onSecondary();

  DynamicColor secondaryContainer() => _colorSpec.secondaryContainer();

  DynamicColor onSecondaryContainer() => _colorSpec.onSecondaryContainer();

  DynamicColor secondaryFixed() => _colorSpec.secondaryFixed();

  DynamicColor secondaryFixedDim() => _colorSpec.secondaryFixedDim();

  DynamicColor onSecondaryFixed() => _colorSpec.onSecondaryFixed();

  DynamicColor onSecondaryFixedVariant() =>
      _colorSpec.onSecondaryFixedVariant();

  DynamicColor tertiary() => _colorSpec.tertiary();

  DynamicColor tertiaryDim() => _colorSpec.tertiaryDim();

  DynamicColor onTertiary() => _colorSpec.onTertiary();

  DynamicColor tertiaryContainer() => _colorSpec.tertiaryContainer();

  DynamicColor onTertiaryContainer() => _colorSpec.onTertiaryContainer();

  DynamicColor tertiaryFixed() => _colorSpec.tertiaryFixed();

  DynamicColor tertiaryFixedDim() => _colorSpec.tertiaryFixedDim();

  DynamicColor onTertiaryFixed() => _colorSpec.onTertiaryFixed();

  DynamicColor onTertiaryFixedVariant() => _colorSpec.onTertiaryFixedVariant();

  DynamicColor error() => _colorSpec.error();

  DynamicColor errorDim() => _colorSpec.errorDim();

  DynamicColor onError() => _colorSpec.onError();

  DynamicColor errorContainer() => _colorSpec.errorContainer();

  DynamicColor onErrorContainer() => _colorSpec.onErrorContainer();

  DynamicColor controlActivated() => _colorSpec.controlActivated();

  DynamicColor controlNormal() => _colorSpec.controlNormal();

  DynamicColor controlHighlight() => _colorSpec.controlHighlight();

  DynamicColor textPrimaryInverse() => _colorSpec.textPrimaryInverse();

  DynamicColor textSecondaryAndTertiaryInverse() =>
      _colorSpec.textSecondaryAndTertiaryInverse();

  DynamicColor textPrimaryInverseDisableOnly() =>
      _colorSpec.textPrimaryInverseDisableOnly();

  DynamicColor textSecondaryAndTertiaryInverseDisabled() =>
      _colorSpec.textSecondaryAndTertiaryInverseDisabled();

  DynamicColor textHintInverse() => _colorSpec.textHintInverse();

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
