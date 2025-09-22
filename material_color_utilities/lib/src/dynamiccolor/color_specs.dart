import 'color_spec.dart';
import 'color_spec_2021.dart';
import 'color_spec_2025.dart';

abstract final class ColorSpecs {
  static const ColorSpec _spec2021 = ColorSpec2021();
  static const ColorSpec _spec2025 = ColorSpec2025();

  static ColorSpec get([
    SpecVersion specVersion = SpecVersion.spec2021,
    bool isExtendedFidelity = false,
  ]) {
    return specVersion == SpecVersion.spec2025 ? _spec2025 : _spec2021;
  }
}
