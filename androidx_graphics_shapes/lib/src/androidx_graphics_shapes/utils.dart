part of '../androidx_graphics_shapes.dart';

double _distance(double x, double y) => math.sqrt(x * x + y * y);
double _distanceSquared(double x, double y) => x * x + y * y;

/// Returns unit vector representing the direction to this point from (0, 0).
_Point _directionVector(double x, double y) {
  final d = _distance(x, y);
  assert(d > 0.0, "Required distance greater than zero");
  return _Point(x / d, y / d);
}

_Point _directionVectorRadians(double angleRadians) =>
    _Point(math.cos(angleRadians), math.sin(angleRadians));

_Point _radialToCartesian(
  double radius,
  double angleRadians, [
  _Point center = _zero,
]) => _directionVectorRadians(angleRadians) * radius + center;

const double _distanceEpsilon = 1.0e-4;
const double _angleEpsilon = 1.0e-6;

/// This epsilon is based on the observation that people tend to see
/// e.g. collinearity much more relaxed than what is mathematically correct.
/// This effect is heightened on smaller displays.
/// Use this epsilon for operations that allow higher tolerances.
const double _relaxedDistanceEpsilon = 5.0e-3;

extension _PointExtension on _Point {
  _Point rotate90() => _Point(-y, x);
}

const _Point _zero = _Point(0.0, 0.0);

const double _twoPi = 2.0 * math.pi;

double _square(double x) => x * x;

/// Linearly interpolate between [start] and [stop]
/// with [fraction] fraction between them.
double _interpolate(double start, double stop, double fraction) {
  return (1.0 - fraction) * start + fraction * stop;
}

/// Similar to num % mod, but ensures the result is always positive.
/// For example: 4 % 3 = positiveModulo(4, 3) = 1,
/// but: -4 % 3 = -1 positiveModulo(-4, 3) = 2
// TODO: rename num
double _positiveModulo(double num, double mod) => (num % mod + mod) % mod;

/// Returns whether C is on the line defined by the two points AB.
bool _collinearIsh(
  double aX,
  double aY,
  double bX,
  double bY,
  double cX,
  double cY, [
  double tolerance = _distanceEpsilon,
]) {
  // The dot product of a perpendicular angle is 0. By rotating one of the vectors,
  // we save the calculations to convert the dot product to degrees afterwards.
  final ab = _Point(bX - aX, bY - aY).rotate90();
  final ac = _Point(cX - aX, cY - aY);
  final dotProduct = ab.dotProduct(ac).abs();
  final relativeTolerance = tolerance * ab.getDistance() * ac.getDistance();

  return dotProduct < tolerance || dotProduct < relativeTolerance;
}

/// Approximates whether corner at this vertex is concave or convex,
/// based on the relationship of the prev->curr/curr->next vectors.
bool _convex(_Point previous, _Point current, _Point next) {
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
double _findMinimum(
  double v0,
  double v1,
  _FindMinimumFunction f, {
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

typedef _FindMinimumFunction = double Function(double value);
