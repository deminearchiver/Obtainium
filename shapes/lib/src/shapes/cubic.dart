import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:meta/meta.dart';

import 'features.dart';
import 'point.dart';
import 'utils.dart';

abstract class Cubic {
  const Cubic();

  @internal
  const factory Cubic.empty(double x0, double y0) = _Cubic.empty;

  const factory Cubic.from(
    double anchor0X,
    double anchor0Y,
    double control0X,
    double control0Y,
    double control1X,
    double control1Y,
    double anchor1X,
    double anchor1Y,
  ) = _Cubic;

  @internal
  factory Cubic.fromPoints(
    Point anchor0,
    Point control0,
    Point control1,
    Point anchor1,
  ) => Cubic.from(
    anchor0.x,
    anchor0.y,
    control0.x,
    control0.y,
    control1.x,
    control1.y,
    anchor1.x,
    anchor1.y,
  );

  factory Cubic.straightLine(double x0, double y0, double x1, double y1) =>
      Cubic.from(
        x0,
        y0,
        interpolateDouble(x0, x1, 1.0 / 3.0),
        interpolateDouble(y0, y1, 1.0 / 3.0),
        interpolateDouble(x0, x1, 2.0 / 3.0),
        interpolateDouble(y0, y1, 2.0 / 3.0),
        x1,
        y1,
      );

  factory Cubic.circularArc(
    double centerX,
    double centerY,
    double x0,
    double y0,
    double x1,
    double y1,
  ) {
    final p0d = directionVector(x0 - centerX, y0 - centerY);
    final p1d = directionVector(x1 - centerX, y1 - centerY);
    final rotatedP0 = p0d.rotate90();
    final rotatedP1 = p1d.rotate90();
    final clockwise =
        rotatedP0.dotProductWith(x1 - centerX, y1 - centerY) >= 0.0;

    final cosa = p0d.dotProduct(p1d);
    if (cosa > 0.999) /* p0 ~= p1 */ return Cubic.straightLine(x0, y0, x1, y1);

    final k =
        distance(x0 - centerX, y0 - centerY) *
        4.0 /
        3.0 *
        (math.sqrt(2.0 * (1.0 - cosa)) - math.sqrt(1 - cosa * cosa)) /
        (1 - cosa) *
        (clockwise ? 1.0 : -1.0);

    return Cubic.from(
      x0,
      y0,
      x0 + rotatedP0.x * k,
      y0 + rotatedP0.y * k,
      x1 - rotatedP1.x * k,
      y1 - rotatedP1.y * k,
      x1,
      y1,
    );
  }

  double get anchor0X;
  double get anchor0Y;
  double get control0X;
  double get control0Y;
  double get control1X;
  double get control1Y;
  double get anchor1X;
  double get anchor1Y;

  @internal
  Point pointOnCurve(double t) {
    final u = 1.0 - t;
    return Point(
      anchor0X * (u * u * u) +
          control0X * (3.0 * t * u * u) +
          control1X * (3.0 * t * t * u) +
          anchor1X * (t * t * t),
      anchor0Y * (u * u * u) +
          control0Y * (3.0 * t * u * u) +
          control1Y * (3.0 * t * t * u) +
          anchor1Y * (t * t * t),
    );
  }

  @internal
  bool zeroLength() =>
      (anchor0X - anchor1X).abs() < distanceEpsilon &&
      (anchor0Y - anchor1Y).abs() < distanceEpsilon;

  @internal
  bool convexTo(Cubic next) {
    final prevVertex = Point(anchor0X, anchor0Y);
    final currVertex = Point(anchor1X, anchor1Y);
    final nextVertex = Point(next.anchor1X, next.anchor1Y);
    return convex(prevVertex, currVertex, nextVertex);
  }

  @internal
  ui.Rect calculateBounds({bool approximate = false}) {
    // A curve might be of zero-length, with both anchors co-lated.
    // Just return the point itself.
    if (zeroLength()) {
      return ui.Rect.fromLTRB(anchor0X, anchor0Y, anchor0X, anchor0Y);
    }

    var minX = math.min(anchor0X, anchor1X);
    var minY = math.min(anchor0Y, anchor1Y);
    var maxX = math.max(anchor0X, anchor1X);
    var maxY = math.max(anchor0Y, anchor1Y);

    if (approximate) {
      // Approximate bounds use the bounding box of all anchors and controls
      return ui.Rect.fromLTRB(
        math.min(minX, math.min(control0X, control1X)),
        math.min(minY, math.min(control0Y, control1Y)),
        math.max(maxX, math.max(control0X, control1X)),
        math.max(maxY, math.max(control0Y, control1Y)),
      );
    }

    // Find the derivative, which is a quadratic Bezier. Then we can solve for t using
    // the quadratic formula
    final xa = -anchor0X + 3.0 * control0X - 3.0 * control1X + anchor1X;
    final xb = 2.0 * anchor0X - 4.0 * control0X + 2.0 * control1X;
    final xc = -anchor0X + control0X;

    if (_zeroIsh(xa)) {
      // Try Muller's method instead; it can find a single root when a is 0
      if (xb != 0.0) {
        final t = 2.0 * xc / (-2.0 * xb);
        if (t >= 0.0 && t <= 1.0) {
          final x = pointOnCurve(t).x;
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
        }
      }
    } else {
      final xs = xb * xb - 4.0 * xa * xc;
      if (xs >= 0.0) {
        final t1 = (-xb + math.sqrt(xs)) / (2.0 * xa);
        if (t1 >= 0.0 && t1 <= 1.0) {
          final x = pointOnCurve(t1).x;
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
        }

        final t2 = (-xb - math.sqrt(xs)) / (2.0 * xa);
        if (t2 >= 0.0 && t2 <= 1.0) {
          final x = pointOnCurve(t2).x;
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
        }
      }
    }

    // Repeat the above for y coordinate
    final ya = -anchor0Y + 3.0 * control0Y - 3.0 * control1Y + anchor1Y;
    final yb = 2.0 * anchor0Y - 4.0 * control0Y + 2.0 * control1Y;
    final yc = -anchor0Y + control0Y;

    if (_zeroIsh(ya)) {
      if (yb != 0.0) {
        final t = 2.0 * yc / (-2.0 * yb);
        if (t >= 0.0 && t <= 1.0) {
          final y = pointOnCurve(t).y;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    } else {
      final ys = yb * yb - 4.0 * ya * yc;
      if (ys >= 0.0) {
        final t1 = (-yb + math.sqrt(ys)) / (2.0 * ya);
        if (t1 >= 0.0 && t1 <= 1.0) {
          final y = pointOnCurve(t1).y;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }

        final t2 = (-yb - math.sqrt(ys)) / (2.0 * ya);
        if (t2 >= 0.0 && t2 <= 1.0) {
          final y = pointOnCurve(t2).y;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    }

    return ui.Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  /// Returns two Cubics, created by splitting this curve at the given distance of [t] between the
  /// original starting and ending anchor points.
  // TODO: cartesian optimization?
  (Cubic, Cubic) split(double t) {
    final u = 1.0 - t;
    final pointOnCurve = this.pointOnCurve(t);

    // Shared calculations
    final uSquared = u * u;
    final tSquared = t * t;
    final twoUt = 2.0 * u * t;

    return (
      Cubic.from(
        anchor0X,
        anchor0Y,
        anchor0X * u + control0X * t,
        anchor0Y * u + control0Y * t,
        anchor0X * uSquared + control0X * twoUt + control1X * tSquared,
        anchor0Y * uSquared + control0Y * twoUt + control1Y * tSquared,
        pointOnCurve.x,
        pointOnCurve.y,
      ),
      Cubic.from(
        pointOnCurve.x,
        pointOnCurve.y,
        control0X * uSquared + control1X * twoUt + anchor1X * tSquared,
        control0Y * uSquared + control1Y * twoUt + anchor1Y * tSquared,
        control1X * u + anchor1X * t,
        control1Y * u + anchor1Y * t,
        anchor1X,
        anchor1Y,
      ),
    );
  }

  Cubic reverse() => Cubic.from(
    anchor1X,
    anchor1Y,
    control1X,
    control1Y,
    control0X,
    control0Y,
    anchor0X,
    anchor0Y,
  );

  Cubic transformed(PointTransformer f) {
    final anchor0 = f(anchor0X, anchor0Y);
    final control0 = f(control0X, control0Y);
    final control1 = f(control1X, control1Y);
    final anchor1 = f(anchor1X, anchor1Y);
    return Cubic.from(
      anchor0.$1,
      anchor0.$2,
      control0.$1,
      control0.$2,
      control1.$1,
      control1.$2,
      anchor1.$1,
      anchor1.$2,
    );
  }

  /// Convert to [Edge] if this cubic describes a straight line, otherwise to a
  /// [Corner]. Corner convexity is determined by [convex].
  @internal
  Feature asFeature(Cubic next) =>
      straightIsh() ? Edge([this]) : Corner([this], convexTo(next));

  /// Determine if the cubic is close to a straight line.
  /// Empty cubics don't count as straightIsh.
  @internal
  bool straightIsh() =>
      !zeroLength() &&
      collinearIsh(
        anchor0X,
        anchor0Y,
        anchor1X,
        anchor1Y,
        control0X,
        control0Y,
        relaxedDistanceEpsilon,
      ) &&
      collinearIsh(
        anchor0X,
        anchor0Y,
        anchor1X,
        anchor1Y,
        control1X,
        control1Y,
        relaxedDistanceEpsilon,
      );

  /// Determines if next is a smooth continuation of this cubic. Smooth meaning
  /// that the first control point of next is a reflection of this' second
  /// control point, similar to the S/s or t/T command in svg paths
  /// https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths#b%C3%A9zier_curves
  @internal
  bool smoothesIntoIsh(Cubic next) => collinearIsh(
    control1X,
    control1Y,
    next.control0X,
    next.control0Y,
    anchor1X,
    anchor1Y,
    relaxedDistanceEpsilon,
  );

  /// Determines if all of this' points align with next's points. For straight
  /// lines, this is the same as if next was a continuation of this.
  @internal
  bool alignsIshWith(Cubic next) =>
      straightIsh() && next.straightIsh() && smoothesIntoIsh(next) ||
      zeroLength() ||
      next.zeroLength();

  Cubic operator +(Cubic o) => Cubic.from(
    anchor0X + o.anchor0X,
    anchor0Y + o.anchor0Y,
    control0X + o.control0X,
    control0Y + o.control0Y,
    control1X + o.control1X,
    control1Y + o.control1Y,
    anchor1X + o.anchor1X,
    anchor1Y + o.anchor1Y,
  );

  Cubic operator *(double x) => Cubic.from(
    anchor0X * x,
    anchor0Y * x,
    control0X * x,
    control0Y * x,
    control1X * x,
    control1Y * x,
    anchor1X * x,
    anchor1Y * x,
  );

  Cubic operator /(double x) => Cubic.from(
    anchor0X / x,
    anchor0Y / x,
    control0X / x,
    control0Y / x,
    control1X / x,
    control1Y / x,
    anchor1X / x,
    anchor1Y / x,
  );

  @override
  String toString() =>
      "Cubic("
      "anchor0: ($anchor0X, $anchor0Y), "
      "control0: ($control0X, $control0Y), "
      "control1: ($control1X, $control1Y), "
      "anchor1: ($anchor1X, $anchor1Y)"
      ")";

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is Cubic &&
            anchor0X == other.anchor0X &&
            anchor0Y == other.anchor0Y &&
            control0X == other.control0X &&
            control0Y == other.control0Y &&
            control1X == other.control1X &&
            control1Y == other.control1Y &&
            anchor1X == other.anchor1X &&
            anchor1Y == other.anchor1Y;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    anchor0X,
    anchor0Y,
    control0X,
    control0Y,
    control1X,
    control1Y,
    anchor1X,
    anchor1Y,
  );

  static bool _zeroIsh(double value) => value.abs() < distanceEpsilon;

  static Cubic interpolate(Cubic c1, Cubic c2, double progress) => Cubic.from(
    interpolateDouble(c1.anchor0X, c2.anchor0X, progress),
    interpolateDouble(c1.anchor0Y, c2.anchor0Y, progress),
    interpolateDouble(c1.control0X, c2.control0X, progress),
    interpolateDouble(c1.control0Y, c2.control0Y, progress),
    interpolateDouble(c1.control1X, c2.control1X, progress),
    interpolateDouble(c1.control1Y, c2.control1Y, progress),
    interpolateDouble(c1.anchor1X, c2.anchor1X, progress),
    interpolateDouble(c1.anchor1Y, c2.anchor1Y, progress),
  );

  /// Create a new cubic by extending A to B's second anchor point.
  // TODO: make this private to feature_detector.dart
  @internal
  static Cubic extend(Cubic a, Cubic b) => a.zeroLength()
      ? Cubic.from(
          a.anchor0X,
          a.anchor0Y,
          b.control0X,
          b.control0Y,
          b.control1X,
          b.control1Y,
          b.anchor1X,
          b.anchor1Y,
        )
      : Cubic.from(
          a.anchor0X,
          a.anchor0Y,
          a.control0X,
          a.control0Y,
          a.control1X,
          a.control1Y,
          b.anchor1X,
          b.anchor1Y,
        );
}

class _Cubic extends Cubic {
  const _Cubic(
    this.anchor0X,
    this.anchor0Y,
    this.control0X,
    this.control0Y,
    this.control1X,
    this.control1Y,
    this.anchor1X,
    this.anchor1Y,
  );

  const _Cubic.empty(double x0, double y0)
    : this(x0, y0, x0, y0, x0, y0, x0, y0);

  @override
  final double anchor0X;

  @override
  final double anchor0Y;

  @override
  final double control0X;

  @override
  final double control0Y;

  @override
  final double control1X;

  @override
  final double control1Y;

  @override
  final double anchor1X;

  @override
  final double anchor1Y;
}

/// This interface is used refer to Points that can be modified,
/// as a scope to [PointTransformer].
abstract interface class MutablePoint {
  double get x;
  set x(double value);

  double get y;
  set y(double value);
}

typedef TransformResult = (double x, double y);

typedef PointTransformer = TransformResult Function(double x, double y);

abstract class MutableCubic extends Cubic {
  MutableCubic();

  @internal
  factory MutableCubic.empty(double x0, double y0) = _MutableCubic.empty;

  factory MutableCubic.from(
    double anchor0X,
    double anchor0Y,
    double control0X,
    double control0Y,
    double control1X,
    double control1Y,
    double anchor1X,
    double anchor1Y,
  ) = _MutableCubic;

  factory MutableCubic.fromCubic(Cubic other) => MutableCubic.from(
    other.anchor0X,
    other.anchor0Y,
    other.control0X,
    other.control0Y,
    other.control1X,
    other.control1Y,
    other.anchor1X,
    other.anchor1Y,
  );

  set anchor0X(double value);
  set anchor0Y(double value);
  set control0X(double value);
  set control0Y(double value);
  set control1X(double value);
  set control1Y(double value);
  set anchor1X(double value);
  set anchor1Y(double value);

  void transform(PointTransformer f) {
    final anchor0 = f(anchor0X, anchor0Y);
    final control0 = f(control0X, control0Y);
    final control1 = f(control1X, control1Y);
    final anchor1 = f(anchor1X, anchor1Y);

    anchor0X = anchor0.$1;
    anchor0Y = anchor0.$2;
    control0X = control0.$1;
    control0Y = control0.$2;
    control1X = control1.$1;
    control1Y = control1.$2;
    anchor1X = anchor1.$1;
    anchor1Y = anchor1.$2;
  }

  void interpolate(Cubic c1, Cubic c2, double progress) {
    anchor0X = interpolateDouble(c1.anchor0X, c2.anchor0X, progress);
    anchor0Y = interpolateDouble(c1.anchor0Y, c2.anchor0Y, progress);
    control0X = interpolateDouble(c1.control0X, c2.control0X, progress);
    control0Y = interpolateDouble(c1.control0Y, c2.control0Y, progress);
    control1X = interpolateDouble(c1.control1X, c2.control1X, progress);
    control1Y = interpolateDouble(c1.control1Y, c2.control1Y, progress);
    anchor1X = interpolateDouble(c1.anchor1X, c2.anchor1X, progress);
    anchor1Y = interpolateDouble(c1.anchor1Y, c2.anchor1Y, progress);
  }

  @override
  String toString() =>
      "MutableCubic("
      "anchor0: ($anchor0X, $anchor0Y), "
      "control0: ($control0X, $control0Y), "
      "control1: ($control1X, $control1Y), "
      "anchor1: ($anchor1X, $anchor1Y)"
      ")";
}

class _MutableCubic extends MutableCubic {
  _MutableCubic(
    this.anchor0X,
    this.anchor0Y,
    this.control0X,
    this.control0Y,
    this.control1X,
    this.control1Y,
    this.anchor1X,
    this.anchor1Y,
  );

  _MutableCubic.empty(double x0, double y0)
    : this(x0, y0, x0, y0, x0, y0, x0, y0);

  @override
  double anchor0X;

  @override
  double anchor0Y;

  @override
  double control0X;

  @override
  double control0Y;

  @override
  double control1X;

  @override
  double control1Y;

  @override
  double anchor1X;

  @override
  double anchor1Y;
}
