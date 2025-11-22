import 'package:material/src/material/flutter.dart';

class WindowSizeClass with Diagnosticable {
  const WindowSizeClass({
    required this.windowWidthSizeClass,
    required this.windowHeightSizeClass,
  });

  WindowSizeClass.fromSize(Size size)
    : windowWidthSizeClass = .fromWidth(size.width),
      windowHeightSizeClass = .fromHeight(size.height);

  final WindowWidthSizeClass windowWidthSizeClass;
  final WindowHeightSizeClass windowHeightSizeClass;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        EnumProperty<WindowWidthSizeClass>(
          "windowWidthSizeClass",
          windowWidthSizeClass,
        ),
      )
      ..add(
        EnumProperty<WindowHeightSizeClass>(
          "windowHeightSizeClass",
          windowHeightSizeClass,
        ),
      );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is WindowSizeClass &&
          windowWidthSizeClass == other.windowWidthSizeClass &&
          windowHeightSizeClass == other.windowHeightSizeClass;

  @override
  int get hashCode =>
      Object.hash(runtimeType, windowWidthSizeClass, windowHeightSizeClass);

  static WindowSizeClass? maybeOf(BuildContext context) {
    final size = MediaQuery.maybeSizeOf(context);
    return size != null ? .fromSize(size) : null;
  }

  static WindowSizeClass of(BuildContext context) =>
      .fromSize(MediaQuery.sizeOf(context));
}

enum WindowWidthSizeClass implements Comparable<WindowWidthSizeClass> {
  compact(_compactLowerBound),
  medium(_mediumLowerBound),
  expanded(_expandedLowerBound),
  large(_largeLowerBound),
  extraLarge(_extraLargeLowerBound);

  const WindowWidthSizeClass(this.breakpoint);

  factory WindowWidthSizeClass.fromWidth(double width) {
    assert(width >= 0.0);
    return switch (width) {
      >= _extraLargeLowerBound => extraLarge,
      >= _largeLowerBound => large,
      >= _expandedLowerBound => expanded,
      >= _mediumLowerBound => medium,
      _ => compact,
    };
  }

  final double breakpoint;

  bool operator <(WindowWidthSizeClass other) => breakpoint < other.breakpoint;

  bool operator <=(WindowWidthSizeClass other) =>
      breakpoint <= other.breakpoint;

  bool operator >(WindowWidthSizeClass other) => breakpoint > other.breakpoint;

  bool operator >=(WindowWidthSizeClass other) =>
      breakpoint >= other.breakpoint;

  @override
  int compareTo(WindowWidthSizeClass other) =>
      breakpoint.compareTo(other.breakpoint);

  static const double _compactLowerBound = 0.0;
  static const double _mediumLowerBound = 600.0;
  static const double _expandedLowerBound = 840.0;
  static const double _largeLowerBound = 1200.0;
  static const double _extraLargeLowerBound = 1600.0;

  static WindowWidthSizeClass? maybeOf(BuildContext context) {
    final width = MediaQuery.maybeWidthOf(context);
    return width != null ? .fromWidth(width) : null;
  }

  static WindowWidthSizeClass of(BuildContext context) =>
      .fromWidth(MediaQuery.widthOf(context));
}

enum WindowHeightSizeClass implements Comparable<WindowHeightSizeClass> {
  compact(_compactLowerBound),
  medium(_mediumLowerBound),
  expanded(_expandedLowerBound);

  const WindowHeightSizeClass(this.breakpoint);

  factory WindowHeightSizeClass.fromHeight(double height) {
    assert(height >= 0.0);
    return switch (height) {
      >= _expandedLowerBound => expanded,
      >= _mediumLowerBound => medium,
      _ => compact,
    };
  }

  final double breakpoint;

  bool operator <(WindowHeightSizeClass other) => breakpoint < other.breakpoint;

  bool operator <=(WindowHeightSizeClass other) =>
      breakpoint <= other.breakpoint;

  bool operator >(WindowHeightSizeClass other) => breakpoint > other.breakpoint;

  bool operator >=(WindowHeightSizeClass other) =>
      breakpoint >= other.breakpoint;

  @override
  int compareTo(WindowHeightSizeClass other) =>
      breakpoint.compareTo(other.breakpoint);

  static const double _compactLowerBound = 0.0;
  static const double _mediumLowerBound = 480.0;
  static const double _expandedLowerBound = 900.0;

  static WindowHeightSizeClass? maybeOf(BuildContext context) {
    final height = MediaQuery.maybeHeightOf(context);
    return height != null ? .fromHeight(height) : null;
  }

  static WindowHeightSizeClass of(BuildContext context) =>
      .fromHeight(MediaQuery.heightOf(context));
}
