import 'dart:math' as math;

import 'package:meta/meta.dart';

import 'point.dart';

@internal
double distance(double x, double y) => math.sqrt(x * x + y * y);

@internal
double distanceSquared(double x, double y) => x * x + y * y;

/// Returns unit vector representing the direction to this point from (0, 0).
@internal
Point directionVector(double x, double y) {
  final d = distance(x, y);
  assert(d > 0.0, "Required distance greater than zero");
  return Point(x / d, y / d);
}

@internal
Point directionVectorRadians(double angleRadians) =>
    Point(math.cos(angleRadians), math.sin(angleRadians));

@internal
Point radialToCartesian(
  double radius,
  double angleRadians, [
  Point center = Point.zero,
]) => directionVectorRadians(angleRadians) * radius + center;

@internal
const double distanceEpsilon = 1.0e-4;

@internal
const double angleEpsilon = 1.0e-6;

/// This epsilon is based on the observation that people tend to see
/// e.g. collinearity much more relaxed than what is mathematically correct.
/// This effect is heightened on smaller displays.
/// Use this epsilon for operations that allow higher tolerances.
@internal
const double relaxedDistanceEpsilon = 5.0e-3;

extension PointExtension on Point {
  @internal
  Point rotate90() => Point(-y, x);
}

@internal
const double twoPi = 2.0 * math.pi;

@internal
double square(double x) => x * x;

/// Linearly interpolate between [start] and [stop]
/// with [fraction] fraction between them.
@internal
double interpolateDouble(double start, double stop, double fraction) {
  return (1.0 - fraction) * start + fraction * stop;
}

/// Similar to num % mod, but ensures the result is always positive.
/// For example: 4 % 3 = positiveModulo(4, 3) = 1,
/// but: -4 % 3 = -1 positiveModulo(-4, 3) = 2
// TODO: rename num
@internal
double positiveModulo(double num, double mod) => (num % mod + mod) % mod;

/// Returns whether C is on the line defined by the two points AB.
@internal
bool collinearIsh(
  double aX,
  double aY,
  double bX,
  double bY,
  double cX,
  double cY, [
  double tolerance = distanceEpsilon,
]) {
  // The dot product of a perpendicular angle is 0. By rotating one of the vectors,
  // we save the calculations to convert the dot product to degrees afterwards.
  final ab = Point(bX - aX, bY - aY).rotate90();
  final ac = Point(cX - aX, cY - aY);
  final dotProduct = ab.dotProduct(ac).abs();
  final relativeTolerance = tolerance * ab.getDistance() * ac.getDistance();

  return dotProduct < tolerance || dotProduct < relativeTolerance;
}

/// Approximates whether corner at this vertex is concave or convex,
/// based on the relationship of the prev->curr/curr->next vectors.
@internal
bool convex(Point previous, Point current, Point next) {
  // TODO: b/369320447 - This is a fast, but not reliable calculation.
  return (current - previous).clockwise(next - current);
}

/*
 * Does a ternary search in [v0..v1] to find the parameter that minimizes the given function.
 * Stops when the search space size is reduced below the given tolerance.
 *
 * NTS: Does it make sense to split the function f in 2, one to generate a candidate, of a custom
 * type T (i.e. (Float) -> T), and one to evaluate it ( (T) -> Float )?
 */
@internal
double findMinimum(
  double v0,
  double v1,
  FindMinimumFunction f, {
  double tolerance = 1.0e-3,
}) {
  var a = v0;
  var b = v1;
  while (b - a > tolerance) {
    final c1 = (2.0 * a + b) / 3.0;
    final c2 = (2.0 * b + a) / 3.0;
    if (f(c1) < f(c2)) {
      b = c2;
    } else {
      a = c1;
    }
  }
  return (a + b) / 2.0;
}

@internal
typedef FindMinimumFunction = double Function(double value);

@internal
int binarySearchBy<E extends Object?, K extends Object?>(
  List<E> sortedList,
  K Function(E element) keyOf,
  int Function(K, K) compare,
  K value, [
  int start = 0,
  int? end,
]) {
  end = RangeError.checkValidRange(start, end, sortedList.length);
  var min = start;
  var max = end;
  while (min < max) {
    final mid = min + ((max - min) >> 1);
    final element = sortedList[mid];
    final comp = compare(keyOf(element), value);
    if (comp == 0) return mid;
    if (comp < 0) {
      min = mid + 1;
    } else {
      max = mid;
    }
  }
  return -min - 1;
}

@internal
extension IterableExtension<E extends Object?> on Iterable<E> {
  Iterable<T> scan<T extends Object?>(
    T initialValue,
    T Function(T previousValue, E element) combine,
  ) sync* {
    var value = initialValue;
    yield value;
    for (final element in this) {
      value = combine(value, element);
      yield value;
    }
  }
}
