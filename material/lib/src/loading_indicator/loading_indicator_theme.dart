import 'package:material/src/flutter.dart';

/// Defines the visual properties of [IndeterminateLoadingIndicator] widgets.
///
/// Used by [LoadingIndicatorTheme] to control the visual properties of
/// loading indicators in a widget subtree.
///
/// To obtain this configuration, use [LoadingIndicatorTheme.maybeOf] to access
/// the closest ancestor [LoadingIndicatorTheme] of the current [BuildContext].
///
/// See also:
///
///  * [LoadingIndicatorTheme], an [InheritedWidget] that propagates the
///    theme down its subtree.
@immutable
class LoadingIndicatorThemeData with Diagnosticable {
  /// Creates the set of properties used to configure [IndeterminateLoadingIndicator]
  /// widgets.
  const LoadingIndicatorThemeData({
    this.indicatorColor,
    this.containedIndicatorColor,
    this.containedContainerColor,
  });

  /// The color of the uncontained [IndeterminateLoadingIndicator]'s active indicator.
  ///
  /// If null, the active indicator color will default to [ColorThemeData.primary]
  final Color? indicatorColor;

  /// The color of the contained [IndeterminateLoadingIndicator]'s active indicator.
  ///
  /// If null, the active indicator color will default to
  /// [ColorThemeData.onPrimaryContainer]
  final Color? containedIndicatorColor;

  /// The color of the [IndeterminateLoadingIndicator]'s container.
  ///
  /// If null, then the ambient theme's [ColorScheme.primaryContainer]
  /// will be used to draw the container.
  final Color? containedContainerColor;

  /// Creates a copy of this object but with the given fields replaced with the
  /// new values.
  LoadingIndicatorThemeData copyWith({
    Color? indicatorColor,
    Color? containedIndicatorColor,
    Color? containedContainerColor,
  }) =>
      // TODO: migrate other ThemeDatas' copyWith implementation to follow this skeleton
      indicatorColor != null ||
          containedIndicatorColor != null ||
          containedContainerColor != null
      ? LoadingIndicatorThemeData(
          indicatorColor: indicatorColor ?? this.indicatorColor,
          containedIndicatorColor:
              containedIndicatorColor ?? this.containedIndicatorColor,
          containedContainerColor:
              containedContainerColor ?? this.containedContainerColor,
        )
      : this;

  /// Linearly interpolate between two loading indicator themes.
  ///
  /// If both arguments are null, then null is returned.
  static LoadingIndicatorThemeData? lerp(
    LoadingIndicatorThemeData? a,
    LoadingIndicatorThemeData? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    return LoadingIndicatorThemeData(
      indicatorColor: Color.lerp(a?.indicatorColor, b?.indicatorColor, t),
      containedContainerColor: Color.lerp(
        a?.containedContainerColor,
        b?.containedContainerColor,
        t,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // TODO: migrate other ThemeDatas' debugFillProperties to use ..add
    properties
      ..add(
        ColorProperty(
          "activeIndicatorColor",
          indicatorColor,
          defaultValue: null,
        ),
      )
      ..add(
        ColorProperty(
          "containedIndicatorColor",
          containedIndicatorColor,
          defaultValue: null,
        ),
      )
      ..add(
        ColorProperty(
          "containedContainerColor",
          containedContainerColor,
          defaultValue: null,
        ),
      );
  }

  @override
  bool operator ==(Object other) =>
      // TODO: migrate other ThemeData's == implementation to use arrow syntax
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is LoadingIndicatorThemeData &&
          indicatorColor == other.indicatorColor &&
          containedIndicatorColor == other.containedIndicatorColor &&
          containedContainerColor == other.containedContainerColor;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    indicatorColor,
    containedIndicatorColor,
    containedContainerColor,
  );
}

/// An inherited widget that defines the configuration for [IndeterminateLoadingIndicator]s
/// in this widget's subtree.
///
/// Values specified here are used for [IndeterminateLoadingIndicator] properties that are
/// not given an explicit non-null value.
///
/// {@tool snippet}
///
/// Here is an example of a loading indicator theme that applies a red active
/// indicator color.
///
/// ```dart
/// const LoadingIndicatorTheme(
///   data: LoadingIndicatorThemeData(
///     activeIndicatorColor: Colors.red,
///   ),
///   child: LoadingIndicator(),
/// )
/// ```
/// {@end-tool}
class LoadingIndicatorTheme extends InheritedTheme {
  /// Creates a theme that controls the configurations for [IndeterminateLoadingIndicator]
  /// widgets.
  const LoadingIndicatorTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The properties for descendant [IndeterminateLoadingIndicator] widgets.
  final LoadingIndicatorThemeData data;

  @override
  bool updateShouldNotify(LoadingIndicatorTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return LoadingIndicatorTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<LoadingIndicatorThemeData>("data", data),
    );
  }

  /// Returns the [data] from the closest [LoadingIndicatorTheme] ancestor. If
  /// there is no ancestor, it returns null.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// LoadingIndicatorThemeData? theme = LoadingIndicatorTheme.of(context);
  /// ```
  static LoadingIndicatorThemeData? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LoadingIndicatorTheme>()
        ?.data;
  }
}
