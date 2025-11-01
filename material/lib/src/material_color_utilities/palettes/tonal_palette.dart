import '../hct/hct.dart';

final class TonalPalette {
  final Map<int, int> _cache;
  final Hct _keyColor;
  final double _hue;
  final double _chroma;

  factory TonalPalette.fromInt(int argb) {
    return TonalPalette.fromHct(Hct.fromInt(argb));
  }

  factory TonalPalette.fromHct(Hct hct) {
    return TonalPalette._(hct.hue, hct.chroma, hct);
  }

  factory TonalPalette.fromHueAndChroma(double hue, double chroma) {
    final keyColor = _KeyColor(hue, chroma).create();
    return TonalPalette._(hue, chroma, keyColor);
  }

  TonalPalette._(this._hue, this._chroma, this._keyColor)
    : _cache = <int, int>{};

  int tone(int tone) {
    return _cache.putIfAbsent(
      tone,
      () => tone == 99 && Hct.isYellow(_hue)
          ? _averageArgb(this.tone(98), this.tone(100))
          : Hct.from(_hue, _chroma, tone.toDouble()).toInt(),
    );
  }

  Hct getHct(double tone) {
    return Hct.from(_hue, _chroma, tone);
  }

  double get chroma => _chroma;

  double get hue => _hue;

  Hct get keyColor => _keyColor;

  static int _averageArgb(int argb1, int argb2) {
    final red1 = (argb1 >>> 16) & 0xff;
    final green1 = (argb1 >>> 8) & 0xff;
    final blue1 = argb1 & 0xff;
    final red2 = (argb2 >>> 16) & 0xff;
    final green2 = (argb2 >>> 8) & 0xff;
    final blue2 = argb2 & 0xff;
    final red = ((red1 + red2) / 2.0).round();
    final green = ((green1 + green2) / 2.0).round();
    final blue = ((blue1 + blue2) / 2.0).round();
    return (255 << 24 |
            (red & 255) << 16 |
            (green & 255) << 8 |
            (blue & 255)) >>>
        0;
  }
}

final class _KeyColor {
  final double _hue;
  final double _requestedChroma;
  final Map<int, double> _chromaCache;
  static const double _maxChromaValue = 200.0;

  _KeyColor(double hue, double requestedChroma)
    : _hue = hue,
      _requestedChroma = requestedChroma,
      _chromaCache = <int, double>{};

  Hct create() {
    // Pivot around T50 because T50 has the most chroma available, on
    // average. Thus it is most likely to have a direct answer.
    final int pivotTone = 50;
    final int toneStepSize = 1;
    // Epsilon to accept values slightly higher than the requested chroma.
    final double epsilon = 0.01;

    // Binary search to find the tone that can provide a chroma that is closest
    // to the requested chroma.
    int lowerTone = 0;
    int upperTone = 100;
    while (lowerTone < upperTone) {
      final int midTone = ((lowerTone + upperTone) / 2).toInt();
      bool isAscending =
          _maxChroma(midTone) < _maxChroma(midTone + toneStepSize);
      bool sufficientChroma = _maxChroma(midTone) >= _requestedChroma - epsilon;

      if (sufficientChroma) {
        // Either range [lowerTone, midTone] or [midTone, upperTone] has
        // the answer, so search in the range that is closer the pivot tone.
        if ((lowerTone - pivotTone).abs() < (upperTone - pivotTone).abs()) {
          upperTone = midTone;
        } else {
          if (lowerTone == midTone) {
            return Hct.from(_hue, _requestedChroma, lowerTone.toDouble());
          }
          lowerTone = midTone;
        }
      } else {
        // As there is no sufficient chroma in the midTone, follow the direction to the chroma
        // peak.
        if (isAscending) {
          lowerTone = midTone + toneStepSize;
        } else {
          // Keep midTone for potential chroma peak.
          upperTone = midTone;
        }
      }
    }

    return Hct.from(_hue, _requestedChroma, lowerTone.toDouble());
  }

  double _maxChroma(int tone) {
    return _chromaCache.putIfAbsent(
      tone,
      () => Hct.from(_hue, _maxChromaValue, tone.toDouble()).chroma,
    );
  }
}
