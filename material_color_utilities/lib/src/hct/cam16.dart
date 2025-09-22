import 'dart:math' as math;
import '../utils/color_utils.dart';
import '../utils/math_utils.dart';
import 'viewing_conditions.dart';

final class Cam16 {
  static const List<List<double>> _xyzToCam16rgb = [
    [0.401288, 0.650173, -0.051461],
    [-0.250268, 1.204414, 0.045854],
    [-0.002079, 0.048952, 0.953127],
  ];
  static const List<List<double>> _cam16rgbToXyz = [
    [1.8620678, -1.0112547, 0.14918678],
    [0.38752654, 0.62144744, -0.00897398],
    [-0.01584150, -0.03412294, 1.0499644],
  ];

  final double hue;
  final double chroma;
  final double j;
  final double q;
  final double m;
  final double s;

  final double jstar;
  final double astar;
  final double bstar;

  double distance(Cam16 other) {
    final dJ = jstar - other.jstar;
    final dA = astar - other.astar;
    final dB = bstar - other.bstar;
    final dEPrime = math.sqrt(dJ * dJ + dA * dA + dB * dB);
    final dE = 1.41 * math.pow(dEPrime, 0.63).toDouble();
    return dE;
  }

  const Cam16._(
    this.hue,
    this.chroma,
    this.j,
    this.q,
    this.m,
    this.s,
    this.jstar,
    this.astar,
    this.bstar,
  );

  factory Cam16.fromInt(int argb) {
    return Cam16.fromIntInViewingConditions(argb, ViewingConditions.sRgb);
  }

  factory Cam16.fromIntInViewingConditions(
    int argb,
    ViewingConditions viewingConditions,
  ) {
    final red = (argb & 0x00ff0000) >> 16;
    final green = (argb & 0x0000ff00) >> 8;
    final blue = (argb & 0x000000ff);
    final redL = ColorUtils.linearized(red);
    final greenL = ColorUtils.linearized(green);
    final blueL = ColorUtils.linearized(blue);
    final x = 0.41233895 * redL + 0.35762064 * greenL + 0.18051042 * blueL;
    final y = 0.2126 * redL + 0.7152 * greenL + 0.0722 * blueL;
    final z = 0.01932141 * redL + 0.11916382 * greenL + 0.95034478 * blueL;
    return Cam16.fromXyzInViewingConditions(x, y, z, viewingConditions);
  }

  factory Cam16.fromXyzInViewingConditions(
    double x,
    double y,
    double z,
    ViewingConditions viewingConditions,
  ) {
    // Transform XYZ to 'cone'/'rgb' responses
    const matrix = _xyzToCam16rgb;
    double rT = (x * matrix[0][0]) + (y * matrix[0][1]) + (z * matrix[0][2]);
    double gT = (x * matrix[1][0]) + (y * matrix[1][1]) + (z * matrix[1][2]);
    double bT = (x * matrix[2][0]) + (y * matrix[2][1]) + (z * matrix[2][2]);

    // Discount illuminant
    double rD = viewingConditions.rgbD[0] * rT;
    double gD = viewingConditions.rgbD[1] * gT;
    double bD = viewingConditions.rgbD[2] * bT;

    // Chromatic adaptation
    final rAF = math
        .pow(viewingConditions.fl * rD.abs() / 100.0, 0.42)
        .toDouble();
    final gAF = math
        .pow(viewingConditions.fl * gD.abs() / 100.0, 0.42)
        .toDouble();
    final bAF = math
        .pow(viewingConditions.fl * bD.abs() / 100.0, 0.42)
        .toDouble();
    final rA = MathUtils.signum(rD) * 400.0 * rAF / (rAF + 27.13);
    final gA = MathUtils.signum(gD) * 400.0 * gAF / (gAF + 27.13);
    final bA = MathUtils.signum(bD) * 400.0 * bAF / (bAF + 27.13);

    // redness-greenness
    final a = (11.0 * rA + -12.0 * gA + bA) / 11.0;
    // yellowness-blueness
    final b = (rA + gA - 2.0 * bA) / 9.0;

    // auxiliary components
    final u = (20.0 * rA + 20.0 * gA + 21.0 * bA) / 20.0;
    final p2 = (40.0 * rA + 20.0 * gA + bA) / 20.0;

    // hue
    final atan2 = math.atan2(b, a);
    final atanDegrees = MathUtils.toDegrees(atan2);
    final hue = atanDegrees < 0
        ? atanDegrees + 360.0
        : atanDegrees >= 360
        ? atanDegrees - 360.0
        : atanDegrees;
    final hueRadians = MathUtils.toRadians(hue);

    // achromatic response to color
    final ac = p2 * viewingConditions.nbb;

    // CAM16 lightness and brightness
    final j =
        100.0 *
        math
            .pow(
              ac / viewingConditions.aw,
              viewingConditions.c * viewingConditions.z,
            )
            .toDouble();
    final q =
        4.0 /
        viewingConditions.c *
        math.sqrt(j / 100.0) *
        (viewingConditions.aw + 4.0) *
        viewingConditions.flRoot;

    // CAM16 chroma, colorfulness, and saturation.
    final huePrime = (hue < 20.14) ? hue + 360 : hue;
    final eHue = 0.25 * (math.cos(MathUtils.toRadians(huePrime) + 2.0) + 3.8);
    final p1 =
        50000.0 / 13.0 * eHue * viewingConditions.nc * viewingConditions.ncb;
    final t = p1 * MathUtils.hypot(a, b) / (u + 0.305);
    final alpha =
        math
            .pow(1.64 - math.pow(0.29, viewingConditions.n).toDouble(), 0.73)
            .toDouble() *
        math.pow(t, 0.9).toDouble();
    // CAM16 chroma, colorfulness, saturation
    final c = alpha * math.sqrt(j / 100.0);
    final m = c * viewingConditions.flRoot;
    final s =
        50.0 *
        math.sqrt((alpha * viewingConditions.c) / (viewingConditions.aw + 4.0));

    // CAM16-UCS components
    final jstar = (1.0 + 100.0 * 0.007) * j / (1.0 + 0.007 * j);
    final mstar = 1.0 / 0.0228 * math.log(1.0 + 0.0228 * m); // log1p
    final astar = mstar * math.cos(hueRadians);
    final bstar = mstar * math.sin(hueRadians);

    return Cam16._(hue, c, j, q, m, s, jstar, astar, bstar);
  }

  factory Cam16.fromJch(double j, double c, double h) {
    return Cam16.fromJchInViewingConditions(j, c, h, ViewingConditions.sRgb);
  }

  factory Cam16.fromJchInViewingConditions(
    double j,
    double c,
    double h,
    ViewingConditions viewingConditions,
  ) {
    final q =
        4.0 /
        viewingConditions.c *
        math.sqrt(j / 100.0) *
        (viewingConditions.aw + 4.0) *
        viewingConditions.flRoot;
    final m = c * viewingConditions.flRoot;
    final alpha = c / math.sqrt(j / 100.0);
    final s =
        50.0 *
        math.sqrt((alpha * viewingConditions.c) / (viewingConditions.aw + 4.0));

    final hueRadians = MathUtils.toRadians(h);
    final jstar = (1.0 + 100.0 * 0.007) * j / (1.0 + 0.007 * j);
    final mstar = 1.0 / 0.0228 * math.log(1.0 + 0.0228 * m);
    final astar = mstar * math.cos(hueRadians);
    final bstar = mstar * math.sin(hueRadians);
    return Cam16._(h, c, j, q, m, s, jstar, astar, bstar);
  }

  factory Cam16.fromUcs(double jstar, double astar, double bstar) {
    return Cam16.fromUcsInViewingConditions(
      jstar,
      astar,
      bstar,
      ViewingConditions.sRgb,
    );
  }

  factory Cam16.fromUcsInViewingConditions(
    double jstar,
    double astar,
    double bstar,
    ViewingConditions viewingConditions,
  ) {
    final m = MathUtils.hypot(astar, bstar);
    final m2 = (math.exp(m * 0.0228) - 1.0) / 0.0228;
    final c = m2 / viewingConditions.flRoot;
    double h = math.atan2(bstar, astar) * (180.0 / math.pi);
    if (h < 0.0) {
      h += 360.0;
    }
    final j = jstar / (1.0 - (jstar - 100.0) * 0.007);
    return Cam16.fromJchInViewingConditions(j, c, h, viewingConditions);
  }

  int toInt() => viewed(ViewingConditions.sRgb);

  int viewed(ViewingConditions viewingConditions) {
    final xyz = xyzInViewingConditions(viewingConditions);
    return ColorUtils.argbFromXyz(xyz[0], xyz[1], xyz[2]);
  }

  List<double> xyzInViewingConditions(ViewingConditions viewingConditions) {
    final alpha = (chroma == 0.0 || j == 0.0)
        ? 0.0
        : chroma / math.sqrt(j / 100.0);

    final t = math
        .pow(
          alpha / math.pow(1.64 - math.pow(0.29, viewingConditions.n), 0.73),
          1.0 / 0.9,
        )
        .toDouble();
    final hRad = MathUtils.toRadians(hue);

    final eHue = 0.25 * (math.cos(hRad + 2.0) + 3.8);
    final ac =
        viewingConditions.aw *
        math.pow(j / 100.0, 1.0 / viewingConditions.c / viewingConditions.z);
    final p1 =
        eHue * (50000.0 / 13.0) * viewingConditions.nc * viewingConditions.ncb;
    final p2 = (ac / viewingConditions.nbb);

    final hSin = math.sin(hRad);
    final hCos = math.cos(hRad);

    final gamma =
        23.0 *
        (p2 + 0.305) *
        t /
        (23.0 * p1 + 11.0 * t * hCos + 108.0 * t * hSin);
    final a = gamma * hCos;
    final b = gamma * hSin;
    final rA = (460.0 * p2 + 451.0 * a + 288.0 * b) / 1403.0;
    final gA = (460.0 * p2 - 891.0 * a - 261.0 * b) / 1403.0;
    final bA = (460.0 * p2 - 220.0 * a - 6300.0 * b) / 1403.0;

    final rCBase = math.max(0, (27.13 * rA.abs()) / (400.0 - rA.abs()));
    final rC =
        rA.sign *
        (100.0 / viewingConditions.fl) *
        math.pow(rCBase, 1.0 / 0.42).toDouble();
    final gCBase = math.max(0, (27.13 * gA.abs()) / (400.0 - gA.abs()));
    final gC =
        gA.sign *
        (100.0 / viewingConditions.fl) *
        math.pow(gCBase, 1.0 / 0.42).toDouble();
    final bCBase = math.max(0, (27.13 * bA.abs()) / (400.0 - bA.abs()));
    final bC =
        bA.sign *
        (100.0 / viewingConditions.fl) *
        math.pow(bCBase, 1.0 / 0.42).toDouble();
    final rF = rC / viewingConditions.rgbD[0];
    final gF = gC / viewingConditions.rgbD[1];
    final bF = bC / viewingConditions.rgbD[2];

    const matrix = _cam16rgbToXyz;
    final x = (rF * matrix[0][0]) + (gF * matrix[0][1]) + (bF * matrix[0][2]);
    final y = (rF * matrix[1][0]) + (gF * matrix[1][1]) + (bF * matrix[1][2]);
    final z = (rF * matrix[2][0]) + (gF * matrix[2][1]) + (bF * matrix[2][2]);
    return [x, y, z];
  }
}
