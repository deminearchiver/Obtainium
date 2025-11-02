part of '../androidx_graphics_shapes.dart';

@internal
final class MeasuredPolygon {
  MeasuredPolygon._(
    this._measurer,
    this.features,
    List<Cubic> cubics,
    List<double> outlineProgress,
  ) : _cubics = <MeasuredCubic>[] {
    // TODO: implement assertions here

    //     require(outlineProgress.size == cubics.size + 1) {
    //     "Outline progress size is expected to be the cubics size + 1"
    // }
    // require(outlineProgress.first() == 0f) {
    //     "First outline progress value is expected to be zero"
    // }
    // require(outlineProgress.last() == 1f) {
    //     "Last outline progress value is expected to be one"
    // }

    // if (DEBUG) {
    //     debugLog(LOG_TAG) {
    //         "CTOR: cubics = " +
    //             cubics.joinToString() +
    //             "\nCTOR: op = " +
    //             outlineProgress.joinToString()
    //     }
    // }
    double startOutlineProgress = 0.0;
    for (int index = 0; index < cubics.length; index++) {
      // Filter out "empty" cubics
      if ((outlineProgress[index + 1] - outlineProgress[index]) >
          distanceEpsilon) {
        _cubics.add(
          MeasuredCubic(
            this,
            cubics[index],
            startOutlineProgress,
            outlineProgress[index + 1],
          ),
        );
        // The next measured cubic will start exactly where this one ends.
        startOutlineProgress = outlineProgress[index + 1];
      }
    }
    // We could have removed empty cubics at the end. Ensure the last measured cubic ends at 1f
    _cubics[_cubics.length - 1].updateProgressRange(endOutlineProgress: 1.0);
  }

  final Measurer _measurer;
  final List<MeasuredCubic> _cubics;
  final List<ProgressableFeature> features;
}

/// Interface for measuring a cubic. Implementations can use whatever algorithm
/// desired to produce these measurement values.
@internal
abstract interface class Measurer {
  /// Returns size of given cubic, according to however the implementation wants
  /// to measure the size (angle, length, etc). It has to be greater or equal to 0.
  double measureCubic(Cubic c);

  /// Given a cubic and a measure that should be between 0 and the value
  /// returned by measureCubic (if not, it will be capped),
  /// finds the parameter t of the cubic at which that measure is reached.
  double findCubicCutPoint(Cubic c, double m);
}

@internal
final class MeasuredCubic {
  MeasuredCubic(
    this._owner,
    this.cubic,
    this._startOutlineProgress,
    this._endOutlineProgress,
  ) : measuredSize = _owner._measurer.measureCubic(cubic) {
    if (startOutlineProgress < 0.0 || startOutlineProgress > 1.0) {
      throw ArgumentError.value(
        startOutlineProgress,
        "startOutlineProgress",
        "startOutlineProgress must be between 0 and 1.",
      );
    }
    if (endOutlineProgress < 0.0 || endOutlineProgress > 1.0) {
      throw ArgumentError.value(
        endOutlineProgress,
        "endOutlineProgress",
        "endOutlineProgress must be between 0 and 1.",
      );
    }
    if (endOutlineProgress < startOutlineProgress) {
      throw ArgumentError(
        "endOutlineProgress is expected to be equal or greater than startOutlineProgress.",
      );
    }
  }

  final MeasuredPolygon _owner;
  final Cubic cubic;

  double _startOutlineProgress;
  double get startOutlineProgress => _startOutlineProgress;

  double _endOutlineProgress;
  double get endOutlineProgress => _endOutlineProgress;

  final double measuredSize;

  @internal
  void updateProgressRange({
    double? startOutlineProgress,
    double? endOutlineProgress,
  }) {
    startOutlineProgress ??= this.startOutlineProgress;
    endOutlineProgress ??= this.endOutlineProgress;
    if (endOutlineProgress < startOutlineProgress) {
      throw ArgumentError(
        "endOutlineProgress is expected to be equal or greater than startOutlineProgress.",
      );
    }
    _startOutlineProgress = startOutlineProgress;
    _endOutlineProgress = endOutlineProgress;
  }

  /// Cut this MeasuredCubic into two MeasuredCubics at the given outline progress value.
  (MeasuredCubic, MeasuredCubic) cutAtProgress(double cutOutlineProgress) {
    // Floating point errors further up can cause cutOutlineProgress to land just
    // slightly outside of the start/end progress for this cubic, so we limit it
    // to those bounds to avoid further errors later
    final boundedCutOutlineProgress = clampDouble(
      cutOutlineProgress,
      startOutlineProgress,
      endOutlineProgress,
    );
    final outlineProgressSize = endOutlineProgress - startOutlineProgress;
    final progressFromStart = boundedCutOutlineProgress - startOutlineProgress;

    // Note that in earlier parts of the computation, we have empty MeasuredCubics (cubics
    // with progressSize == 0f), but those cubics are filtered out before this method is
    // called.
    final relativeProgress = progressFromStart / outlineProgressSize;
    final t = _owner._measurer.findCubicCutPoint(
      cubic,
      relativeProgress * measuredSize,
    );

    if (t < 0.0 || t > 1.0) {
      throw ArgumentError("Cubic cut point is expected to be between 0 and 1.");
    }

    // debugLog(LOG_TAG) {
    //     "cutAtProgress: progress = $boundedCutOutlineProgress / " +
    //         "this = [$startOutlineProgress .. $endOutlineProgress] / " +
    //         "ps = $progressFromStart / rp = $relativeProgress / t = $t"
    // }

    // c1/c2 are the two new cubics, then we return MeasuredCubics created from them
    final (c1, c2) = cubic.split(t);
    return (
      MeasuredCubic(
        _owner,
        c1,
        startOutlineProgress,
        boundedCutOutlineProgress,
      ),
      MeasuredCubic(_owner, c2, boundedCutOutlineProgress, endOutlineProgress),
    );
  }

  @override
  String toString() =>
      "MeasuredCubic("
      "outlineProgress: [$startOutlineProgress .. $endOutlineProgress], "
      "size: $measuredSize, "
      "cubic: $cubic"
      ")";
}

/// Approximates the arc lengths of cubics by splitting the arc into segments
/// and calculating their sizes. The more segments, the more accurate the result
/// will be to the true arc length. The default implementation has at least
/// 98.5% accuracy on the case of a circular arc, which is the worst case for
/// our standard shapes.
@internal
final class LengthMeasurer implements Measurer {
  LengthMeasurer();

  @override
  double measureCubic(Cubic c) {
    return _closestProgressTo(c, double.infinity).$2;
  }

  @override
  double findCubicCutPoint(Cubic c, double m) {
    return _closestProgressTo(c, m).$1;
  }

  // The minimum number needed to achieve up to 98.5% accuracy from the true arc length
  // See PolygonMeasureTest.measureCircle
  static const int _segments = 3;

  (double, double) _closestProgressTo(Cubic cubic, double threshold) {
    double total = 0.0;
    var remainder = threshold;
    var prev = Point(cubic.anchor0X, cubic.anchor0Y);

    for (int i = 1; i <= _segments; i++) {
      final progress = i / _segments;
      final point = cubic.pointOnCurve(progress);
      final segment = (point - prev).getDistance();

      if (segment >= remainder) {
        return (progress - (1.0 - remainder / segment) / _segments, threshold);
      }

      remainder -= segment;
      total += segment;
      prev = point;
    }

    return (1.0, total);
  }
}
