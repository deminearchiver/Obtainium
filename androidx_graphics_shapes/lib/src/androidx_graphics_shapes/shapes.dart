part of '../androidx_graphics_shapes.dart';

List<double> _pillStarVerticesFromNumVerts(
  int numVerticesPerRadius,
  double width,
  double height,
  double innerRadius,
  double vertexSpacing,
  double startLocation,
  double centerX,
  double centerY,
) {
  // The general approach here is to get the perimeter of the underlying pill outline,
  // then the t value for each vertex as we walk that perimeter. This tells us where
  // on the outline to place that vertex, then we figure out where to place the vertex
  // depending on which "section" it is in. The possible sections are the vertical edges
  // on the sides, the circular sections on all four corners, or the horizontal edges
  // on the top and bottom. Note that either the vertical or horizontal edges will be
  // of length zero (whichever dimension is smaller gets only circular curvature for the
  // pill shape).
  final endcapRadius = math.min(width, height);
  final vSegLen = math.max(0.0, height - width);
  final hSegLen = math.max(0.0, width - height);
  final vSegHalf = vSegLen / 2.0;
  final hSegHalf = hSegLen / 2.0;

  // vertexSpacing is used to position the vertices on the end caps. The caller has the choice
  // of spacing the inner (0) or outer (1) vertices like those along the edges, causing the
  // other vertices to be either further apart (0) or closer (1). The default is .5, which
  // averages things. The magnitude of the inner and rounding parameters may cause the caller
  // to want a different value.
  final circlePerimeter =
      twoPi * endcapRadius * interpolateDouble(innerRadius, 1.0, vertexSpacing);

  // perimeter is circle perimeter plus horizontal and vertical sections of inner rectangle,
  // whether either (or even both) might be of length zero.
  final perimeter = 2.0 * hSegLen + 2.0 * vSegLen + circlePerimeter;

  // The sections array holds the t start values of that part of the outline. We use these to
  // determine which section a given vertex lies in, based on its t value, as well as where
  // in that section it lies.
  final List<double> sections = List.filled(11, 0.0);
  sections[0] = 0.0;
  sections[1] = vSegLen / 2.0;
  sections[2] = sections[1] + circlePerimeter / 4.0;
  sections[3] = sections[2] + hSegLen;
  sections[4] = sections[3] + circlePerimeter / 4.0;
  sections[5] = sections[4] + vSegLen;
  sections[6] = sections[5] + circlePerimeter / 4.0;
  sections[7] = sections[6] + hSegLen;
  sections[8] = sections[7] + circlePerimeter / 4.0;
  sections[9] = sections[8] + vSegLen / 2.0;
  sections[10] = perimeter;

  // "t" is the length along the entire pill outline for a given vertex. With vertices spaced
  // evenly along this contour, we can determine for any vertex where it should lie.
  final tPerVertex = perimeter / (2.0 * numVerticesPerRadius);

  // separate iteration for inner vs outer, unlike the other shapes, because
  // the vertices can lie in different quadrants so each needs their own calculation
  var inner = false;

  // Increment section index as we walk around the pill contour with our increasing t values
  int currSecIndex = 0;

  // secStart/End are used to determine how far along a given vertex is in the section
  // in which it lands
  double secStart = 0.0;
  double secEnd = sections[1];

  // t value is used to place each vertex. 0 is on the positive x axis,
  // moving into section 0 to begin with. startLocation, a value from 0 to 1, varies the location
  // anywhere on the perimeter of the shape
  double t = startLocation * perimeter;

  // The list of vertices to be returned
  final List<double> result = List.filled(numVerticesPerRadius * 4, 0.0);

  int arrayIndex = 0;

  final rectBR = Point(hSegHalf, vSegHalf);
  final rectBL = Point(-hSegHalf, vSegHalf);
  final rectTL = Point(-hSegHalf, -vSegHalf);
  final rectTR = Point(hSegHalf, -vSegHalf);

  // Each iteration through this loop uses the next t value as we walk around the shape
  for (int i = 0; i < numVerticesPerRadius * 2; i++) {
    // t could start (and end) after 0; extra boundedT logic makes sure it does the right
    // thing when crossing the boundar past 0 again
    final boundedT = t % perimeter;
    if (boundedT < secStart) currSecIndex = 0;
    while (boundedT >= sections[(currSecIndex + 1) % sections.length]) {
      currSecIndex = (currSecIndex + 1) % sections.length;
      secStart = sections[currSecIndex];
      secEnd = sections[(currSecIndex + 1) % sections.length];
    }

    // find t in section and its proportion of that section's total length
    final tInSection = boundedT - secStart;
    final tProportion = tInSection / (secEnd - secStart);

    // The vertex placement in a section varies depending on whether it is on one of the
    // semicircle endcaps or along one of the straight edges. For the endcaps, we use
    // tProportion to get the angle along that circular cap and add
    // the starting angle for that section. For the edges we use a straight linear calculation
    // given tProportion and the start/end t values for that edge.
    final currRadius = inner ? endcapRadius * innerRadius : endcapRadius;
    final vertex = switch (currSecIndex) {
      0 => Point(currRadius, tProportion * vSegHalf),
      1 => radialToCartesian(currRadius, tProportion * math.pi / 2.0) + rectBR,
      2 => Point(hSegHalf - tProportion * hSegLen, currRadius),
      3 =>
        radialToCartesian(
              currRadius,
              math.pi / 2.0 + (tProportion * math.pi / 2.0),
            ) +
            rectBL,
      4 => Point(-currRadius, vSegHalf - tProportion * vSegLen),
      5 =>
        radialToCartesian(currRadius, math.pi + (tProportion * math.pi / 2.0)) +
            rectTL,
      6 => Point(-hSegHalf + tProportion * hSegLen, -currRadius),
      7 =>
        radialToCartesian(
              currRadius,
              math.pi * 1.5 + (tProportion * math.pi / 2.0),
            ) +
            rectTR,
      // 8
      _ => Point(currRadius, -vSegHalf + tProportion * vSegHalf),
    };

    result[arrayIndex++] = vertex.x + centerX;
    result[arrayIndex++] = vertex.y + centerY;
    t += tPerVertex;
    inner = !inner;
  }
  return result;
}

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
