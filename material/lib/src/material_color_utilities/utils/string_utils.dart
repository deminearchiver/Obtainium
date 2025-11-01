import 'color_utils.dart';

abstract final class StringUtils {
  static String hexFromArgb(int argb, {bool leadingHashSign = true}) {
    final red = ColorUtils.redFromArgb(argb);
    final green = ColorUtils.greenFromArgb(argb);
    final blue = ColorUtils.blueFromArgb(argb);
    return "${leadingHashSign ? "#" : ""}"
        "${red.toRadixString(16).padLeft(2, "0").toUpperCase()}"
        "${green.toRadixString(16).padLeft(2, "0").toUpperCase()}"
        "${blue.toRadixString(16).padLeft(2, "0").toUpperCase()}";
  }

  static int? argbFromHex(String hex) {
    return int.tryParse(hex.replaceAll("#", ""), radix: 16);
  }
}
