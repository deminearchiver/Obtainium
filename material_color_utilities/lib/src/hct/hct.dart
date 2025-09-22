import '../utils/color_utils.dart';
import 'cam16.dart';
import 'hct_solver.dart';
import 'viewing_conditions.dart';

final class Hct {
  late int _argb;

  factory Hct.from(double hue, double chroma, double tone) {
    final argb = HctSolver.solveToInt(hue, chroma, tone);
    return Hct._(argb);
  }

  factory Hct.fromInt(int argb) {
    return Hct._(argb);
  }

  late double _hue;
  double get hue => _hue;
  set hue(double newHue) {
    _setInternalState(HctSolver.solveToInt(newHue, chroma, tone));
  }

  late double _chroma;
  double get chroma => _chroma;
  set chroma(double newChroma) {
    _setInternalState(HctSolver.solveToInt(hue, newChroma, tone));
  }

  late double _tone;
  double get tone => _tone;
  set tone(double newTone) {
    _setInternalState(HctSolver.solveToInt(hue, chroma, newTone));
  }

  int toInt() => _argb;

  Hct inViewingConditions(ViewingConditions vc) {
    // 1. Use CAM16 to find XYZ coordinates of color in specified VC.
    Cam16 cam16 = Cam16.fromInt(toInt());
    final viewedInVc = cam16.xyzInViewingConditions(vc);

    // 2. Create CAM16 of those XYZ coordinates in default VC.
    Cam16 recastInVc = Cam16.fromXyzInViewingConditions(
      viewedInVc[0],
      viewedInVc[1],
      viewedInVc[2],
      ViewingConditions.sRgb,
    );

    // 3. Create HCT from:
    // - CAM16 using default VC with XYZ coordinates in specified VC.
    // - L* converted from Y in XYZ coordinates in specified VC.
    return Hct.from(
      recastInVc.hue,
      recastInVc.chroma,
      ColorUtils.lstarFromY(viewedInVc[1]),
    );
  }

  Hct._(int argb) {
    _setInternalState(argb);
  }

  void _setInternalState(int argb) {
    _argb = argb;
    final cam = Cam16.fromInt(argb);
    _hue = cam.hue;
    _chroma = cam.chroma;
    _tone = ColorUtils.lstarFromArgb(argb);
  }

  @override
  String toString() =>
      "HCT("
      "${_hue.round()}, "
      "${_chroma.round()}, "
      "${_tone.round()}"
      ")";

  static bool isBlue(double hue) {
    return hue >= 250.0 && hue < 270.0;
  }

  static bool isYellow(double hue) {
    return hue >= 105.0 && hue < 125.0;
  }

  static bool isCyan(double hue) {
    return hue >= 170.0 && hue < 207.0;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is Hct &&
            _argb == other._argb &&
            _hue == other._hue &&
            _chroma == other._chroma &&
            _tone == other._tone;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _argb, _hue, _chroma, _tone);
}
