import 'dart:math' as math;
import 'dart:collection';

import '../utils/math_utils.dart';
import '../utils/color_utils.dart';
import '../hct/hct.dart';

final class TemperatureCache {
  final Hct input;
  Hct? _precomputedComplement;
  List<Hct>? _precomputedHctsByTemp;
  List<Hct>? _precomputedHctsByHue;
  Map<Hct, double>? _precomputedTempsByHct;

  TemperatureCache(this.input);

  Hct getComplement() {
    if (_precomputedComplement != null) {
      return _precomputedComplement!;
    }

    final coldestHue = _getColdest().hue;
    final coldestTemp = _getTempsByHct()[_getColdest()]!;

    final warmestHue = _getWarmest().hue;
    final warmestTemp = _getTempsByHct()[_getWarmest()]!;
    final range = warmestTemp - coldestTemp;
    final startHueIsColdestToWarmest = _isBetween(
      input.hue,
      coldestHue,
      warmestHue,
    );
    final startHue = startHueIsColdestToWarmest ? warmestHue : coldestHue;
    final endHue = startHueIsColdestToWarmest ? coldestHue : warmestHue;
    final directionOfRotation = 1.0;

    double smallestError = 1000.0;
    Hct answer = _getHctsByHue()[input.hue.round()];

    final complementRelativeTemp = (1.0 - getRelativeTemperature(input));

    // Find the color in the other section, closest to the inverse percentile
    // of the input color. This is the complement.
    for (double hueAddend = 0.0; hueAddend <= 360.0; hueAddend += 1.0) {
      final hue = MathUtils.sanitizeDegreesDouble(
        startHue + directionOfRotation * hueAddend,
      );
      if (!_isBetween(hue, startHue, endHue)) {
        continue;
      }
      final possibleAnswer = _getHctsByHue()[hue.round()];
      final relativeTemp =
          (_getTempsByHct()[possibleAnswer]! - coldestTemp) / range;
      final error = (complementRelativeTemp - relativeTemp).abs();
      if (error < smallestError) {
        smallestError = error;
        answer = possibleAnswer;
      }
    }
    _precomputedComplement = answer;
    return _precomputedComplement!;
  }

  List<Hct> getAnalogousColors([int count = 5, int divisions = 12]) {
    // The starting hue is the hue of the input color.
    final startHue = input.hue.round();
    final startHct = _getHctsByHue()[startHue];
    double lastTemp = getRelativeTemperature(startHct);

    final List<Hct> allColors = <Hct>[];
    allColors.add(startHct);

    double absoluteTotalTempDelta = 0.0;
    for (int i = 0; i < 360; i++) {
      int hue = MathUtils.sanitizeDegreesInt(startHue + i);
      Hct hct = _getHctsByHue()[hue];
      double temp = getRelativeTemperature(hct);
      double tempDelta = (temp - lastTemp).abs();
      lastTemp = temp;
      absoluteTotalTempDelta += tempDelta;
    }

    int hueAddend = 1;
    final tempStep = absoluteTotalTempDelta / divisions.toDouble();
    double totalTempDelta = 0.0;
    lastTemp = getRelativeTemperature(startHct);
    while (allColors.length < divisions) {
      final hue = MathUtils.sanitizeDegreesInt(startHue + hueAddend);
      final hct = _getHctsByHue()[hue];
      final temp = getRelativeTemperature(hct);
      final tempDelta = (temp - lastTemp).abs();
      totalTempDelta += tempDelta;

      double desiredTotalTempDeltaForIndex = (allColors.length * tempStep);
      bool indexSatisfied = totalTempDelta >= desiredTotalTempDeltaForIndex;
      int indexAddend = 1;
      // Keep adding this hue to the answers until its temperature is
      // insufficient. This ensures consistent behavior when there aren't
      // `divisions` discrete steps between 0 and 360 in hue with `tempStep`
      // delta in temperature between them.
      //
      // For example, white and black have no analogues: there are no other
      // colors at T100/T0. Therefore, they should just be added to the array
      // as answers.
      while (indexSatisfied && allColors.length < divisions) {
        allColors.add(hct);
        desiredTotalTempDeltaForIndex =
            ((allColors.length + indexAddend) * tempStep);
        indexSatisfied = totalTempDelta >= desiredTotalTempDeltaForIndex;
        indexAddend++;
      }
      lastTemp = temp;
      hueAddend++;

      if (hueAddend > 360) {
        while (allColors.length < divisions) {
          allColors.add(hct);
        }
        break;
      }
    }

    final List<Hct> answers = <Hct>[];
    answers.add(input);

    final ccwCount = ((count.toDouble() - 1.0) / 2.0).floor();
    for (int i = 1; i < (ccwCount + 1); i++) {
      int index = 0 - i;
      while (index < 0) {
        index = allColors.length + index;
      }
      if (index >= allColors.length) {
        index = index % allColors.length;
      }
      answers.insert(0, allColors[index]);
    }

    final cwCount = count - ccwCount - 1;
    for (int i = 1; i < (cwCount + 1); i++) {
      int index = i;
      while (index < 0) {
        index = allColors.length + index;
      }
      if (index >= allColors.length) {
        index = index % allColors.length;
      }
      answers.add(allColors[index]);
    }

    return answers;
  }

  double getRelativeTemperature(Hct hct) {
    final range =
        _getTempsByHct()[_getWarmest()]! - _getTempsByHct()[_getColdest()]!;
    final differenceFromColdest =
        _getTempsByHct()[hct]! - _getTempsByHct()[_getColdest()]!;
    // Handle when there's no difference in temperature between warmest and
    // coldest: for example, at T100, only one color is available, white.
    return range == 0.0 ? 0.5 : differenceFromColdest / range;
  }

  static double rawTemperature(Hct color) {
    final lab = ColorUtils.labFromArgb(color.toInt());
    final hue = MathUtils.sanitizeDegreesDouble(
      MathUtils.toDegrees(math.atan2(lab[2], lab[1])),
    );
    final chroma = MathUtils.hypot(lab[1], lab[2]);
    return -0.5 +
        0.02 *
            math.pow(chroma, 1.07) *
            math.cos(
              MathUtils.toRadians(MathUtils.sanitizeDegreesDouble(hue - 50.0)),
            );
  }

  List<Hct> _getHctsByHue() {
    if (_precomputedHctsByHue != null) {
      return _precomputedHctsByHue!;
    }
    final hcts = <Hct>[];
    for (double hue = 0.0; hue <= 360.0; hue += 1.0) {
      final colorAtHue = Hct.from(hue, input.chroma, input.tone);
      hcts.add(colorAtHue);
    }
    _precomputedHctsByHue = UnmodifiableListView(hcts);
    return _precomputedHctsByHue!;
  }

  List<Hct> _getHctsByTemp() {
    if (_precomputedHctsByTemp != null) {
      return _precomputedHctsByTemp!;
    }
    final hcts = List.of(_getHctsByHue());
    hcts.add(input);
    hcts.sort((a, b) => _getTempsByHct()[a]!.compareTo(_getTempsByHct()[b]!));
    _precomputedHctsByTemp = hcts;
    return _precomputedHctsByTemp!;
  }

  Map<Hct, double> _getTempsByHct() {
    if (_precomputedTempsByHct != null) {
      return _precomputedTempsByHct!;
    }

    final allHcts = List.of(_getHctsByHue());
    allHcts.add(input);

    final temperaturesByHct = <Hct, double>{};
    for (final hct in allHcts) {
      temperaturesByHct[hct] = rawTemperature(hct);
    }

    _precomputedTempsByHct = temperaturesByHct;
    return _precomputedTempsByHct!;
  }

  Hct _getColdest() => _getHctsByTemp().first;
  Hct _getWarmest() => _getHctsByTemp().last;

  static bool _isBetween(double angle, double a, double b) {
    return a < b ? a <= angle && angle <= b : a <= angle || angle <= b;
  }
}
