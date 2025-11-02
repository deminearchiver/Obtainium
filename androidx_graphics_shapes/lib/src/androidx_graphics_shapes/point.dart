part of '../androidx_graphics_shapes.dart';

@immutable
class _Point {
  const _Point(this.x, this.y);

  final double x;
  final double y;

  _Point copyWith({double? x, double? y}) =>
      x != null || y != null ? _Point(x ?? this.x, y ?? this.y) : this;

  /// The magnitude of the Point, which is the distance of this point
  /// from (0, 0).
  ///
  /// If you need this value to compare it to another [Point]'s distance,
  /// consider using [getDistanceSquared] instead,
  /// since it is cheaper to compute.
  double getDistance() => math.sqrt(x * x + y * y);

  /// The square of the magnitude (which is the distance of this point
  /// from (0, 0)) of the Point.
  ///
  /// This is cheaper than computing the [getDistance] itself.
  double getDistanceSquared() => x * x + y * y;

  double dotProduct(_Point other) => x * other.x + y * other.y;

  double dotProductWith(double otherX, double otherY) =>
      x * otherX + y * otherY;

  /// Compute the Z coordinate of the cross product of two vectors,
  /// to check if the second vector is going clockwise ( > 0 )
  /// or counterclockwise (< 0) compared with the first one. It could also be 0,
  /// if the vectors are co-linear.
  bool clockwise(_Point other) => x * other.y - y * other.x >= 0.0;

  _Point getDirection() {
    final d = getDistance();
    assert(d > 0.0, "Can't get the direction of a 0-length vector");
    return this / d;
  }

  _Point transformed(PointTransformer f) {
    final result = f(x, y);
    return _Point(result.$1, result.$2);
  }

  _Point operator -() => _Point(-x, -y);

  _Point operator -(_Point other) => _Point(x - other.x, y - other.y);

  _Point operator +(_Point other) => _Point(x + other.x, y + other.y);

  _Point operator *(double operand) => _Point(x * operand, y * operand);

  _Point operator /(double operand) => _Point(x / operand, y / operand);

  _Point operator %(double operand) => _Point(x % operand, y % operand);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is _Point &&
            x == other.x &&
            y == other.y;
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  static _Point interpolate(_Point start, _Point stop, double fraction) =>
      _Point(
        _interpolate(start.x, stop.x, fraction),
        _interpolate(start.y, stop.y, fraction),
      );
}
