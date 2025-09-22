import '../dynamiccolor/dynamic_scheme.dart';
import '../dynamiccolor/variant.dart';

/// A monochrome theme, colors are purely black / white / gray.
@Deprecated("Use DynamicScheme directly instead")
class SchemeMonochrome extends DynamicScheme {
  SchemeMonochrome({
    required super.sourceColorHct,
    required super.isDark,
    required super.contrastLevel,
    super.specVersion = DynamicScheme.defaultSpecVersion,
    super.platform = DynamicScheme.defaultPlatform,
  }) : super.fromPalettesOrKeyColors(variant: Variant.monochrome);
}
