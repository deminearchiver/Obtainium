import 'package:material/src/material/flutter.dart';

@immutable
class WindowSizeClass with Diagnosticable {
  const WindowSizeClass({
    required this.windowWidthSizeClass,
    required this.windowHeightSizeClass,
  });

  WindowSizeClass.fromSize(Size size)
    : windowWidthSizeClass = WindowWidthSizeClass.fromWidth(size.width),
      windowHeightSizeClass = WindowHeightSizeClass.fromHeight(size.height);

  final WindowWidthSizeClass windowWidthSizeClass;
  final WindowHeightSizeClass windowHeightSizeClass;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      EnumProperty<WindowWidthSizeClass>(
        "windowWidthSizeClass",
        windowWidthSizeClass,
      ),
    );
    properties.add(
      EnumProperty<WindowHeightSizeClass>(
        "windowHeightSizeClass",
        windowHeightSizeClass,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is WindowSizeClass &&
            windowWidthSizeClass == other.windowWidthSizeClass &&
            windowHeightSizeClass == other.windowHeightSizeClass;
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, windowWidthSizeClass, windowHeightSizeClass);

  static WindowSizeClass? maybeOf(BuildContext context) {
    final size = MediaQuery.maybeSizeOf(context);
    return size != null ? WindowSizeClass.fromSize(size) : null;
  }

  static WindowSizeClass of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WindowSizeClass.fromSize(size);
  }
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

  bool operator <(WindowWidthSizeClass other) {
    return breakpoint < other.breakpoint;
  }

  bool operator <=(WindowWidthSizeClass other) {
    return breakpoint <= other.breakpoint;
  }

  bool operator >(WindowWidthSizeClass other) {
    return breakpoint > other.breakpoint;
  }

  bool operator >=(WindowWidthSizeClass other) {
    return breakpoint >= other.breakpoint;
  }

  @override
  int compareTo(WindowWidthSizeClass other) {
    return breakpoint.compareTo(other.breakpoint);
  }

  static const double _compactLowerBound = 0.0;
  static const double _mediumLowerBound = 600.0;
  static const double _expandedLowerBound = 840.0;
  static const double _largeLowerBound = 1200.0;
  static const double _extraLargeLowerBound = 1600.0;

  static WindowWidthSizeClass? maybeOf(BuildContext context) {
    final size = MediaQuery.maybeSizeOf(context);
    return size != null ? WindowWidthSizeClass.fromWidth(size.width) : null;
  }

  static WindowWidthSizeClass of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WindowWidthSizeClass.fromWidth(size.width);
  }
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

  bool operator <(WindowHeightSizeClass other) {
    return breakpoint < other.breakpoint;
  }

  bool operator <=(WindowHeightSizeClass other) {
    return breakpoint <= other.breakpoint;
  }

  bool operator >(WindowHeightSizeClass other) {
    return breakpoint > other.breakpoint;
  }

  bool operator >=(WindowHeightSizeClass other) {
    return breakpoint >= other.breakpoint;
  }

  @override
  int compareTo(WindowHeightSizeClass other) {
    return breakpoint.compareTo(other.breakpoint);
  }

  static const double _compactLowerBound = 0.0;
  static const double _mediumLowerBound = 480.0;
  static const double _expandedLowerBound = 900.0;

  static WindowHeightSizeClass? maybeOf(BuildContext context) {
    final size = MediaQuery.maybeSizeOf(context);
    return size != null ? WindowHeightSizeClass.fromHeight(size.height) : null;
  }

  static WindowHeightSizeClass of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WindowHeightSizeClass.fromHeight(size.height);
  }
}
