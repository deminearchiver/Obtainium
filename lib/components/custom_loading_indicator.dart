import 'dart:math' as math;

import 'package:obtainium/flutter.dart';

// ignore: implementation_imports
import 'package:material/src/material_shapes.dart';

final List<RoundedPolygon> _indeterminateIndicatorPolygons = [
  MaterialShapes.softBurst,
  MaterialShapes.cookie9Sided,
  MaterialShapes.pentagon,
  MaterialShapes.pill,
  MaterialShapes.sunny,
  MaterialShapes.cookie4Sided,
  MaterialShapes.oval,
];

// A custom sequence of shape morphs which looks good.
final List<RoundedPolygon> _indeterminateIndicatorPolygonsCustom1 = [
  MaterialShapes.flower,
  MaterialShapes.clover8Leaf,
  MaterialShapes.clover4Leaf,
];

final List<RoundedPolygon> _determinateIndicatorPolygons = [
  // ignore: invalid_use_of_internal_member
  MaterialShapes.circle.transformedWithMatrix(
    Matrix4.rotationZ(2.0 * math.pi / 20.0),
  ),
  MaterialShapes.softBurst,
];

class LoadingIndicatorController {
  // TODO: add vsync here
  // TODO: this class manages LoadingIndicator animations and allows syncing multiple loading indicators together
}

class DeterminateLoadingIndicator extends StatefulWidget {
  const DeterminateLoadingIndicator({
    super.key,
    required this.progress,
    this.indicatorPolygons,
  }) : assert(progress >= 0.0 && progress <= 1.0),
       assert(
         indicatorPolygons == null || indicatorPolygons.length >= 2,
         "indicatorPolygons should have, at least, two RoundedPolygons",
       );

  final double progress;
  final List<RoundedPolygon>? indicatorPolygons;

  List<RoundedPolygon> get _indicatorPolygons =>
      indicatorPolygons ?? _determinateIndicatorPolygons;

  @override
  State<DeterminateLoadingIndicator> createState() =>
      _DeterminateLoadingIndicatorState();
}

class _DeterminateLoadingIndicatorState
    extends State<DeterminateLoadingIndicator> {
  double get _progressValue => widget.progress;

  late List<Morph> _morphSequence;
  late double _morphScaleFactor;

  void _updateMorphScaleFactor(List<RoundedPolygon> indicatorPolygons) {
    _morphScaleFactor =
        _calculateScaleFactor(widget._indicatorPolygons) *
        _kActiveIndicatorScale;
  }

  @override
  void initState() {
    super.initState();
    _morphSequence = _updateMorphSequence(
      polygons: widget._indicatorPolygons,
      circularSequence: false,
    );
    _updateMorphScaleFactor(widget._indicatorPolygons);
  }

  @override
  void didUpdateWidget(covariant DeterminateLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget._indicatorPolygons, oldWidget._indicatorPolygons)) {
      _morphSequence = _updateMorphSequence(
        morphSequence: _morphSequence,
        polygons: widget._indicatorPolygons,
        circularSequence: false,
      );
      _updateMorphScaleFactor(widget._indicatorPolygons);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    _morphSequence = _updateMorphSequence(
      morphSequence: _morphSequence,
      polygons: widget._indicatorPolygons,
      circularSequence: false,
    );
    _updateMorphScaleFactor(widget._indicatorPolygons);
  }

  @override
  Widget build(BuildContext context) {
    // Adjust the active morph index according to the progress.
    final activeMorphIndex = math.min(
      (_morphSequence.length * _progressValue).toInt(),
      (_morphSequence.length - 1),
    );

    // Prepare the progress value that will be used for the active Morph.
    final adjustedProgressValue =
        _progressValue == 1.0 && activeMorphIndex == _morphSequence.length - 1
        // Prevents a zero when the progress is one and we are at the last
        // shape morph.
        ? 1.0
        : (_progressValue * _morphSequence.length) % 1.0;

    final currentMorph = _morphSequence[activeMorphIndex];

    // Rotate counterclockwise.
    final rotation = -_progressValue * math.pi;

    return RepaintBoundary(
      child: Semantics(
        label: "$_progressValue",
        value: "$_progressValue",
        child: SizedBox(
          width: _kContainerWidth,
          height: _kContainerHeight,
          child: Material(
            animationDuration: Duration.zero,
            clipBehavior: Clip.antiAlias,
            type: MaterialType.card,
            shape: const StadiumBorder(),
            color: ColorTheme.of(context).primaryContainer,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (_kContainerWidth - _kIndicatorSize) / 2.0,
                vertical: (_kContainerHeight - _kIndicatorSize) / 2.0,
              ),
              child: CustomPaint(
                size: Size.square(_kIndicatorSize),
                painter: _DeterminateLoadingIndicatorPainter(
                  currentMorph: currentMorph,
                  morphScaleFactor: _morphScaleFactor,
                  adjustedProgressValue: adjustedProgressValue,
                  rotation: rotation,
                  indicatorColor: ColorTheme.of(context).onPrimaryContainer,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DeterminateLoadingIndicatorPainter extends CustomPainter {
  const _DeterminateLoadingIndicatorPainter({
    required this.currentMorph,
    required this.morphScaleFactor,
    required this.adjustedProgressValue,
    required this.rotation,
    required this.indicatorColor,
  });

  final Morph currentMorph;
  final double morphScaleFactor;
  final double adjustedProgressValue;
  final double rotation;
  final Color indicatorColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final morphPath = currentMorph.toPath(
      progress: adjustedProgressValue,
      startAngle: 0,
    );

    final processedPath = _processPath(
      path: morphPath,
      size: size,
      scaleFactor: morphScaleFactor,
    );

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = indicatorColor;

    canvas
      // Save the canvas before applying the transform
      ..save()
      // Rotate the canvas around the size's center
      ..translate(center.dx, center.dy)
      ..rotate(rotation)
      ..translate(-center.dx, -center.dy)
      // Draw the processed path onto the canvas
      ..drawPath(processedPath, paint)
      // Restore the canvas after applying the transform
      ..restore();
  }

  @override
  bool shouldRepaint(_DeterminateLoadingIndicatorPainter oldDelegate) {
    return currentMorph != oldDelegate.currentMorph ||
        morphScaleFactor != oldDelegate.morphScaleFactor ||
        adjustedProgressValue != oldDelegate.adjustedProgressValue ||
        rotation != oldDelegate.rotation ||
        indicatorColor != oldDelegate.indicatorColor;
  }
}

final double _kContainerWidth = 48.0;
final double _kContainerHeight = 48.0;
final double _kIndicatorSize = 38.0;

final double _kActiveIndicatorScale =
    _kIndicatorSize / math.min(_kContainerWidth, _kContainerHeight);

const int _kGlobalRotationDurationMs = 4666;
const int _kMorphIntervalMs = 650;

const double _kFullRotation = 2.0 * math.pi;
const double _kQuarterRotation = _kFullRotation / 4.0;

Iterable<Morph> _generateMorphSequence({
  required List<RoundedPolygon> polygons,
  required bool circularSequence,
  RoundedPolygon Function(RoundedPolygon polygon)? forEachPolygon,
}) sync* {
  forEachPolygon ??= (polygon) => polygon.normalized();
  for (int i = 0; i < polygons.length; i++) {
    if (i + 1 < polygons.length) {
      yield Morph(forEachPolygon(polygons[i]), forEachPolygon(polygons[i + 1]));
    } else if (circularSequence) {
      // Create a morph from the last shape to the first shape
      yield Morph(forEachPolygon(polygons[i]), forEachPolygon(polygons[0]));
    }
  }
}

List<Morph> _updateMorphSequence({
  List<Morph>? morphSequence,
  required List<RoundedPolygon> polygons,
  required bool circularSequence,
  RoundedPolygon Function(RoundedPolygon polygon)? forEachPolygon,
}) {
  final iterable = _generateMorphSequence(
    polygons: polygons,
    circularSequence: circularSequence,
    forEachPolygon: forEachPolygon,
  );

  morphSequence
    ?..clear()
    ..addAll(iterable);
  return morphSequence ?? [...iterable];
}

double _calculateScaleFactor(
  List<RoundedPolygon> indicatorPolygons, {
  bool approximate = true,
}) {
  double scaleFactor = 1.0;

  for (int i = 0; i < indicatorPolygons.length; i++) {
    final polygon = indicatorPolygons[i];

    final bounds = polygon.calculateBounds(approximate: approximate);
    final maxBounds = polygon.calculateMaxBounds();

    final scaleX = bounds.width / maxBounds.width;
    final scaleY = bounds.height / maxBounds.height;

    // We use max(scaleX, scaleY) to handle cases like a pill-shape that can throw off the
    // entire calculation.
    scaleFactor = math.min(scaleFactor, math.max(scaleX, scaleY));
  }

  return scaleFactor;
}

Path _processPath({
  required Path path,
  required Size size,
  required double scaleFactor,
  Matrix4? scaleMatrix,
}) {
  scaleMatrix ??= Matrix4.zero();
  scaleMatrix
    ..setIdentity()
    ..scaleByDouble(
      size.width * scaleFactor,
      size.height * scaleFactor,
      1.0,
      1.0,
    );

  // Scale to the desired size.
  path = path.transform(scaleMatrix.storage);

  // Translate the path to align its center with the available size center.
  path = path.shift(size.center(Offset.zero) - path.getBounds().center);

  return path;
}
