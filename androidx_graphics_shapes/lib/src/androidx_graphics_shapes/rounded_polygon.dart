part of '../androidx_graphics_shapes.dart';

final class RoundedPolygon {
  @internal
  RoundedPolygon(this.features, this.center)
    : cubics = _buildCubics(features, center) {
    var prevCubic = cubics[cubics.length - 1];
    // debugLog("RoundedPolygon") { "Cubic-1 = $prevCubic" }
    for (int index = 0; index < cubics.length; index++) {
      final cubic = cubics[index];
      // debugLog("RoundedPolygon") { "Cubic = $cubic" }
      if ((cubic.anchor0X - prevCubic.anchor1X).abs() > distanceEpsilon ||
          (cubic.anchor0Y - prevCubic.anchor1Y).abs() > distanceEpsilon) {
        // debugLog("RoundedPolygon") {
        //     "Ix: $index | (${cubic.anchor0X},${cubic.anchor0Y}) vs $prevCubic"
        // }
        throw ArgumentError(
          "RoundedPolygon must be contiguous, with the anchor points of all curves "
          "matching the anchor points of the preceding and succeeding cubics.",
        );
      }
      prevCubic = cubic;
    }
  }

  factory RoundedPolygon.fromPolygon(RoundedPolygon source) =>
      RoundedPolygon(source.features, source.center);

  factory RoundedPolygon.fromVertices({
    required List<double> vertices,
    CornerRounding rounding = CornerRounding.unrounded,
    List<CornerRounding>? perVertexRounding,
    double centerX = double.minPositive,
    double centerY = double.minPositive,
  }) {
    if (vertices.length < 6) {
      throw ArgumentError("Polygons must have at least 3 vertices.");
    }
    if (vertices.length % 2 == 1) {
      throw ArgumentError("The vertices array should have even size.");
    }
    if (perVertexRounding != null &&
        perVertexRounding.length * 2 != vertices.length) {
      throw ArgumentError(
        "perVertexRounding list should be either null or "
        "the same size as the number of vertices (vertices.size / 2)",
      );
    }

    final List<List<Cubic>> corners = <List<Cubic>>[];
    final n = vertices.length ~/ 2;
    final List<_RoundedCorner> roundedCorners = <_RoundedCorner>[];
    for (int i = 0; i < n; i++) {
      final vtxRounding = perVertexRounding?[i] ?? rounding;
      final prevIndex = ((i + n - 1) % n) * 2;
      final nextIndex = ((i + 1) % n) * 2;
      roundedCorners.add(
        _RoundedCorner(
          Point(vertices[prevIndex], vertices[prevIndex + 1]),
          Point(vertices[i * 2], vertices[i * 2 + 1]),
          Point(vertices[nextIndex], vertices[nextIndex + 1]),
          vtxRounding,
        ),
      );
    }

    // For each side, check if we have enough space to do the cuts needed, and if not split
    // the available space, first for round cuts, then for smoothing if there is space left.
    // Each element in this list is a pair, that represent how much we can do of the cut for
    // the given side (side i goes from corner i to corner i+1), the elements of the pair are:
    // first is how much we can use of expectedRoundCut, second how much of expectedCut
    final List<(double, double)> cutAdjusts = <(double, double)>[];
    for (int ix = 0; ix < n; ix++) {
      final expectedRoundCut =
          roundedCorners[ix].expectedRoundCut +
          roundedCorners[(ix + 1) % n].expectedRoundCut;
      final expectedCut =
          roundedCorners[ix].expectedCut +
          roundedCorners[(ix + 1) % n].expectedCut;
      final vtxX = vertices[ix * 2];
      final vtxY = vertices[ix * 2 + 1];
      final nextVtxX = vertices[((ix + 1) % n) * 2];
      final nextVtxY = vertices[((ix + 1) % n) * 2 + 1];
      final sideSize = distance(vtxX - nextVtxX, vtxY - nextVtxY);

      // Check expectedRoundCut first, and ensure we fulfill rounding needs first for
      // both corners before using space for smoothing
      if (expectedRoundCut > sideSize) {
        // Not enough room for fully rounding, see how much we can actually do.
        cutAdjusts.add((sideSize / expectedRoundCut, 0.0));
      } else if (expectedCut > sideSize) {
        // We can do full rounding, but not full smoothing.
        cutAdjusts.add((
          1.0,
          (sideSize - expectedRoundCut) / (expectedCut - expectedRoundCut),
        ));
      } else {
        // There is enough room for rounding & smoothing.
        cutAdjusts.add((1.0, 1.0));
      }
    }

    // Create and store list of beziers for each [potentially] rounded corner
    for (int i = 0; i < n; i++) {
      // allowedCuts[0] is for the side from the previous corner to this one,
      // allowedCuts[1] is for the side from this corner to the next one.
      final List<double> allowedCuts = List.filled(2, 0.0);
      for (int delta = 0; delta <= 1; delta++) {
        final (roundCutRatio, cutRatio) = cutAdjusts[(i + n - 1 + delta) % n];
        allowedCuts.add(
          roundedCorners[i].expectedRoundCut * roundCutRatio +
              (roundedCorners[i].expectedCut -
                      roundedCorners[i].expectedRoundCut) *
                  cutRatio,
        );
      }
      corners.add(roundedCorners[i].getCubics(allowedCuts[0], allowedCuts[1]));
    }

    // Finally, store the calculated cubics. This includes all of the rounded corners
    // from above, along with new cubics representing the edges between those corners.
    final List<Feature> tempFeatures = <Feature>[];
    for (int i = 0; i < n; i++) {
      // Note that these indices are for pairs of values (points), they need to be
      // doubled to access the xy values in the vertices float array
      final prevVtxIndex = (i + n - 1) % n;
      final nextVtxIndex = (i + 1) % n;
      final currVertex = Point(vertices[i * 2], vertices[i * 2 + 1]);
      final prevVertex = Point(
        vertices[prevVtxIndex * 2],
        vertices[prevVtxIndex * 2 + 1],
      );
      final nextVertex = Point(
        vertices[nextVtxIndex * 2],
        vertices[nextVtxIndex * 2 + 1],
      );
      tempFeatures.add(
        Corner(corners[i], convex(prevVertex, currVertex, nextVertex)),
      );
      tempFeatures.add(
        Edge([
          Cubic.straightLine(
            corners[i].last.anchor1X,
            corners[i].last.anchor1Y,
            corners[(i + 1) % n].first.anchor0X,
            corners[(i + 1) % n].first.anchor0Y,
          ),
        ]),
      );
    }

    final c = centerX == double.minPositive || centerY == double.minPositive
        ? calculateCenter(vertices)
        : Point(centerX, centerY);
    return RoundedPolygon(tempFeatures, c);
  }

  factory RoundedPolygon.fromFeatures({
    required List<Feature> features,
    double centerX = double.nan,
    double centerY = double.nan,
  }) {
    if (features.length < 2) {
      throw ArgumentError("Polygons must have at least 2 features.");
    }

    final vertices = [
      for (final feature in features)
        for (final cubic in feature.cubics) ...[cubic.anchor0X, cubic.anchor0Y],
    ];

    final cX = centerX.isNaN ? calculateCenter(vertices).x : centerX;
    final cY = centerY.isNaN ? calculateCenter(vertices).y : centerY;

    return RoundedPolygon(features, Point(cX, cY));
  }

  final List<Feature> features;

  @internal
  final Point center;

  double get centerX => center.x;
  double get centerY => center.y;

  final List<Cubic> cubics;

  RoundedPolygon transformed(PointTransformer f) => RoundedPolygon([
    for (int i = 0; i < features.length; i++) features[i].transformed(f),
  ], center.transformed(f));

  RoundedPolygon normalized() {
    final bounds = calculateBounds();
    final width = bounds.right - bounds.left;
    final height = bounds.bottom - bounds.top;
    final side = math.max(width, height);
    // Center the shape if bounds are not a square
    final offsetX = (side - width) / 2.0 - bounds.left;
    final offsetY = (side - height) / 2.0 - bounds.top;
    // return transformed { x, y -> TransformResult((x + offsetX) / side, (y + offsetY) / side) }
    return transformed((x, y) => ((x + offsetX) / side, (y + offsetY) / side));
  }

  Rect calculateMaxBounds() {
    double maxDistSquared = 0.0;
    for (int i = 0; i < cubics.length; i++) {
      final cubic = cubics[i];
      final anchorDistance = distanceSquared(
        cubic.anchor0X - centerX,
        cubic.anchor0Y - centerY,
      );
      final middlePoint = cubic.pointOnCurve(0.5);
      final middleDistance = distanceSquared(
        middlePoint.x - centerX,
        middlePoint.y - centerY,
      );
      maxDistSquared = math.max(
        maxDistSquared,
        math.max(anchorDistance, middleDistance),
      );
    }
    final distance = math.sqrt(maxDistSquared);
    return Rect.fromLTRB(
      centerX - distance,
      centerY - distance,
      centerX + distance,
      centerY + distance,
    );
  }

  Rect calculateBounds({bool approximate = true}) {
    var minX = double.maxFinite;
    var minY = double.maxFinite;
    var maxX = double.minPositive;
    var maxY = double.minPositive;
    for (int i = 0; i < cubics.length; i++) {
      final cubic = cubics[i];
      final bounds = cubic.calculateBounds(approximate: approximate);
      minX = math.min(minX, bounds.left);
      minY = math.min(minY, bounds.top);
      maxX = math.max(maxX, bounds.right);
      maxY = math.max(maxY, bounds.bottom);
    }
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  @override
  String toString() =>
      "RoundedPolygon("
      "cubics: $cubics, "
      "features: $features, "
      "center: ($centerX, $centerY)"
      ")";

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is RoundedPolygon &&
            listEquals(features, other.features);
  }

  @override
  int get hashCode => Object.hash(runtimeType, features);

  static List<Cubic> _buildCubics(List<Feature> features, Point center) {
    final List<Cubic> cubics = <Cubic>[];

    // The first/last mechanism here ensures that the final anchor point in the shape
    // exactly matches the first anchor point. There can be rendering artifacts introduced
    // by those points being slightly off, even by much less than a pixel
    Cubic? firstCubic;
    Cubic? lastCubic;
    List<Cubic>? firstFeatureSplitStart;
    List<Cubic>? firstFeatureSplitEnd;
    if (features.isNotEmpty && features[0].cubics.length == 3) {
      final centerCubic = features[0].cubics[1];
      final (start, end) = centerCubic.split(0.5);
      firstFeatureSplitStart = <Cubic>[features[0].cubics[0], start];
      firstFeatureSplitEnd = <Cubic>[end, features[0].cubics[2]];
    }
    // iterating one past the features list size allows us to insert the initial split
    // cubic if it exists
    for (int i = 0; i <= features.length; i++) {
      final List<Cubic> featureCubics;
      if (i == 0 && firstFeatureSplitEnd != null) {
        featureCubics = firstFeatureSplitEnd;
      } else if (i == features.length) {
        if (firstFeatureSplitStart != null) {
          featureCubics = firstFeatureSplitStart;
        } else {
          break;
        }
      } else {
        featureCubics = features[i].cubics;
      }

      for (int j = 0; j < featureCubics.length; j++) {
        // Skip zero-length curves; they add nothing and can trigger rendering artifacts
        final cubic = featureCubics[j];
        if (!cubic.zeroLength()) {
          if (lastCubic != null) cubics.add(lastCubic);
          lastCubic = cubic;
          firstCubic ??= cubic;
        } else {
          if (lastCubic != null) {
            // Dropping several zero-ish length curves in a row can lead to
            // enough discontinuity to throw an exception later, even though the
            // distances are quite small. Account for that by making the last
            // cubic use the latest anchor point, always.
            lastCubic = Cubic.from(
              lastCubic.anchor0X,
              lastCubic.anchor0Y,
              lastCubic.control0X,
              lastCubic.control0Y,
              lastCubic.control1X,
              lastCubic.control1Y,
              cubic.anchor1X,
              cubic.anchor1Y,
            );
          }
        }
      }
    }

    if (lastCubic != null && firstCubic != null) {
      cubics.add(
        Cubic.from(
          lastCubic.anchor0X,
          lastCubic.anchor0Y,
          lastCubic.control0X,
          lastCubic.control0Y,
          lastCubic.control1X,
          lastCubic.control1Y,
          firstCubic.anchor0X,
          firstCubic.anchor0Y,
        ),
      );
    } else {
      // Empty / 0-sized polygon.
      cubics.add(
        Cubic.from(
          center.x,
          center.y,
          center.x,
          center.y,
          center.x,
          center.y,
          center.x,
          center.y,
        ),
      );
    }

    return cubics;
  }
}

@internal
Point calculateCenter(List<double> vertices) {
  double cumulativeX = 0.0;
  double cumulativeY = 0.0;
  int index = 0;
  while (index < vertices.length) {
    cumulativeX += vertices[index++];
    cumulativeY += vertices[index++];
  }
  return Point(
    cumulativeX / (vertices.length / 2.0),
    cumulativeY / (vertices.length / 2.0),
  );
}

final class _RoundedCorner {
  _RoundedCorner._({
    required this.p0,
    required this.p1,
    required this.p2,
    this.rounding,
    required this.d1,
    required this.d2,
    required this.cornerRadius,
    required this.smoothing,
    required this.cosAngle,
    required this.sinAngle,
    required this.expectedRoundCut,
  });

  factory _RoundedCorner(
    Point p0,
    Point p1,
    Point p2, [
    CornerRounding? rounding,
  ]) {
    final v01 = p0 - p1;
    final v21 = p2 - p1;
    final d01 = v01.getDistance();
    final d21 = v21.getDistance();

    final Point d1;
    final Point d2;
    final double cornerRadius;
    final double smoothing;
    final double cosAngle;
    final double sinAngle;
    final double expectedRoundCut;

    if (d01 > 0.0 && d21 > 0.0) {
      d1 = v01 / d01;
      d2 = v21 / d21;
      cornerRadius = rounding?.radius ?? 0.0;
      smoothing = rounding?.smoothing ?? 0.0;

      // cosine of angle at p1 is dot product of unit vectors to the other two vertices
      cosAngle = d1.dotProduct(d2);

      // identity: sin^2 + cos^2 = 1
      // sinAngle gives us the intersection
      sinAngle = math.sqrt(1 - square(cosAngle));

      // How much we need to cut, as measured on a side, to get the required radius
      // calculating where the rounding circle hits the edge
      // This uses the identity of tan(A/2) = sinA/(1 + cosA), where tan(A/2) = radius/cut
      expectedRoundCut = sinAngle > 1.0e-3
          ? cornerRadius * (cosAngle + 1) / sinAngle
          : 0.0;
    } else {
      // One (or both) of the sides is empty, not much we can do.
      d1 = const Point(0.0, 0.0);
      d2 = const Point(0.0, 0.0);
      cornerRadius = 0.0;
      smoothing = 0.0;
      cosAngle = 0.0;
      sinAngle = 0.0;
      expectedRoundCut = 0.0;
    }

    return _RoundedCorner._(
      p0: p0,
      p1: p1,
      p2: p2,
      rounding: rounding,
      d1: d1,
      d2: d2,
      cornerRadius: cornerRadius,
      smoothing: smoothing,
      cosAngle: cosAngle,
      sinAngle: sinAngle,
      expectedRoundCut: expectedRoundCut,
    );
  }

  final Point p0;
  final Point p1;
  final Point p2;
  final CornerRounding? rounding;

  final Point d1;
  final Point d2;
  final double cornerRadius;
  final double smoothing;
  final double cosAngle;
  final double sinAngle;
  final double expectedRoundCut;

  double get expectedCut => ((1.0 + smoothing) * expectedRoundCut);

  Point center = const Point(0.0, 0.0);

  List<Cubic> getCubics(double allowedCut0, [double? allowedCut1]) {
    allowedCut1 ??= allowedCut0;

    // We use the minimum of both cuts to determine the radius, but if there is more space
    // in one side we can use it for smoothing.
    final allowedCut = math.min(allowedCut0, allowedCut1);

    // Nothing to do, just use lines, or a point
    if (expectedRoundCut < distanceEpsilon ||
        allowedCut < distanceEpsilon ||
        cornerRadius < distanceEpsilon) {
      center = p1;
      return [Cubic.straightLine(p1.x, p1.y, p1.x, p1.y)];
    }
    // How much of the cut is required for the rounding part.
    final actualRoundCut = math.min(allowedCut, expectedRoundCut);

    // We have two smoothing values, one for each side of the vertex
    // Space is used for rounding values first. If there is space left over, then we
    // apply smoothing, if it was requested
    final actualSmoothing0 = _calculateActualSmoothingValue(allowedCut0);
    final actualSmoothing1 = _calculateActualSmoothingValue(allowedCut1);

    // Scale the radius if needed
    final actualR = cornerRadius * actualRoundCut / expectedRoundCut;

    // Distance from the corner (p1) to the center
    final centerDistance = math.sqrt(square(actualR) + square(actualRoundCut));

    // Center of the arc we will use for rounding
    center = p1 + ((d1 + d2) / 2.0).getDirection() * centerDistance;

    final circleIntersection0 = p1 + d1 * actualRoundCut;
    final circleIntersection2 = p1 + d2 * actualRoundCut;

    final flanking0 = _computeFlankingCurve(
      actualRoundCut,
      actualSmoothing0,
      p1,
      p0,
      circleIntersection0,
      circleIntersection2,
      center,
      actualR,
    );

    final flanking2 = _computeFlankingCurve(
      actualRoundCut,
      actualSmoothing1,
      p1,
      p2,
      circleIntersection2,
      circleIntersection0,
      center,
      actualR,
    ).reverse();

    return [
      flanking0,
      Cubic.circularArc(
        center.x,
        center.y,
        flanking0.anchor1X,
        flanking0.anchor1Y,
        flanking2.anchor0X,
        flanking2.anchor0Y,
      ),
      flanking2,
    ];
  }

  double _calculateActualSmoothingValue(double allowedCut) =>
      allowedCut > expectedCut
      ? smoothing
      : allowedCut > expectedRoundCut
      ? smoothing *
            (allowedCut - expectedRoundCut) /
            (expectedCut - expectedRoundCut)
      : 0.0;

  Cubic _computeFlankingCurve(
    double actualRoundCut,
    double actualSmoothingValues,
    Point corner,
    Point sideStart,
    Point circleSegmentIntersection,
    Point otherCircleSegmentIntersection,
    Point circleCenter,
    double actualR,
  ) {
    // sideStart is the anchor, 'anchor' is actual control point
    final sideDirection = (sideStart - corner).getDirection();
    final curveStart =
        corner + sideDirection * actualRoundCut * (1.0 + actualSmoothingValues);
    // We use an approximation to cut a part of the circle section proportional to 1 - smooth,
    // When smooth = 0, we take the full section, when smooth = 1, we take nothing.
    // TODO: revisit this, it can be problematic as it approaches 180 degrees
    final p = Point.interpolate(
      circleSegmentIntersection,
      (circleSegmentIntersection + otherCircleSegmentIntersection) / 2.0,
      actualSmoothingValues,
    );
    // The flanking curve ends on the circle
    final curveEnd =
        circleCenter +
        directionVector(p.x - circleCenter.x, p.y - circleCenter.y) * actualR;
    // The anchor on the circle segment side is in the intersection between the tangent to the
    // circle in the circle/flanking curve boundary and the linear segment.
    final circleTangent = (curveEnd - circleCenter).rotate90();
    final anchorEnd =
        _lineIntersection(sideStart, sideDirection, curveEnd, circleTangent) ??
        circleSegmentIntersection;
    // From what remains, we pick a point for the start anchor.
    // 2/3 seems to come from design tools?
    final anchorStart = (curveStart + anchorEnd * 2.0) / 3.0;
    return Cubic.fromPoints(curveStart, anchorStart, anchorEnd, curveEnd);
  }

  Point? _lineIntersection(Point p0, Point d0, Point p1, Point d1) {
    final rotatedD1 = d1.rotate90();
    final den = d0.dotProduct(rotatedD1);
    if (den.abs() < distanceEpsilon) return null;
    final num = (p1 - p0).dotProduct(rotatedD1);
    // Also check the relative value. This is equivalent to abs(den/num) < DistanceEpsilon,
    // but avoid doing a division
    if (den.abs() < distanceEpsilon * num.abs()) return null;
    final k = num / den;
    return p0 + d0 * k;
  }
}

List<double> _verticesFromNumVerts({
  required int numVertices,
  required double radius,
  required double centerX,
  required double centerY,
}) {
  final center = Point(centerX, centerY);
  final List<double> result = List.filled(numVertices * 2, 0.0);
  int arrayIndex = 0;
  for (int i = 0; i < numVertices; i++) {
    final vertex =
        radialToCartesian(radius, (math.pi / numVertices * 2.0 * i)) + center;
    result[arrayIndex++] = vertex.x;
    result[arrayIndex++] = vertex.y;
  }
  return result;
}
