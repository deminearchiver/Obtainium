import 'dart:math' as math;

import '../hct/cam16.dart';
import '../hct/hct.dart';
import '../utils/color_utils.dart';
import '../utils/math_utils.dart';

abstract final class Blend {
  static int harmonize(int designColor, int sourceColor) {
    final fromHct = Hct.fromInt(designColor);
    final toHct = Hct.fromInt(sourceColor);
    final differenceDegrees = MathUtils.differenceDegrees(
      fromHct.hue,
      toHct.hue,
    );
    final rotationDegrees = math.min(differenceDegrees * 0.5, 15.0);
    final outputHue = MathUtils.sanitizeDegreesDouble(
      fromHct.hue +
          rotationDegrees * MathUtils.rotationDirection(fromHct.hue, toHct.hue),
    );
    return Hct.from(outputHue, fromHct.chroma, fromHct.tone).toInt();
  }

  static int hctHue(int from, int to, double amount) {
    final ucs = cam16Ucs(from, to, amount);
    final ucsCam = Cam16.fromInt(ucs);
    final fromCam = Cam16.fromInt(from);
    final blended = Hct.from(
      ucsCam.hue,
      fromCam.chroma,
      ColorUtils.lstarFromArgb(from),
    );
    return blended.toInt();
  }

  static int cam16Ucs(int from, int to, double amount) {
    final fromCam = Cam16.fromInt(from);
    final toCam = Cam16.fromInt(to);
    final fromJ = fromCam.jstar;
    final fromA = fromCam.astar;
    final fromB = fromCam.bstar;
    final toJ = toCam.jstar;
    final toA = toCam.astar;
    final toB = toCam.bstar;
    final jstar = fromJ + (toJ - fromJ) * amount;
    final astar = fromA + (toA - fromA) * amount;
    final bstar = fromB + (toB - fromB) * amount;
    return Cam16.fromUcs(jstar, astar, bstar).toInt();
  }
}
