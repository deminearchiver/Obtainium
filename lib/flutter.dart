library;

// SDK packages

export 'package:flutter/foundation.dart';

export 'package:flutter/services.dart';

export 'package:flutter/physics.dart';

export 'package:flutter/rendering.dart';

export 'package:flutter/material.dart'
    hide
        WidgetStateProperty,
        WidgetStatesConstraint,
        WidgetStateMap,
        WidgetStateMapper,
        WidgetStatePropertyAll,
        WidgetStatesController,
        // ---
        Icon,
        IconTheme,
        IconThemeData,
        // ---
        // Force migration to Material Symbols
        Icons,
        AnimatedIcons;

// Third-party packages

export 'package:meta/meta.dart';
export 'package:material_symbols_icons/material_symbols_icons.dart';

// Internal packages

export 'package:material/material.dart';

// Self-import

import 'package:dynamic_color/dynamic_color.dart';
import 'package:obtainium/flutter.dart';

@immutable
class CombiningBuilder extends StatelessWidget {
  const CombiningBuilder({
    super.key,
    this.useOuterContext = false,
    required this.builders,
    required this.child,
  });

  final bool useOuterContext;

  final List<Widget Function(BuildContext context, Widget child)> builders;

  /// The child widget to pass to the last of [builders].
  ///
  /// {@macro flutter.widgets.transitions.ListenableBuilder.optimizations}
  final Widget child;

  @override
  Widget build(BuildContext outerContext) {
    return builders.reversed.fold(child, (child, buildOuter) {
      return useOuterContext
          ? buildOuter(outerContext, child)
          : Builder(builder: (innerContext) => buildOuter(innerContext, child));
    });
  }
}

extension on int {
  Color _toColor() => Color(this);
}

extension DynamicColorSchemeToColorTheme on DynamicColorScheme {
  ColorThemeDataPartial toColorTheme() => ColorThemeDataPartial.from(
    primaryPaletteKeyColor: primaryPaletteKeyColor?._toColor(),
    secondaryPaletteKeyColor: secondaryPaletteKeyColor?._toColor(),
    tertiaryPaletteKeyColor: tertiaryPaletteKeyColor?._toColor(),
    neutralPaletteKeyColor: neutralPaletteKeyColor?._toColor(),
    neutralVariantPaletteKeyColor: neutralVariantPaletteKeyColor?._toColor(),
    errorPaletteKeyColor: errorPaletteKeyColor?._toColor(),
    background: background?._toColor(),
    onBackground: onBackground?._toColor(),
    surface: surface?._toColor(),
    surfaceDim: surfaceDim?._toColor(),
    surfaceBright: surfaceBright?._toColor(),
    surfaceContainerLowest: surfaceContainerLowest?._toColor(),
    surfaceContainerLow: surfaceContainerLow?._toColor(),
    surfaceContainer: surfaceContainer?._toColor(),
    surfaceContainerHigh: surfaceContainerHigh?._toColor(),
    surfaceContainerHighest: surfaceContainerHighest?._toColor(),
    onSurface: onSurface?._toColor(),
    surfaceVariant: surfaceVariant?._toColor(),
    onSurfaceVariant: onSurfaceVariant?._toColor(),
    outline: outline?._toColor(),
    outlineVariant: outlineVariant?._toColor(),
    inverseSurface: inverseSurface?._toColor(),
    inverseOnSurface: inverseOnSurface?._toColor(),
    shadow: shadow?._toColor(),
    scrim: scrim?._toColor(),
    surfaceTint: surfaceTint?._toColor(),
    primary: primary?._toColor(),
    primaryDim: primaryDim?._toColor(),
    onPrimary: onPrimary?._toColor(),
    primaryContainer: primaryContainer?._toColor(),
    onPrimaryContainer: onPrimaryContainer?._toColor(),
    primaryFixed: primaryFixed?._toColor(),
    primaryFixedDim: primaryFixedDim?._toColor(),
    onPrimaryFixed: onPrimaryFixed?._toColor(),
    onPrimaryFixedVariant: onPrimaryFixedVariant?._toColor(),
    inversePrimary: inversePrimary?._toColor(),
    secondary: secondary?._toColor(),
    secondaryDim: secondaryDim?._toColor(),
    onSecondary: onSecondary?._toColor(),
    secondaryContainer: secondaryContainer?._toColor(),
    onSecondaryContainer: onSecondaryContainer?._toColor(),
    secondaryFixed: secondaryFixed?._toColor(),
    secondaryFixedDim: secondaryFixedDim?._toColor(),
    onSecondaryFixed: onSecondaryFixed?._toColor(),
    onSecondaryFixedVariant: onSecondaryFixedVariant?._toColor(),
    tertiary: tertiary?._toColor(),
    tertiaryDim: tertiaryDim?._toColor(),
    onTertiary: onTertiary?._toColor(),
    tertiaryContainer: tertiaryContainer?._toColor(),
    onTertiaryContainer: onTertiaryContainer?._toColor(),
    tertiaryFixed: tertiaryFixed?._toColor(),
    tertiaryFixedDim: tertiaryFixedDim?._toColor(),
    onTertiaryFixed: onTertiaryFixed?._toColor(),
    onTertiaryFixedVariant: onTertiaryFixedVariant?._toColor(),
    error: error?._toColor(),
    errorDim: errorDim?._toColor(),
    onError: onError?._toColor(),
    errorContainer: errorContainer?._toColor(),
    onErrorContainer: onErrorContainer?._toColor(),
    controlActivated: controlActivated?._toColor(),
    controlNormal: controlNormal?._toColor(),
    controlHighlight: controlHighlight?._toColor(),
    textPrimaryInverse: textPrimaryInverse?._toColor(),
    textSecondaryAndTertiaryInverse: textSecondaryAndTertiaryInverse
        ?._toColor(),
    textPrimaryInverseDisableOnly: textPrimaryInverseDisableOnly?._toColor(),
    textSecondaryAndTertiaryInverseDisabled:
        textSecondaryAndTertiaryInverseDisabled?._toColor(),
    textHintInverse: textHintInverse?._toColor(),
  );
}
