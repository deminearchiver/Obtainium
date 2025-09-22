import 'dart:math' as math;

import '../utils/color_utils.dart';

abstract final class Contrast {
  static const double ratioMin = 1.0;
  static const double ratioMax = 21.0;
  static const double ratio30 = 3.0;
  static const double ratio45 = 4.5;
  static const double ratio70 = 7.0;
  static const double _contrastRatioEpsilon = 0.04;
  static const double _luminanceGamutMapTolerance = 0.4;

  static double ratioOfYs(double y1, double y2) {
    final double lighter = math.max(y1, y2);
    final double darker = (lighter == y2) ? y1 : y2;
    return (lighter + 5.0) / (darker + 5.0);
  }

  static double ratioOfTones(double t1, double t2) {
    return ratioOfYs(ColorUtils.yFromLstar(t1), ColorUtils.yFromLstar(t2));
  }

  static double lighter(double tone, double ratio) {
    if (tone < 0.0 || tone > 100.0) {
      return -1.0;
    }
    // Invert the contrast ratio equation to determine lighter Y given a ratio and darker Y.
    final double darkY = ColorUtils.yFromLstar(tone);
    final double lightY = ratio * (darkY + 5.0) - 5.0;
    if (lightY < 0.0 || lightY > 100.0) {
      return -1.0;
    }
    final double realContrast = ratioOfYs(lightY, darkY);
    final double delta = (realContrast - ratio).abs();
    if (realContrast < ratio && delta > _contrastRatioEpsilon) {
      return -1.0;
    }

    final double returnValue =
        ColorUtils.lstarFromY(lightY) + _luminanceGamutMapTolerance;
    // NOMUTANTS--important validation step; functions it is calling may change implementation.
    if (returnValue < 0 || returnValue > 100) {
      return -1.0;
    }
    return returnValue;
  }

  static double lighterUnsafe(double tone, double ratio) {
    final lighterSafe = lighter(tone, ratio);
    return lighterSafe < 0.0 ? 100.0 : lighterSafe;
  }

  static double darker(double tone, double ratio) {
    if (tone < 0.0 || tone > 100.0) {
      return -1.0;
    }
    // Invert the contrast ratio equation to determine darker Y given a ratio and lighter Y.
    final double lightY = ColorUtils.yFromLstar(tone);
    final double darkY = ((lightY + 5.0) / ratio) - 5.0;
    if (darkY < 0.0 || darkY > 100.0) {
      return -1.0;
    }
    final double realContrast = ratioOfYs(lightY, darkY);
    final double delta = (realContrast - ratio).abs();
    if (realContrast < ratio && delta > _contrastRatioEpsilon) {
      return -1.0;
    }

    // For information on 0.4 constant, see comment in lighter(tone, ratio).
    final double returnValue =
        ColorUtils.lstarFromY(darkY) - _luminanceGamutMapTolerance;
    // NOMUTANTS--important validation step; functions it is calling may change implementation.
    if (returnValue < 0 || returnValue > 100) {
      return -1.0;
    }
    return returnValue;
  }

  static double darkerUnsafe(double tone, double ratio) {
    double darkerSafe = darker(tone, ratio);
    return math.max(0.0, darkerSafe);
  }
}
