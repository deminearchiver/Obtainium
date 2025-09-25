import 'package:obtainium/flutter.dart';

// ignore: implementation_imports
import 'package:obtainium_fonts/src/assets/fonts.gen.dart';

const String _roboto = "Roboto";
const String _robotoFlex = Fonts.robotoFlex;
const String _googleSans = Fonts.googleSans;
const String _googleSansFlex = Fonts.googleSansFlex;

abstract final class LegacyThemeFactory {
  static ThemeData create({
    required ColorThemeData colorTheme,
    required ShapeThemeData shapeTheme,
    required TypescaleThemeData typescaleTheme,
  }) {
    final colorScheme = colorTheme.toLegacy();
    return ThemeData(
      colorScheme: colorScheme,
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
      textTheme: typescaleTheme.toBaselineTextTheme(),
      // TODO: remove this after migration to CustomScrollbar
      scrollbarTheme: ScrollbarThemeData(
        thickness: const WidgetStatePropertyAll(8.0),
        radius: const Radius.circular(4.0),
        minThumbLength: 48.0,
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return colorTheme.primary;
        }),
      ),
      iconTheme: IconThemeDataLegacy(
        color: colorTheme.onSurface,
        opacity: 1.0,
        size: 24.0,
        opticalSize: 24.0,
        grade: 0.0,
        fill: 1.0,
        weight: 400.0,
        applyTextScaling: false,
        shadows: const [],
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorTheme.surfaceContainer,
        elevation: 0.0,
        height: 64.0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: colorTheme.secondaryContainer,
        indicatorShape: const StadiumBorder(),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          return IconThemeDataLegacy(
            color: isSelected
                ? colorScheme.onSecondaryContainer
                : colorTheme.onSurfaceVariant,
            fill: isSelected ? 1.0 : 0.0,
            size: 24.0,
            opticalSize: 24.0,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          final typeStyle = isSelected
              ? typescaleTheme.labelMediumEmphasized
              : typescaleTheme.labelMedium;
          return typeStyle.toTextStyle(
            color: isSelected
                ? colorTheme.secondary
                : colorTheme.onSurfaceVariant,
          );
        }),
      ),
      switchTheme: SwitchThemeDataLegacy(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        mouseCursor: WidgetStateMouseCursor.clickable,
        splashRadius: 20.0,
        trackOutlineWidth: const WidgetStatePropertyAll(2.0),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          final isDisabled = states.contains(WidgetState.disabled);
          final color = isSelected ? colorTheme.primary : colorTheme.outline;
          return isDisabled ? color.withAlpha(0) : color;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          final isDisabled = states.contains(WidgetState.disabled);
          return isDisabled
              ? isSelected
                    ? colorTheme.onSurface.withValues(alpha: 0.10)
                    : colorTheme.surfaceContainerHighest.withValues(alpha: 0.10)
              : isSelected
              ? colorTheme.primary
              : colorTheme.surfaceContainerHighest;
        }),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          final isDisabled = states.contains(WidgetState.disabled);
          return isDisabled
              ? isSelected
                    ? colorTheme.surface
                    : colorTheme.onSurface.withValues(alpha: 0.38)
              : isSelected
              ? colorTheme.onPrimary
              : colorTheme.outline;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          final color = isSelected ? colorTheme.primary : colorTheme.onSurface;
          if (states.contains(WidgetState.disabled)) {
            return color.withAlpha(0);
          }
          if (states.contains(WidgetState.pressed)) {
            return color.withValues(alpha: 0.1);
          }
          if (states.contains(WidgetState.focused)) {
            return color.withValues(alpha: 0.1);
          }
          if (states.contains(WidgetState.hovered)) {
            return color.withValues(alpha: 0.08);
          }
          return color.withAlpha(0);
        }),
        thumbIcon: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          final isDisabled = states.contains(WidgetState.disabled);
          return IconLegacy(
            isSelected ? Symbols.check_rounded : Symbols.close_rounded,
            size: 16.0,
            opticalSize: 24.0,
            color: isDisabled
                ? isSelected
                      ? colorTheme.onSurface.withValues(alpha: 0.38)
                      : colorTheme.surfaceContainerHighest.withValues(
                          alpha: 0.38,
                        )
                : isSelected
                ? colorTheme.primary
                : colorTheme.surfaceContainerHighest,
          );
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        // ignore: deprecated_member_use
        year2023: false,
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 500),
        constraints: const BoxConstraints(minHeight: 24.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: ShapeDecoration(
          shape: CornersBorder.rounded(
            corners: Corners.all(shapeTheme.corner.extraSmall),
          ),
          color: colorTheme.inverseSurface,
        ),
        textAlign: TextAlign.start,
        textStyle: typescaleTheme.bodySmall.toTextStyle(
          color: colorTheme.inverseOnSurface,
        ),
      ),
    );
  }
}

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
