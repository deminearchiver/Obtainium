part of '../androidx_graphics_shapes.dart';

// TODO: implement _pillStarVerticesFromNumVerts

List<double> _starVerticesFromNumVerts(
  int numVerticesPerRadius,
  double radius,
  double innerRadius,
  double centerX,
  double centerY,
) {
  final List<double> result = List.filled(numVerticesPerRadius * 4, 0.0);
  int arrayIndex = 0;
  for (int i = 0; i < numVerticesPerRadius; i++) {
    var vertex = radialToCartesian(
      radius,
      (math.pi / numVerticesPerRadius * 2 * i),
    );
    result[arrayIndex++] = vertex.x + centerX;
    result[arrayIndex++] = vertex.y + centerY;
    vertex = radialToCartesian(
      innerRadius,
      (math.pi / numVerticesPerRadius * (2 * i + 1)),
    );
    result[arrayIndex++] = vertex.x + centerX;
    result[arrayIndex++] = vertex.y + centerY;
  }
  return result;
}
