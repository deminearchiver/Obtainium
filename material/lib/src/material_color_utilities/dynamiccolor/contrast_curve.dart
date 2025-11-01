import '../utils/math_utils.dart';

final class ContrastCurve {
  const ContrastCurve(this.low, this.normal, this.medium, this.high);

  final double low;
  final double normal;
  final double medium;
  final double high;

  double get(double contrastLevel) {
    return contrastLevel <= -1.0
        ? low
        : contrastLevel < 0.0
        ? MathUtils.lerp(low, normal, (contrastLevel - -1.0) / 1.0)
        : contrastLevel < 0.5
        ? MathUtils.lerp(normal, medium, (contrastLevel - 0.0) / 0.5)
        : contrastLevel < 1.0
        ? MathUtils.lerp(medium, high, (contrastLevel - 0.5) / 0.5)
        : high;
  }

  @override
  String toString() =>
      "ContrastCurve(${low.toStringAsFixed(1)}, ${normal.toStringAsFixed(1)}, "
      "${medium.toStringAsFixed(1)}, ${high.toStringAsFixed(1)})";

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is ContrastCurve &&
            low == other.low &&
            normal == other.normal &&
            medium == other.medium &&
            high == other.high;
  }

  @override
  int get hashCode => Object.hash(runtimeType, low, normal, medium, high);
}
