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
  MaterialShapes.circle.transformedWithMatrix(
    Matrix4.rotationZ(2.0 * math.pi / 20.0),
  ),
  // .transformedWithMatrix(Matrix4.rotationZ(18.0 * math.pi / 180.0),),
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
    _morphSequence = _buildMorphSequence(
      polygons: widget._indicatorPolygons,
      circularSequence: false,
    );
    _updateMorphScaleFactor(widget._indicatorPolygons);
  }

  @override
  void didUpdateWidget(covariant DeterminateLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget._indicatorPolygons, oldWidget._indicatorPolygons)) {
      _morphSequence = _buildMorphSequence(
        morphSequence: _morphSequence,
        polygons: widget._indicatorPolygons,
        circularSequence: false,
      );
      _updateMorphScaleFactor(widget._indicatorPolygons);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    _morphSequence = _buildMorphSequence(
      morphSequence: _morphSequence,
      polygons: widget._indicatorPolygons,
      circularSequence: false,
    );
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

    return Semantics(
      label: "$_progressValue",
      value: "$_progressValue",
      child: SizedBox(
        width: _kContainerWidth,
        height: _kContainerHeight,
        child: SizedBox.square(
          dimension: _kIndicatorSize,
          // child: Transform.rotate(
          //   angle: rotation,
          //   child: Material(
          //     animationDuration: Duration.zero,
          //     shape: MorphBorder(
          //       morph: _morphSequence[activeMorphIndex],
          //       progress: adjustedProgressValue,
          //       startAngle: 0,
          //     ),
          //     color: Colors.red,
          //   ),
          // ),
          child: CustomPaint(
            painter: _DeterminateLoadingIndicatorPainter(
              morphSequence: _morphSequence,
              morphScaleFactor: _morphScaleFactor,
              activeMorphIndex: activeMorphIndex,
              adjustedProgressValue: adjustedProgressValue,
              rotation: rotation,
              indicatorColor: ColorTheme.of(context).primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _DeterminateLoadingIndicatorPainter extends CustomPainter {
  const _DeterminateLoadingIndicatorPainter({
    required this.morphSequence,
    required this.morphScaleFactor,
    required this.activeMorphIndex,
    required this.adjustedProgressValue,
    required this.rotation,
    required this.indicatorColor,
  });

  final List<Morph> morphSequence;
  final double morphScaleFactor;
  final int activeMorphIndex;
  final double adjustedProgressValue;
  final double rotation;
  final Color indicatorColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = indicatorColor;

    final morphPath = morphSequence[activeMorphIndex].toPath(
      progress: adjustedProgressValue,
      startAngle: 0,
    );
    final processedPath = _processPath(
      path: morphPath,
      size: size,
      scaleFactor: morphScaleFactor,
    );

    canvas.save();

    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    canvas.drawPath(processedPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_DeterminateLoadingIndicatorPainter oldDelegate) {
    return true;
    // return processedPath != oldDelegate.processedPath ||
    //     rotation != oldDelegate.rotation ||
    //     indicatorColor != oldDelegate.indicatorColor;
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

Iterable<Morph> _morphSequenceIterable({
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

List<Morph> _buildMorphSequence({
  List<Morph>? morphSequence,
  required List<RoundedPolygon> polygons,
  required bool circularSequence,
  RoundedPolygon Function(RoundedPolygon polygon)? forEachPolygon,
}) {
  final iterable = _morphSequenceIterable(
    polygons: polygons,
    circularSequence: circularSequence,
    forEachPolygon: forEachPolygon,
  );

  // TODO: decide if this is better in terms of readability
  // morphSequence
  //   ?..clear()
  //   ..addAll(iterable);
  // morphSequence ??= [...iterable];

  if (morphSequence != null) {
    morphSequence
      ..clear()
      ..addAll(iterable);
  } else {
    morphSequence = [...iterable];
  }

  return morphSequence;
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
  // scaleMatrix: Matrix = Matrix(),
}) {
  // scaleMatrix.reset()

  // scaleMatrix.apply { scale(x = size.width * scaleFactor, y = size.height * scaleFactor) }

  final scaleMatrix = Matrix4.diagonal3Values(
    size.width * scaleFactor,
    size.height * scaleFactor,
    1.0,
  );

  return path
      // Scale to the desired size.
      .transform(scaleMatrix.storage)
      // Translate the path to align its center with the available size center.
      .shift(size.center(Offset.zero) - path.getBounds().center);
}
