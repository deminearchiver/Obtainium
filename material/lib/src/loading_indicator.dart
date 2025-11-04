import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shapes/shapes.dart';

// ignore: implementation_imports
import 'package:shapes/src/material_shapes/material_shapes.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    super.key,
    required this.progress,
    this.indicatorPolygons,
  });

  final double? progress;
  final List<RoundedPolygon>? indicatorPolygons;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _DeterminateLoadingIndicator extends StatefulWidget {
  const _DeterminateLoadingIndicator({super.key, required this.progress});

  final double progress;

  @override
  State<_DeterminateLoadingIndicator> createState() =>
      _DeterminateLoadingIndicatorState();
}

class _DeterminateLoadingIndicatorState
    extends State<_DeterminateLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _IndeterminateLoadingIndicator extends StatefulWidget {
  const _IndeterminateLoadingIndicator({super.key});

  @override
  State<_IndeterminateLoadingIndicator> createState() =>
      __IndeterminateLoadingIndicatorState();
}

class __IndeterminateLoadingIndicatorState
    extends State<_IndeterminateLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

abstract final class _LoadingIndicatorDefaults {
  static const double containerWidth = 48.0;
  static const double containerHeight = 48.0;
  static const double indicatorSize = 38.0;

  static final List<RoundedPolygon> indeterminateIndicatorPolygons =
      UnmodifiableListView([
        MaterialShapes.softBurst,
        MaterialShapes.cookie9Sided,
        MaterialShapes.pentagon,
        MaterialShapes.pill,
        MaterialShapes.sunny,
        MaterialShapes.cookie4Sided,
        MaterialShapes.oval,
      ]);
  static final List<RoundedPolygon> determinateIndicatorPolygons =
      UnmodifiableListView([
        // ignore: invalid_use_of_internal_member
        MaterialShapes.circle.transformedWithMatrix(
          Matrix4.rotationZ(2.0 * math.pi / 20.0),
        ),
        MaterialShapes.softBurst,
      ]);

  static final double activeIndicatorScale =
      indicatorSize / math.min(containerWidth, containerHeight);
}

List<Morph> _morphSequence({
  required List<RoundedPolygon> polygons,
  required bool circularSequence,
}) => [
  for (int i = 0; i < polygons.length; i++)
    if (i + 1 < polygons.length)
      Morph(polygons[i].normalized(), polygons[i + 1].normalized())
    else if (circularSequence)
      Morph(polygons[i].normalized(), polygons[0].normalized()),
];

double _calculateScaleFactor(List<RoundedPolygon> indicatorPolygons) {
  double scaleFactor = 1.0;
  // Axis-aligned max bounding box for this object, where the rectangles left, top, right, and
  // bottom values will be stored in entries 0, 1, 2, and 3, in that order.
  for (final polygon in indicatorPolygons) {
    final bounds = polygon.calculateBounds();
    final maxBounds = polygon.calculateMaxBounds();

    final scaleX = bounds.width / maxBounds.width;
    final scaleY = bounds.height / maxBounds.height;

    // We use max(scaleX, scaleY) to handle cases like a pill-shape that can throw off the
    // entire calculation.
    scaleFactor = math.min(scaleFactor, math.max(scaleX, scaleY));
  }
  return scaleFactor;
}

const int _globalRotationDurationMs = 4666;
const int _morphIntervalMs = 650;

const double _fullRotation = 360.0;
const double quarterRotation = _fullRotation / 4.0;
