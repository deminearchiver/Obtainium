import 'package:meta/meta.dart';

@immutable
class CornerRounding {
  const CornerRounding({this.radius = 0.0, this.smoothing = 0.0})
    : assert(radius >= 0.0),
      assert(smoothing >= 0.0 && smoothing <= 1.0);

  final double radius;
  final double smoothing;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is CornerRounding &&
            radius == other.radius &&
            smoothing == other.smoothing;
  }

  @override
  int get hashCode => Object.hash(runtimeType, radius, smoothing);

  static const CornerRounding unrounded = CornerRounding();
}
