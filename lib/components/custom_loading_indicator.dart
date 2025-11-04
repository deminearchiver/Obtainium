import 'package:flutter/material.dart';
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
  MaterialShapes.circle.normalized(approximate: false),
  MaterialShapes.softBurst,
];

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({super.key, required this.progress});

  final double? progress;

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
