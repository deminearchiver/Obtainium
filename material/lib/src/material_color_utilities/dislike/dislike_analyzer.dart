import '../hct/hct.dart';

abstract final class DislikeAnalyzer {
  static bool isDisliked(Hct hct) {
    final huePasses = hct.hue.round() >= 90 && hct.hue.round() <= 111;
    final chromaPasses = hct.chroma.round() > 16;
    final tonePasses = hct.tone.round() < 65;
    return huePasses && chromaPasses && tonePasses;
  }

  static Hct fixIfDisliked(Hct hct) =>
      isDisliked(hct) ? Hct.from(hct.hue, hct.chroma, 70.0) : hct;
}
