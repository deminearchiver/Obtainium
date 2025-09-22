import '../hct/hct.dart';

abstract final class DislikeAnalyzer {
  static bool isDisliked(Hct hct) {
    final bool huePasses = hct.hue.round() >= 90 && hct.hue.round() <= 111;
    final bool chromaPasses = hct.chroma.round() > 16;
    final bool tonePasses = hct.tone < 65;

    return huePasses && chromaPasses && tonePasses;
  }

  static Hct fixIfDisliked(Hct hct) {
    if (isDisliked(hct)) {
      return Hct.from(hct.hue, hct.chroma, 70.0);
    }
    return hct;
  }
}
