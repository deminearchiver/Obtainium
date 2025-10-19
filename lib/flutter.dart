library;

// SDK packages

export 'package:flutter/foundation.dart';

export 'package:flutter/services.dart';

export 'package:flutter/physics.dart';

export 'package:flutter/rendering.dart'
    hide
        RenderPadding,
        FlexParentData,
        RenderFlex,
        FloatingHeaderSnapConfiguration,
        PersistentHeaderShowOnScreenConfiguration,
        OverScrollHeaderStretchConfiguration;

export 'package:flutter/material.dart'
    hide
        // package:layout
        // ---
        Padding,
        Align,
        Center,
        Flex,
        Row,
        Column,
        Flexible,
        Expanded,
        Spacer,
        // ---
        // package:material
        // ---
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
        AnimatedIcons,
        // ---
        CircularProgressIndicator,
        LinearProgressIndicator,
        ProgressIndicator,
        // ---
        Checkbox,
        CheckboxTheme,
        CheckboxThemeData,
        // ---
        Switch,
        SwitchTheme,
        SwitchThemeData;

// Third-party packages

export 'package:meta/meta.dart';
export 'package:material_symbols_icons/material_symbols_icons.dart';

// Internal packages

export 'package:layout/layout.dart';
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
  );
}

extension EdgeInsetsGeometryExtension on EdgeInsetsGeometry {
  // TODO: improve and optimize this implementation
  EdgeInsetsGeometry _clampAxis({
    required double minHorizontal,
    required double maxHorizontal,
    required double minVertical,
    required double maxVertical,
  }) {
    final minNormal = EdgeInsets.symmetric(
      horizontal: minHorizontal,
      vertical: minVertical,
    );
    final maxNormal =
        EdgeInsets.symmetric(
          horizontal: maxHorizontal,
          vertical: maxVertical,
        ).add(
          EdgeInsetsDirectional.symmetric(
            horizontal: maxHorizontal,
            vertical: 0.0,
          ),
        );
    final minDirectional = EdgeInsetsDirectional.symmetric(
      horizontal: minHorizontal,
      vertical: minVertical,
    );
    final maxDirectional = EdgeInsetsDirectional.symmetric(
      horizontal: maxHorizontal,
      vertical: maxVertical,
    ).add(EdgeInsets.symmetric(horizontal: maxHorizontal, vertical: 0.0));
    final result = clamp(
      minNormal,
      maxNormal,
    ).clamp(minDirectional, maxDirectional);
    return result;
  }

  EdgeInsetsGeometry _horizontalInsetsMixed() => _clampAxis(
    minHorizontal: 0.0,
    maxHorizontal: double.infinity,
    minVertical: 0.0,
    maxVertical: 0.0,
  );

  EdgeInsetsGeometry _verticalInsetsMixed() => _clampAxis(
    minHorizontal: 0.0,
    maxHorizontal: 0.0,
    minVertical: 0.0,
    maxVertical: double.infinity,
  );

  EdgeInsetsGeometry horizontalInsets() {
    // if (kDebugMode) {
    //   return _ClampedEdgeInsets(
    //     this,
    //     minHorizontal: 0.0,
    //     maxHorizotal: double.infinity,
    //     minVertical: 0.0,
    //     maxVertical: 0.0,
    //   );
    // }
    if (this is EdgeInsets) {
      return (this as EdgeInsets)._horizontalInsets();
    }
    if (this is EdgeInsetsDirectional) {
      return (this as EdgeInsetsDirectional)._horizontalInsets();
    }
    return _horizontalInsetsMixed();
  }

  EdgeInsetsGeometry verticalInsets() {
    // if (kDebugMode) {
    //   return _ClampedEdgeInsets(
    //     this,
    //     minHorizontal: 0.0,
    //     maxHorizotal: 0.0,
    //     minVertical: 0.0,
    //     maxVertical: double.infinity,
    //   );
    // }
    if (this is EdgeInsets) {
      return (this as EdgeInsets)._verticalInsets();
    }
    if (this is EdgeInsetsDirectional) {
      return (this as EdgeInsetsDirectional)._verticalInsets();
    }
    return _verticalInsetsMixed();
  }
}

extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets _horizontalInsets() => EdgeInsets.fromLTRB(left, 0.0, right, 0.0);

  EdgeInsets _verticalInsets() => EdgeInsets.fromLTRB(0.0, top, 0.0, bottom);

  EdgeInsets horizontalInsets() => _horizontalInsets();

  EdgeInsets verticalInsets() => _verticalInsets();
}

extension EdgeInsetsDirectionalExtension on EdgeInsetsDirectional {
  EdgeInsetsDirectional _horizontalInsets() =>
      EdgeInsetsDirectional.fromSTEB(start, 0.0, end, 0.0);

  EdgeInsetsDirectional _verticalInsets() =>
      EdgeInsetsDirectional.fromSTEB(0.0, top, 0.0, bottom);

  EdgeInsetsDirectional horizontalInsets() => _horizontalInsets();

  EdgeInsetsDirectional verticalInsets() => _verticalInsets();
}

// class _ClampedEdgeInsets implements EdgeInsetsGeometry {
//   const _ClampedEdgeInsets(
//     this._parent, {
//     required double minHorizontal,
//     required double maxHorizotal,
//     required double minVertical,
//     required double maxVertical,
//   }) : _minHorizontal = minHorizontal,
//        _maxHorizontal = maxHorizotal,
//        _minVertical = minVertical,
//        _maxVertical = maxVertical;

//   final EdgeInsetsGeometry _parent;
//   final double _minHorizontal;
//   final double _maxHorizontal;
//   final double _minVertical;
//   final double _maxVertical;

//   @override
//   EdgeInsets resolve(TextDirection? direction) {
//     assert(direction != null);
//     final resolved = _parent.resolve(direction);
//     return EdgeInsets.fromLTRB(
//       clampDouble(resolved.left, _minHorizontal, _maxHorizontal),
//       clampDouble(resolved.top, _minVertical, _maxVertical),
//       clampDouble(resolved.right, _minHorizontal, _maxHorizontal),
//       clampDouble(resolved.bottom, _minVertical, _maxVertical),
//     );
//   }

//   @override
//   EdgeInsetsGeometry operator %(double other) {}

//   @override
//   EdgeInsetsGeometry operator *(double other) {
//     // TODO: implement *
//     throw UnimplementedError();
//   }

//   @override
//   EdgeInsetsGeometry operator /(double other) {}

//   @override
//   EdgeInsetsGeometry add(EdgeInsetsGeometry other) {}

//   @override
//   double along(Axis axis) {
//     return switch (axis) {
//       Axis.horizontal => horizontal,
//       Axis.vertical => vertical,
//     };
//   }

//   @override
//   EdgeInsetsGeometry clamp(EdgeInsetsGeometry min, EdgeInsetsGeometry max) {}

//   @override
//   Size get collapsedSize => Size(horizontal, vertical);

//   @override
//   Size deflateSize(Size size) {
//     return Size(size.width - horizontal, size.height - vertical);
//   }

//   @override
//   EdgeInsetsGeometry get flipped => _ClampedEdgeInsets(
//     _parent.flipped,
//     minHorizontal: _minHorizontal,
//     maxHorizotal: _maxHorizontal,
//     minVertical: _minVertical,
//     maxVertical: _maxVertical,
//   );

//   @override
//   double get horizontal => clampDouble(
//     _parent.horizontal,
//     _minHorizontal * 2.0,
//     _maxHorizontal * 2.0,
//   );

//   @override
//   Size inflateSize(Size size) {
//     return Size(size.width + horizontal, size.height + vertical);
//   }

//   @override
//   bool get isNonNegative =>
//       _parent.isNonNegative && _maxHorizontal >= 0.0 && _maxVertical >= 0.0;

//   @override
//   EdgeInsetsGeometry subtract(EdgeInsetsGeometry other) {}

//   @override
//   EdgeInsetsGeometry operator -() => _ClampedEdgeInsets(
//     -_parent,
//     minHorizontal: -_maxHorizontal,
//     maxHorizotal: -_minHorizontal,
//     minVertical: -_maxVertical,
//     maxVertical: -_minVertical,
//   );

//   @override
//   double get vertical =>
//       clampDouble(_parent.vertical, _minVertical * 2.0, _maxVertical * 2.0);

//   @override
//   EdgeInsetsGeometry operator ~/(double other) {}

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         runtimeType == other.runtimeType &&
//         other is _ClampedEdgeInsets &&
//         _parent == other._parent &&
//         _minHorizontal == other._minHorizontal &&
//         _maxHorizontal == other._maxHorizontal &&
//         _minVertical == other._minVertical &&
//         _maxVertical == other._maxVertical;
//   }

//   @override
//   int get hashCode => Object.hash(
//     runtimeType,
//     _parent,
//     _minHorizontal,
//     _maxHorizontal,
//     _minVertical,
//     _maxVertical,
//   );
// }
