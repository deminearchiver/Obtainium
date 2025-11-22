import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:material/src/material/flutter.dart';

double? _clampCornerComponent(double? value, double? min, double? max) {
  assert(
    (min == null || max == null) || (min <= max && !max.isNaN && !min.isNaN),
  );

  if (value == null) {
    return max;
  }
  if (min == null) return null;
  if (max == null) {
    return value < min ? min : value;
  }
  return value > max ? max : value;
}

extension RadiusExtension on Radius {
  @Deprecated("Use Corner.fromRadius instead")
  Corner toCorner() => Corner.fromRadius(this);
}

@immutable
class Corner {
  const Corner.circular(double? radius) : this.elliptical(radius, radius);
  const Corner.elliptical(this.x, this.y);

  Corner.fromRadius(Radius radius) : this.elliptical(radius.x, radius.y);

  final double? x;
  final double? y;

  Corner clamp({Corner minimum = Corner.none, Corner maximum = Corner.full}) {
    return Corner.elliptical(
      _clampCornerComponent(x, minimum.x, maximum.x),
      _clampCornerComponent(y, minimum.y, maximum.y),
    );
  }

  Corner clampValues({
    // TODO: investigate if change from -infinity to 0 affects any behaviors
    double? minimumX = 0.0,
    double? minimumY = 0.0,
    double? maximumX,
    double? maximumY,
  }) {
    return Corner.elliptical(
      _clampCornerComponent(x, minimumX, maximumX),
      _clampCornerComponent(y, minimumY, maximumY),
    );
  }

  Radius toRadius({
    required Rect rect,
    required double? adjacentX,
    required double? adjacentY,
  }) {
    final Rect(:width, :height, :shortestSide) = rect;
    final Corner(:x, :y) = this;
    // double resultX;
    // double resultY;
    double resultX = switch ((x, adjacentX)) {
      (null, null) => shortestSide / 2.0,
      (null, final adjacentX?) => ui.clampDouble(
        width - adjacentX,
        0.0,
        shortestSide,
      ),
      (final x?, _) => x,
    };
    double resultY = switch ((y, adjacentY)) {
      (null, null) => shortestSide / 2.0,
      (null, final adjacentY?) => ui.clampDouble(
        height - adjacentY,
        0.0,
        shortestSide,
      ),
      (final y?, _) => y,
    };
    // if (x == null) {
    //   if (horizontalX == null) {
    //     resultX = shortestSide / 2.0;
    //   } else {
    //     resultX = ui.clampDouble(width - horizontalX, 0.0, shortestSide);
    //   }
    // } else {
    //   resultX = x;
    // }
    // if (y == null) {
    //   if (verticalY == null) {
    //     resultY = shortestSide / 2.0;
    //   } else {
    //     resultY = ui.clampDouble(height - verticalY, 0.0, shortestSide);
    //   }
    // } else {
    //   resultY = y;
    // }
    if (x == null && y == null) {
      final min = math.min(resultX, resultY);
      resultX = min;
      resultY = min;
    }
    return Radius.elliptical(resultX, resultY);
  }

  Corner operator -() =>
      Corner.elliptical(x != null ? -x! : null, y != null ? -y! : null);

  Corner operator -(Corner other) => Corner.elliptical(
    x != null && other.x != null ? x! - other.x! : null,
    y != null && other.y != null ? y! - other.y! : null,
  );

  Corner operator +(Corner other) => Corner.elliptical(
    x != null && other.x != null ? x! + other.x! : null,
    y != null && other.y != null ? y! + other.y! : null,
  );

  Corner operator *(double operand) => Corner.elliptical(
    x != null ? x! * operand : null,
    y != null ? y! * operand : null,
  );

  Corner operator /(double operand) => Corner.elliptical(
    x != null ? x! / operand : null,
    y != null ? y! / operand : null,
  );

  Corner operator ~/(double operand) => Corner.elliptical(
    x != null ? (x! ~/ operand).toDouble() : null,
    y != null ? (y! ~/ operand).toDouble() : null,
  );

  Corner operator %(double operand) => Corner.elliptical(
    x != null ? x! % operand : null,
    y != null ? y! % operand : null,
  );

  static Corner? lerp(Corner? a, Corner? b, double t) {
    if (b == null) {
      if (a == null) {
        return null;
      } else {
        final double k = 1.0 - t;
        return Corner.elliptical(
          a.x != null ? a.x! * k : null,
          a.y != null ? a.y! * k : null,
        );
      }
    } else {
      if (a == null) {
        return Corner.elliptical(
          b.x != null ? b.x! * t : null,
          b.y != null ? b.y! * t : null,
        );
      } else {
        return Corner.elliptical(
          ui.lerpDouble(a.x, b.x, t),
          ui.lerpDouble(a.y, b.y, t),
        );
      }
    }
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is Corner &&
            x == other.x &&
            y == other.y;
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @override
  String toString() {
    final cachedRuntimeType = objectRuntimeType(this, "Corner");
    return x == y
        ? "$cachedRuntimeType.circular("
              "${x?.toStringAsFixed(1) ?? "full"}"
              ")"
        : "$cachedRuntimeType.elliptical("
              "${x?.toStringAsFixed(1) ?? "full"}, "
              "${y?.toStringAsFixed(1) ?? "full"}"
              ")";
  }

  static const Corner none = Corner.circular(0.0);
  static const Corner full = Corner.circular(null);
}

@immutable
class _CornerLerp implements Corner {
  const _CornerLerp(this.a, this.b, this.t);

  final Corner a;
  final Corner b;
  final double t;

  @override
  double? get x => switch ((a.x, b.x)) {
    (final aX?, final bX?) => ui.lerpDouble(aX, bX, t)!,
    _ => null,
  };

  @override
  double? get y => switch ((a.y, b.y)) {
    (final aY?, final bY?) => ui.lerpDouble(aY, bY, t)!,
    _ => null,
  };

  @override
  Corner clamp({Corner minimum = Corner.none, Corner maximum = Corner.full}) {
    return _CornerLerp(
      a.clamp(minimum: minimum, maximum: maximum),
      b.clamp(minimum: minimum, maximum: maximum),
      t,
    );
  }

  @override
  Corner clampValues({
    double? minimumX = 0.0,
    double? minimumY = 0.0,
    double? maximumX,
    double? maximumY,
  }) {
    return _CornerLerp(
      a.clampValues(
        minimumX: minimumX,
        minimumY: minimumY,
        maximumX: maximumX,
        maximumY: maximumY,
      ),
      b.clampValues(
        minimumX: minimumX,
        minimumY: minimumY,
        maximumX: maximumX,
        maximumY: maximumY,
      ),
      t,
    );
  }

  @override
  Radius toRadius({
    required Rect rect,
    required double? adjacentX,
    required double? adjacentY,
  }) {
    final aRadius = a.toRadius(
      rect: rect,
      adjacentX: adjacentX,
      adjacentY: adjacentY,
    );
    final bRadius = b.toRadius(
      rect: rect,
      adjacentX: adjacentX,
      adjacentY: adjacentY,
    );
    return Radius.lerp(aRadius, bRadius, t)!;
  }

  @override
  Corner operator -() => _CornerLerp(-a, -b, t);

  @override
  Corner operator -(Corner other) => _CornerLerp(a - other, b - other, t);

  @override
  Corner operator +(Corner other) => _CornerLerp(a + other, b + other, t);

  @override
  Corner operator *(double operand) => _CornerLerp(a * operand, b * operand, t);

  @override
  Corner operator /(double operand) => _CornerLerp(a / operand, b / operand, t);

  @override
  Corner operator ~/(double operand) =>
      _CornerLerp(a ~/ operand, b ~/ operand, t);

  @override
  Corner operator %(double operand) => _CornerLerp(a % operand, b % operand, t);

  @override
  String toString() {
    return "${objectRuntimeType(this, "Corner.lerp")}"
        "($a, $b, ${t.toStringAsFixed(1)})";
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is _CornerLerp &&
            a == other.a &&
            b == other.b &&
            t == other.t;
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b, t);
}

@immutable
abstract class CornersGeometry {
  const CornersGeometry();

  const factory CornersGeometry.all(Corner corner) = Corners.all;

  const factory CornersGeometry.only({
    Corner topLeft,
    Corner topRight,
    Corner bottomLeft,
    Corner bottomRight,
  }) = Corners.only;

  const factory CornersGeometry.directional({
    Corner topStart,
    Corner topEnd,
    Corner bottomStart,
    Corner bottomEnd,
  }) = CornersDirectional.only;

  const factory CornersGeometry.vertical({Corner top, Corner bottom}) =
      Corners.vertical;

  const factory CornersGeometry.fromBorderRadius(
    BorderRadiusGeometry borderRadius,
  ) = _CornersGeometryFromBorderRadiusGeometry;

  Corner get _topLeft;
  Corner get _topRight;
  Corner get _bottomLeft;
  Corner get _bottomRight;
  Corner get _topStart;
  Corner get _topEnd;
  Corner get _bottomStart;
  Corner get _bottomEnd;

  BorderRadiusGeometry toBorderRadius(Rect rect);

  Corners resolve(TextDirection? textDirection);

  CornersGeometry add(CornersGeometry other) {
    return _CornersMixed(
      _topLeft + other._topLeft,
      _topRight + other._topRight,
      _bottomLeft + other._bottomLeft,
      _bottomRight + other._bottomRight,
      _topStart + other._topStart,
      _topEnd + other._topEnd,
      _bottomStart + other._bottomStart,
      _bottomEnd + other._bottomEnd,
    );
  }

  CornersGeometry subtract(CornersGeometry other) {
    return _CornersMixed(
      _topLeft - other._topLeft,
      _topRight - other._topRight,
      _bottomLeft - other._bottomLeft,
      _bottomRight - other._bottomRight,
      _topStart - other._topStart,
      _topEnd - other._topEnd,
      _bottomStart - other._bottomStart,
      _bottomEnd - other._bottomEnd,
    );
  }

  CornersGeometry operator -();
  CornersGeometry operator *(double other);
  CornersGeometry operator /(double other);
  CornersGeometry operator ~/(double other);
  CornersGeometry operator %(double other);

  @override
  String toString() {
    String? visual, logical;
    if (_topLeft == _topRight &&
        _topRight == _bottomLeft &&
        _bottomLeft == _bottomRight) {
      if (_topLeft != Corner.none) {
        if (_topLeft.x == _topLeft.y) {
          visual =
              "Corners.circular(${_topLeft.x?.toStringAsFixed(1) ?? "full"})";
        } else {
          visual = "Corners.all($_topLeft)";
        }
      }
    } else {
      // visuals aren't the same and at least one isn't none
      final StringBuffer result = StringBuffer();
      result.write("Corners.only(");
      bool comma = false;
      if (_topLeft != Corner.none) {
        result.write("topLeft: $_topLeft");
        comma = true;
      }
      if (_topRight != Corner.none) {
        if (comma) {
          result.write(", ");
        }
        result.write("topRight: $_topRight");
        comma = true;
      }
      if (_bottomLeft != Corner.none) {
        if (comma) {
          result.write(", ");
        }
        result.write("bottomLeft: $_bottomLeft");
        comma = true;
      }
      if (_bottomRight != Corner.none) {
        if (comma) {
          result.write(", ");
        }
        result.write("bottomRight: $_bottomRight");
      }
      result.write(")");
      visual = result.toString();
    }
    if (_topStart == _topEnd &&
        _topEnd == _bottomEnd &&
        _bottomEnd == _bottomStart) {
      if (_topStart != Corner.none) {
        if (_topStart.x == _topStart.y) {
          logical =
              "CornersDirectional.circular(${_topStart.x?.toStringAsFixed(1) ?? "full"})";
        } else {
          logical = "CornersDirectional.all($_topStart)";
        }
      }
    } else {
      // logicals aren't the same and at least one isn't none
      final StringBuffer result = StringBuffer();
      result.write("CornersDirectional.only(");
      bool comma = false;
      if (_topStart != Corner.none) {
        result.write("topStart: $_topStart");
        comma = true;
      }
      if (_topEnd != Corner.none) {
        if (comma) {
          result.write(", ");
        }
        result.write("topEnd: $_topEnd");
        comma = true;
      }
      if (_bottomStart != Corner.none) {
        if (comma) {
          result.write(", ");
        }
        result.write("bottomStart: $_bottomStart");
        comma = true;
      }
      if (_bottomEnd != Corner.none) {
        if (comma) {
          result.write(", ");
        }
        result.write("bottomEnd: $_bottomEnd");
      }
      result.write(")");
      logical = result.toString();
    }
    if (visual != null && logical != null) {
      return "$visual + $logical";
    }
    return visual ?? logical ?? "Corners.none";
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is CornersGeometry &&
            _topLeft == other._topLeft &&
            _topRight == other._topRight &&
            _bottomLeft == other._bottomLeft &&
            _bottomRight == other._bottomRight &&
            _topStart == other._topStart &&
            _topEnd == other._topEnd &&
            _bottomStart == other._bottomStart &&
            _bottomEnd == other._bottomEnd;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    _topLeft,
    _topRight,
    _bottomLeft,
    _bottomRight,
    _topStart,
    _topEnd,
    _bottomStart,
    _bottomEnd,
  );

  static const CornersGeometry none = Corners.none;

  static CornersGeometry? lerp(
    CornersGeometry? a,
    CornersGeometry? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    a ??= Corners.none;
    b ??= Corners.none;

    return _CornersGeometryLerp(a, b, t);
  }
}

@immutable
class _CornersGeometryLerp extends CornersGeometry {
  const _CornersGeometryLerp(this.a, this.b, this.t);

  final CornersGeometry a;
  final CornersGeometry b;
  final double t;

  @override
  Corner get _topLeft => Corner.none;

  @override
  Corner get _topRight => Corner.none;

  @override
  Corner get _bottomLeft => Corner.none;

  @override
  Corner get _bottomRight => Corner.none;

  @override
  Corner get _topStart => Corner.none;

  @override
  Corner get _topEnd => Corner.none;

  @override
  Corner get _bottomStart => Corner.none;

  @override
  Corner get _bottomEnd => Corner.none;

  @override
  BorderRadiusGeometry toBorderRadius(Rect rect) {
    return BorderRadiusGeometry.lerp(
      a.toBorderRadius(rect),
      b.toBorderRadius(rect),
      t,
    )!;
  }

  @override
  Corners resolve(TextDirection? textDirection) {
    return _CornersLerp(a.resolve(textDirection), b.resolve(textDirection), t);
  }

  @override
  CornersGeometry operator -() {
    return _CornersGeometryLerp(-a, -b, t);
  }

  @override
  CornersGeometry operator *(double other) {
    return _CornersGeometryLerp(a * other, b * other, t);
  }

  @override
  CornersGeometry operator /(double other) {
    return _CornersGeometryLerp(a / other, b / other, t);
  }

  @override
  CornersGeometry operator ~/(double other) {
    return _CornersGeometryLerp(a ~/ other, b ~/ other, t);
  }

  @override
  CornersGeometry operator %(double other) {
    return _CornersGeometryLerp(a % other, b % other, t);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is _CornersGeometryLerp &&
            a == other.a &&
            b == other.b &&
            t == other.t;
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b, t);
}

@immutable
class Corners extends CornersGeometry {
  const Corners.all(Corner corner)
    : this.only(
        topLeft: corner,
        topRight: corner,
        bottomLeft: corner,
        bottomRight: corner,
      );

  Corners.circular(double radius) : this.all(Corner.circular(radius));

  const Corners.vertical({
    Corner top = Corner.none,
    Corner bottom = Corner.none,
  }) : this.only(
         topLeft: top,
         topRight: top,
         bottomLeft: bottom,
         bottomRight: bottom,
       );

  /// sides of the rectangle have the same radii.
  const Corners.horizontal({
    Corner left = Corner.none,
    Corner right = Corner.none,
  }) : this.only(
         topLeft: left,
         topRight: right,
         bottomLeft: left,
         bottomRight: right,
       );

  /// Creates corners with only the given non-none values. The other
  /// corners will be right angles.
  const Corners.only({
    this.topLeft = Corner.none,
    this.topRight = Corner.none,
    this.bottomLeft = Corner.none,
    this.bottomRight = Corner.none,
  });

  Corners.fromBorderRadius(BorderRadius borderRadius)
    : topLeft = Corner.fromRadius(borderRadius.topLeft),
      topRight = Corner.fromRadius(borderRadius.topRight),
      bottomLeft = Corner.fromRadius(borderRadius.bottomLeft),
      bottomRight = Corner.fromRadius(borderRadius.bottomRight);

  /// Returns a copy of this object with the given fields replaced with
  /// the new values.
  Corners copyWith({
    Corner? topLeft,
    Corner? topRight,
    Corner? bottomLeft,
    Corner? bottomRight,
  }) {
    return Corners.only(
      topLeft: topLeft ?? this.topLeft,
      topRight: topRight ?? this.topRight,
      bottomLeft: bottomLeft ?? this.bottomLeft,
      bottomRight: bottomRight ?? this.bottomRight,
    );
  }

  final Corner topLeft;
  final Corner topRight;
  final Corner bottomLeft;
  final Corner bottomRight;

  @override
  Corner get _topLeft => topLeft;

  @override
  Corner get _topRight => topRight;

  @override
  Corner get _bottomLeft => bottomLeft;

  @override
  Corner get _bottomRight => bottomRight;

  @override
  Corner get _topStart => Corner.none;

  @override
  Corner get _topEnd => Corner.none;

  @override
  Corner get _bottomStart => Corner.none;

  @override
  Corner get _bottomEnd => Corner.none;

  // @override
  // BorderRadius toBorderRadius(Rect rect) {
  //   final topLeft = this.topLeft.clamp();
  //   final topRight = this.topRight.clamp();
  //   final bottomLeft = this.bottomLeft.clamp();
  //   final bottomRight = this.bottomRight.clamp();

  //   final Rect(:width, :height, :shortestSide) = rect;

  //   double topLeftX;
  //   double topLeftY;
  //   double topRightX;
  //   double topRightY;
  //   double bottomLeftX;
  //   double bottomLeftY;
  //   double bottomRightX;
  //   double bottomRightY;

  //   if (topLeft.x == null) {
  //     if (topRight.x == null) {
  //       topLeftX = shortestSide / 2;
  //       topRightX = shortestSide / 2;
  //     } else {
  //       topRightX = topRight.x!;
  //       topLeftX = ui.clampDouble(width - topRightX, 0.0, shortestSide);
  //     }
  //   } else {
  //     topLeftX = topLeft.x!;
  //     topRightX =
  //         topRight.x ?? ui.clampDouble(width - topLeftX, 0.0, shortestSide);
  //   }

  //   if (topRight.y == null) {
  //     if (bottomRight.y == null) {
  //       topRightY = shortestSide / 2;
  //       bottomRightY = shortestSide / 2;
  //     } else {
  //       bottomRightY = bottomRight.y!;
  //       topRightY = ui.clampDouble(height - bottomRightY, 0.0, shortestSide);
  //     }
  //   } else {
  //     topRightY = topRight.y!;
  //     bottomRightY =
  //         bottomRight.y ??
  //         ui.clampDouble(height - topRightY, 0.0, shortestSide);
  //   }

  //   if (bottomRight.x == null) {
  //     if (bottomLeft.x == null) {
  //       bottomRightX = shortestSide / 2;
  //       bottomLeftX = shortestSide / 2;
  //     } else {
  //       bottomLeftX = bottomLeft.x!;
  //       bottomRightX = ui.clampDouble(width - bottomLeftX, 0.0, shortestSide);
  //     }
  //   } else {
  //     bottomRightX = bottomRight.x!;
  //     bottomLeftX =
  //         bottomLeft.x ??
  //         ui.clampDouble(width - bottomRightX, 0.0, shortestSide);
  //   }

  //   if (bottomLeft.y == null) {
  //     if (topLeft.y == null) {
  //       bottomLeftY = shortestSide / 2;
  //       topLeftY = shortestSide / 2;
  //     } else {
  //       topLeftY = topLeft.y!;
  //       bottomLeftY = ui.clampDouble(height - topLeftY, 0.0, shortestSide);
  //     }
  //   } else {
  //     bottomLeftY = bottomLeft.y!;
  //     topLeftY =
  //         topLeft.y ?? ui.clampDouble(height - bottomLeftY, 0.0, shortestSide);
  //   }
  //   if (topLeft.x == null && topLeft.y == null) {
  //     final min = math.min(topLeftX, topLeftY);
  //     topLeftX = min;
  //     topLeftY = min;
  //   }
  //   if (topRight.x == null && topRight.y == null) {
  //     final min = math.min(topRightX, topRightY);
  //     topRightX = min;
  //     topRightY = min;
  //   }
  //   if (bottomLeft.x == null && bottomLeft.y == null) {
  //     final min = math.min(bottomLeftX, bottomLeftY);
  //     bottomLeftX = min;
  //     bottomLeftY = min;
  //   }
  //   if (bottomRight.x == null && bottomRight.y == null) {
  //     final min = math.min(bottomRightX, bottomRightY);
  //     bottomRightX = min;
  //     bottomRightY = min;
  //   }

  //   return BorderRadius.only(
  //     topLeft: Radius.elliptical(topLeftX, topLeftY),
  //     topRight: Radius.elliptical(topRightX, topRightY),
  //     bottomLeft: Radius.elliptical(bottomLeftX, bottomLeftY),
  //     bottomRight: Radius.elliptical(bottomRightX, bottomRightY),
  //   );
  // }

  @override
  BorderRadius toBorderRadius(Rect rect) {
    final topLeft = this.topLeft.clamp();
    final topRight = this.topRight.clamp();
    final bottomLeft = this.bottomLeft.clamp();
    final bottomRight = this.bottomRight.clamp();

    return BorderRadius.only(
      topLeft: topLeft.toRadius(
        rect: rect,
        adjacentX: topRight.x,
        adjacentY: bottomLeft.y,
      ),
      topRight: topRight.toRadius(
        rect: rect,
        adjacentX: topLeft.x,
        adjacentY: bottomRight.y,
      ),
      bottomLeft: bottomLeft.toRadius(
        rect: rect,
        adjacentX: bottomRight.x,
        adjacentY: topLeft.y,
      ),
      bottomRight: bottomRight.toRadius(
        rect: rect,
        adjacentX: bottomLeft.x,
        adjacentY: topRight.y,
      ),
    );
  }

  RRect toRRect(Rect rect) {
    return toBorderRadius(rect).toRRect(rect);
  }

  RSuperellipse toRSuperellipse(Rect rect) {
    return toBorderRadius(rect).toRSuperellipse(rect);
  }

  @override
  Corners resolve(TextDirection? direction) => this;

  @override
  CornersGeometry add(CornersGeometry other) {
    if (other is Corners) {
      return this + other;
    }
    return super.add(other);
  }

  @override
  CornersGeometry subtract(CornersGeometry other) {
    if (other is Corners) {
      return this - other;
    }
    return super.subtract(other);
  }

  Corners operator +(Corners other) {
    return Corners.only(
      topLeft: topLeft + other.topLeft,
      topRight: topRight + other.topRight,
      bottomLeft: bottomLeft + other.bottomLeft,
      bottomRight: bottomRight + other.bottomRight,
    );
  }

  Corners operator -(Corners other) {
    return Corners.only(
      topLeft: topLeft - other.topLeft,
      topRight: topRight - other.topRight,
      bottomLeft: bottomLeft - other.bottomLeft,
      bottomRight: bottomRight - other.bottomRight,
    );
  }

  @override
  Corners operator -() {
    return Corners.only(
      topLeft: -topLeft,
      topRight: -topRight,
      bottomLeft: -bottomLeft,
      bottomRight: -bottomRight,
    );
  }

  @override
  Corners operator *(double other) {
    return Corners.only(
      topLeft: topLeft * other,
      topRight: topRight * other,
      bottomLeft: bottomLeft * other,
      bottomRight: bottomRight * other,
    );
  }

  @override
  Corners operator /(double other) {
    return Corners.only(
      topLeft: topLeft / other,
      topRight: topRight / other,
      bottomLeft: bottomLeft / other,
      bottomRight: bottomRight / other,
    );
  }

  @override
  Corners operator ~/(double other) {
    return Corners.only(
      topLeft: topLeft ~/ other,
      topRight: topRight ~/ other,
      bottomLeft: bottomLeft ~/ other,
      bottomRight: bottomRight ~/ other,
    );
  }

  @override
  Corners operator %(double other) {
    return Corners.only(
      topLeft: topLeft % other,
      topRight: topRight % other,
      bottomLeft: bottomLeft % other,
      bottomRight: bottomRight % other,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is Corners &&
            topLeft == other.topLeft &&
            topRight == other.topRight &&
            bottomLeft == other.bottomLeft &&
            bottomRight == other.bottomRight;
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, topLeft, topRight, bottomLeft, bottomRight);

  static const Corners none = Corners.all(Corner.none);
  static const Corners full = Corners.all(Corner.full);

  static Corners? lerp(Corners? a, Corners? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    if (a == null) {
      return b! * t;
    }
    if (b == null) {
      return a * (1.0 - t);
    }
    return _CornersLerp(a, b, t);
  }
}

@immutable
class _CornersGeometryFromBorderRadiusGeometry extends CornersGeometry {
  const _CornersGeometryFromBorderRadiusGeometry(this._borderRadius);

  final BorderRadiusGeometry _borderRadius;

  @override
  Corner get _topLeft => Corner.none;

  @override
  Corner get _topRight => Corner.none;

  @override
  Corner get _bottomLeft => Corner.none;

  @override
  Corner get _bottomRight => Corner.none;

  @override
  Corner get _topStart => Corner.none;

  @override
  Corner get _topEnd => Corner.none;

  @override
  Corner get _bottomStart => Corner.none;

  @override
  Corner get _bottomEnd => Corner.none;

  @override
  BorderRadiusGeometry toBorderRadius(Rect rect) {
    return _borderRadius;
  }

  @override
  Corners resolve(TextDirection? textDirection) {
    final resolvedBorderRadius = _borderRadius.resolve(textDirection);
    return Corners.fromBorderRadius(resolvedBorderRadius);
  }

  @override
  CornersGeometry add(CornersGeometry other) {
    if (other is _CornersGeometryFromBorderRadiusGeometry) {
      return _CornersGeometryFromBorderRadiusGeometry(
        _borderRadius.add(other._borderRadius),
      );
    }
    return super.add(other);
  }

  @override
  CornersGeometry subtract(CornersGeometry other) {
    if (other is _CornersGeometryFromBorderRadiusGeometry) {
      return _CornersGeometryFromBorderRadiusGeometry(
        _borderRadius.subtract(other._borderRadius),
      );
    }
    return super.subtract(other);
  }

  @override
  CornersGeometry operator -() {
    return _CornersGeometryFromBorderRadiusGeometry(-_borderRadius);
  }

  @override
  CornersGeometry operator *(double other) {
    return _CornersGeometryFromBorderRadiusGeometry(_borderRadius * other);
  }

  @override
  CornersGeometry operator /(double other) {
    return _CornersGeometryFromBorderRadiusGeometry(_borderRadius / other);
  }

  @override
  CornersGeometry operator ~/(double other) {
    return _CornersGeometryFromBorderRadiusGeometry(_borderRadius ~/ other);
  }

  @override
  CornersGeometry operator %(double other) {
    return _CornersGeometryFromBorderRadiusGeometry(_borderRadius % other);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is _CornersGeometryFromBorderRadiusGeometry &&
            _borderRadius == other._borderRadius;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _borderRadius);
}

@immutable
class _CornersLerp extends Corners {
  const _CornersLerp(this.a, this.b, this.t) : super.only();

  final Corners a;
  final Corners b;
  final double t;

  @override
  BorderRadius toBorderRadius(Rect rect) {
    return BorderRadius.lerp(
      a.toBorderRadius(rect),
      b.toBorderRadius(rect),
      t,
    )!;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is _CornersLerp &&
            a == other.a &&
            b == other.b &&
            t == other.t;
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b, t);
}

@immutable
class CornersDirectional extends CornersGeometry {
  const CornersDirectional.all(Corner radius)
    : this.only(
        topStart: radius,
        topEnd: radius,
        bottomStart: radius,
        bottomEnd: radius,
      );

  const CornersDirectional.vertical({
    Corner top = Corner.none,
    Corner bottom = Corner.none,
  }) : this.only(
         topStart: top,
         topEnd: top,
         bottomStart: bottom,
         bottomEnd: bottom,
       );

  const CornersDirectional.horizontal({
    Corner start = Corner.none,
    Corner end = Corner.none,
  }) : this.only(
         topStart: start,
         topEnd: end,
         bottomStart: start,
         bottomEnd: end,
       );

  const CornersDirectional.only({
    this.topStart = Corner.none,
    this.topEnd = Corner.none,
    this.bottomStart = Corner.none,
    this.bottomEnd = Corner.none,
  });

  CornersDirectional.fromBorderRadius(BorderRadiusDirectional borderRadius)
    : topStart = Corner.fromRadius(borderRadius.topStart),
      topEnd = Corner.fromRadius(borderRadius.topEnd),
      bottomStart = Corner.fromRadius(borderRadius.bottomStart),
      bottomEnd = Corner.fromRadius(borderRadius.bottomEnd);

  final Corner topStart;
  final Corner topEnd;
  final Corner bottomStart;
  final Corner bottomEnd;

  @override
  Corner get _topLeft => Corner.none;

  @override
  Corner get _topRight => Corner.none;

  @override
  Corner get _bottomLeft => Corner.none;

  @override
  Corner get _bottomRight => Corner.none;

  @override
  Corner get _topStart => topStart;

  @override
  Corner get _topEnd => topEnd;

  @override
  Corner get _bottomStart => bottomStart;

  @override
  Corner get _bottomEnd => bottomEnd;

  // @override
  // BorderRadiusDirectional toBorderRadius(Rect rect) {
  //   final topStart = this.topStart.clamp();
  //   final topEnd = this.topEnd.clamp();
  //   final bottomStart = this.bottomStart.clamp();
  //   final bottomEnd = this.bottomEnd.clamp();

  //   final Rect(:width, :height, :shortestSide) = rect;

  //   double topStartX;
  //   double topStartY;
  //   double topEndX;
  //   double topEndY;
  //   double bottomStartX;
  //   double bottomStartY;
  //   double bottomEndX;
  //   double bottomEndY;

  //   if (topStart.x == null) {
  //     if (topEnd.x == null) {
  //       topStartX = shortestSide / 2;
  //       topEndX = shortestSide / 2;
  //     } else {
  //       topEndX = topEnd.x!;
  //       topStartX = ui.clampDouble(width - topEndX, 0.0, shortestSide);
  //     }
  //   } else {
  //     topStartX = topStart.x!;
  //     topEndX =
  //         topEnd.x ?? ui.clampDouble(width - topStartX, 0.0, shortestSide);
  //   }

  //   if (topEnd.y == null) {
  //     if (bottomEnd.y == null) {
  //       topEndY = shortestSide / 2;
  //       bottomEndY = shortestSide / 2;
  //     } else {
  //       bottomEndY = bottomEnd.y!;
  //       topEndY = ui.clampDouble(height - bottomEndY, 0.0, shortestSide);
  //     }
  //   } else {
  //     topEndY = topEnd.y!;
  //     bottomEndY =
  //         bottomEnd.y ?? ui.clampDouble(height - topEndY, 0.0, shortestSide);
  //   }

  //   if (bottomEnd.x == null) {
  //     if (bottomStart.x == null) {
  //       bottomEndX = shortestSide / 2;
  //       bottomStartX = shortestSide / 2;
  //     } else {
  //       bottomStartX = bottomStart.x!;
  //       bottomEndX = ui.clampDouble(width - bottomStartX, 0.0, shortestSide);
  //     }
  //   } else {
  //     bottomEndX = bottomEnd.x!;
  //     bottomStartX =
  //         bottomStart.x ??
  //         ui.clampDouble(width - bottomEndX, 0.0, shortestSide);
  //   }

  //   if (bottomStart.y == null) {
  //     if (topStart.y == null) {
  //       bottomStartY = shortestSide / 2;
  //       topStartY = shortestSide / 2;
  //     } else {
  //       topStartY = topStart.y!;
  //       bottomStartY = ui.clampDouble(height - topStartY, 0.0, shortestSide);
  //     }
  //   } else {
  //     bottomStartY = bottomStart.y!;
  //     topStartY =
  //         topStart.y ??
  //         ui.clampDouble(height - bottomStartY, 0.0, shortestSide);
  //   }
  //   if (topStart.x == null && topStart.y == null) {
  //     final min = math.min(topStartX, topStartY);
  //     topStartX = min;
  //     topStartY = min;
  //   }
  //   if (topEnd.x == null && topEnd.y == null) {
  //     final min = math.min(topEndX, topEndY);
  //     topEndX = min;
  //     topEndY = min;
  //   }
  //   if (bottomStart.x == null && bottomStart.y == null) {
  //     final min = math.min(bottomStartX, bottomStartY);
  //     bottomStartX = min;
  //     bottomStartY = min;
  //   }
  //   if (bottomEnd.x == null && bottomEnd.y == null) {
  //     final min = math.min(bottomEndX, bottomEndY);
  //     bottomEndX = min;
  //     bottomEndY = min;
  //   }

  //   return BorderRadiusDirectional.only(
  //     topStart: Radius.elliptical(topStartX, topStartY),
  //     topEnd: Radius.elliptical(topEndX, topEndY),
  //     bottomStart: Radius.elliptical(bottomStartX, bottomStartY),
  //     bottomEnd: Radius.elliptical(bottomEndX, bottomEndY),
  //   );
  // }

  // @override
  // Corners resolve(TextDirection? textDirection) {
  //   assert(textDirection != null);
  //   return switch (textDirection!) {
  //     TextDirection.ltr => Corners.only(
  //       topLeft: topStart,
  //       topRight: topEnd,
  //       bottomLeft: bottomStart,
  //       bottomRight: bottomEnd,
  //     ),
  //     TextDirection.rtl => Corners.only(
  //       topLeft: topEnd,
  //       topRight: topStart,
  //       bottomLeft: bottomEnd,
  //       bottomRight: bottomStart,
  //     ),
  //   };
  // }

  @override
  BorderRadiusDirectional toBorderRadius(Rect rect) {
    final topStart = this.topStart.clamp();
    final topEnd = this.topEnd.clamp();
    final bottomStart = this.bottomStart.clamp();
    final bottomEnd = this.bottomEnd.clamp();

    return BorderRadiusDirectional.only(
      topStart: topStart.toRadius(
        rect: rect,
        adjacentX: topEnd.x,
        adjacentY: bottomStart.y,
      ),
      topEnd: topEnd.toRadius(
        rect: rect,
        adjacentX: topStart.x,
        adjacentY: bottomEnd.y,
      ),
      bottomStart: bottomStart.toRadius(
        rect: rect,
        adjacentX: bottomEnd.x,
        adjacentY: topStart.y,
      ),
      bottomEnd: bottomEnd.toRadius(
        rect: rect,
        adjacentX: bottomStart.x,
        adjacentY: topEnd.y,
      ),
    );
  }

  @override
  Corners resolve(TextDirection? textDirection) {
    assert(textDirection != null);
    return switch (textDirection!) {
      TextDirection.ltr => Corners.only(
        topLeft: topStart,
        topRight: topEnd,
        bottomLeft: bottomStart,
        bottomRight: bottomEnd,
      ),
      TextDirection.rtl => Corners.only(
        topLeft: topEnd,
        topRight: topStart,
        bottomLeft: bottomEnd,
        bottomRight: bottomStart,
      ),
    };
  }

  @override
  CornersGeometry add(CornersGeometry other) {
    if (other is CornersDirectional) {
      return this + other;
    }
    return super.add(other);
  }

  @override
  CornersGeometry subtract(CornersGeometry other) {
    if (other is CornersDirectional) {
      return this - other;
    }
    return super.subtract(other);
  }

  CornersDirectional operator +(CornersDirectional other) {
    return CornersDirectional.only(
      topStart: topStart + other.topStart,
      topEnd: topEnd + other.topEnd,
      bottomStart: bottomStart + other.bottomStart,
      bottomEnd: bottomEnd + other.bottomEnd,
    );
  }

  CornersDirectional operator -(CornersDirectional other) {
    return CornersDirectional.only(
      topStart: topStart - other.topStart,
      topEnd: topEnd - other.topEnd,
      bottomStart: bottomStart - other.bottomStart,
      bottomEnd: bottomEnd - other.bottomEnd,
    );
  }

  @override
  CornersDirectional operator -() {
    return CornersDirectional.only(
      topStart: -topStart,
      topEnd: -topEnd,
      bottomStart: -bottomStart,
      bottomEnd: -bottomEnd,
    );
  }

  @override
  CornersDirectional operator *(double other) {
    return CornersDirectional.only(
      topStart: topStart * other,
      topEnd: topEnd * other,
      bottomStart: bottomStart * other,
      bottomEnd: bottomEnd * other,
    );
  }

  @override
  CornersDirectional operator /(double other) {
    return CornersDirectional.only(
      topStart: topStart / other,
      topEnd: topEnd / other,
      bottomStart: bottomStart / other,
      bottomEnd: bottomEnd / other,
    );
  }

  @override
  CornersDirectional operator ~/(double other) {
    return CornersDirectional.only(
      topStart: topStart ~/ other,
      topEnd: topEnd ~/ other,
      bottomStart: bottomStart ~/ other,
      bottomEnd: bottomEnd ~/ other,
    );
  }

  @override
  CornersDirectional operator %(double other) {
    return CornersDirectional.only(
      topStart: topStart % other,
      topEnd: topEnd % other,
      bottomStart: bottomStart % other,
      bottomEnd: bottomEnd % other,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is CornersDirectional &&
            topStart == other.topStart &&
            topEnd == other.topEnd &&
            bottomStart == other.bottomStart &&
            bottomEnd == other.bottomEnd;
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, topStart, topEnd, bottomStart, bottomEnd);

  static const CornersDirectional none = CornersDirectional.all(Corner.none);
  static const CornersDirectional full = CornersDirectional.all(Corner.full);

  static CornersDirectional? lerp(
    CornersDirectional? a,
    CornersDirectional? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    if (a == null) {
      return b! * t;
    }
    if (b == null) {
      return a * (1.0 - t);
    }
    return _CornersDirectionalLerp(a, b, t);
  }
}

@immutable
class _CornersDirectionalLerp extends CornersDirectional {
  const _CornersDirectionalLerp(this.a, this.b, this.t) : super.only();

  final CornersDirectional a;
  final CornersDirectional b;
  final double t;

  @override
  Corners resolve(TextDirection? textDirection) {
    return _CornersLerp(a.resolve(textDirection), b.resolve(textDirection), t);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is _CornersDirectionalLerp &&
            a == other.a &&
            b == other.b &&
            t == other.t;
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b, t);
}

@immutable
class _CornersMixed extends CornersGeometry {
  const _CornersMixed(
    this._topLeft,
    this._topRight,
    this._bottomLeft,
    this._bottomRight,
    this._topStart,
    this._topEnd,
    this._bottomStart,
    this._bottomEnd,
  );

  @override
  final Corner _topLeft;

  @override
  final Corner _topRight;

  @override
  final Corner _bottomLeft;

  @override
  final Corner _bottomRight;

  @override
  final Corner _topStart;

  @override
  final Corner _topEnd;

  @override
  final Corner _bottomStart;

  @override
  final Corner _bottomEnd;

  @override
  BorderRadiusGeometry toBorderRadius(Rect rect) {
    final cornersNonDirectional = Corners.only(
      topLeft: _topLeft,
      topRight: _topRight,
      bottomLeft: _bottomLeft,
      bottomRight: _bottomRight,
    );
    final cornersDirectional = CornersDirectional.only(
      topStart: _topStart,
      topEnd: _topEnd,
      bottomStart: _bottomStart,
      bottomEnd: _bottomEnd,
    );
    final borderRadiusNonDirectional = cornersNonDirectional.toBorderRadius(
      rect,
    );
    final borderRadiusDirectional = cornersDirectional.toBorderRadius(rect);
    return borderRadiusNonDirectional.add(borderRadiusDirectional);
  }

  @override
  Corners resolve(TextDirection? textDirection) {
    assert(textDirection != null);
    return switch (textDirection!) {
      TextDirection.ltr => Corners.only(
        topLeft: _topLeft + _topStart,
        topRight: _topRight + _topEnd,
        bottomLeft: _bottomLeft + _bottomStart,
        bottomRight: _bottomRight + _bottomEnd,
      ),
      TextDirection.rtl => Corners.only(
        topLeft: _topLeft + _topEnd,
        topRight: _topRight + _topStart,
        bottomLeft: _bottomLeft + _bottomEnd,
        bottomRight: _bottomRight + _bottomStart,
      ),
    };
  }

  @override
  _CornersMixed operator -() => _CornersMixed(
    -_topLeft,
    -_topRight,
    -_bottomLeft,
    -_bottomRight,
    -_topStart,
    -_topEnd,
    -_bottomStart,
    -_bottomEnd,
  );

  @override
  _CornersMixed operator *(double other) => _CornersMixed(
    _topLeft * other,
    _topRight * other,
    _bottomLeft * other,
    _bottomRight * other,
    _topStart * other,
    _topEnd * other,
    _bottomStart * other,
    _bottomEnd * other,
  );

  @override
  _CornersMixed operator /(double other) => _CornersMixed(
    _topLeft / other,
    _topRight / other,
    _bottomLeft / other,
    _bottomRight / other,
    _topStart / other,
    _topEnd / other,
    _bottomStart / other,
    _bottomEnd / other,
  );

  @override
  _CornersMixed operator ~/(double other) => _CornersMixed(
    _topLeft ~/ other,
    _topRight ~/ other,
    _bottomLeft ~/ other,
    _bottomRight ~/ other,
    _topStart ~/ other,
    _topEnd ~/ other,
    _bottomStart ~/ other,
    _bottomEnd ~/ other,
  );

  @override
  _CornersMixed operator %(double other) => _CornersMixed(
    _topLeft % other,
    _topRight % other,
    _bottomLeft % other,
    _bottomRight % other,
    _topStart % other,
    _topEnd % other,
    _bottomStart % other,
    _bottomEnd % other,
  );
}
