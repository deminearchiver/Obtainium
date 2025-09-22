import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class _Linear extends Curve {
  const _Linear();

  @override
  double transformInternal(double t) => t;
}

@immutable
abstract class EasingThemeDataPartial with Diagnosticable {
  const EasingThemeDataPartial();

  const factory EasingThemeDataPartial.from({
    Curve? emphasized,
    Curve? emphasizedAccelerate,
    Curve? emphasizedDecelerate,
    Curve? standard,
    Curve? standardAccelerate,
    Curve? standardDecelerate,
    Curve? legacy,
    Curve? legacyAccelerate,
    Curve? legacyDecelerate,
    Curve? linear,
  }) = _EasingThemeDataPartial.from;

  Curve? get emphasized;
  Curve? get emphasizedAccelerate;
  Curve? get emphasizedDecelerate;
  Curve? get standard;
  Curve? get standardAccelerate;
  Curve? get standardDecelerate;
  Curve? get legacy;
  Curve? get legacyAccelerate;
  Curve? get legacyDecelerate;
  Curve? get linear;

  EasingThemeDataPartial copyWith({
    Curve? emphasized,
    Curve? emphasizedAccelerate,
    Curve? emphasizedDecelerate,
    Curve? standard,
    Curve? standardAccelerate,
    Curve? standardDecelerate,
    Curve? legacy,
    Curve? legacyAccelerate,
    Curve? legacyDecelerate,
    Curve? linear,
  }) {
    if (emphasized == null &&
        emphasizedAccelerate == null &&
        emphasizedDecelerate == null &&
        standard == null &&
        standardAccelerate == null &&
        standardDecelerate == null &&
        legacy == null &&
        legacyAccelerate == null &&
        legacyDecelerate == null &&
        linear == null) {
      return this;
    }
    return EasingThemeDataPartial.from(
      emphasized: emphasized ?? this.emphasized,
      emphasizedAccelerate: emphasizedAccelerate ?? this.emphasizedAccelerate,
      emphasizedDecelerate: emphasizedDecelerate ?? this.emphasizedDecelerate,
      standard: standard ?? this.standard,
      standardAccelerate: standardAccelerate ?? this.standardAccelerate,
      standardDecelerate: standardDecelerate ?? this.standardDecelerate,
      legacy: legacy ?? this.legacy,
      legacyAccelerate: legacyAccelerate ?? this.legacyAccelerate,
      legacyDecelerate: legacyDecelerate ?? this.legacyDecelerate,
      linear: linear ?? this.linear,
    );
  }

  EasingThemeDataPartial merge(EasingThemeDataPartial? other) {
    if (other == null) return this;
    return copyWith(
      emphasized: other.emphasized,
      emphasizedAccelerate: other.emphasizedAccelerate,
      emphasizedDecelerate: other.emphasizedDecelerate,
      standard: other.standard,
      standardAccelerate: other.standardAccelerate,
      standardDecelerate: other.standardDecelerate,
      legacy: other.legacy,
      legacyAccelerate: other.legacyAccelerate,
      legacyDecelerate: other.legacyDecelerate,
      linear: other.linear,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<Curve>("emphasized", emphasized, defaultValue: null),
    );
    properties.add(
      DiagnosticsProperty<Curve>(
        "emphasizedAccelerate",
        emphasizedAccelerate,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Curve>(
        "emphasizedDecelerate",
        emphasizedDecelerate,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Curve>("standard", standard, defaultValue: null),
    );
    properties.add(
      DiagnosticsProperty<Curve>(
        "standardAccelerate",
        standardAccelerate,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Curve>(
        "standardDecelerate",
        standardDecelerate,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Curve>("legacy", legacy, defaultValue: null),
    );
    properties.add(
      DiagnosticsProperty<Curve>(
        "legacyAccelerate",
        legacyAccelerate,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Curve>(
        "legacyDecelerate",
        legacyDecelerate,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Curve>("linear", linear, defaultValue: null),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is EasingThemeDataPartial &&
            emphasized == other.emphasized &&
            emphasizedAccelerate == other.emphasizedAccelerate &&
            emphasizedDecelerate == other.emphasizedDecelerate &&
            standard == other.standard &&
            standardAccelerate == other.standardAccelerate &&
            standardDecelerate == other.standardDecelerate &&
            legacy == other.legacy &&
            legacyAccelerate == other.legacyAccelerate &&
            legacyDecelerate == other.legacyDecelerate &&
            linear == other.linear;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    emphasized,
    emphasizedAccelerate,
    emphasizedDecelerate,
    standard,
    standardAccelerate,
    standardDecelerate,
    legacy,
    legacyAccelerate,
    legacyDecelerate,
    linear,
  );
}

@immutable
class _EasingThemeDataPartial extends EasingThemeDataPartial {
  const _EasingThemeDataPartial.from({
    this.emphasized,
    this.emphasizedAccelerate,
    this.emphasizedDecelerate,
    this.standard,
    this.standardAccelerate,
    this.standardDecelerate,
    this.legacy,
    this.legacyAccelerate,
    this.legacyDecelerate,
    this.linear,
  });

  @override
  final Curve? emphasized;

  @override
  final Curve? emphasizedAccelerate;

  @override
  final Curve? emphasizedDecelerate;

  @override
  final Curve? standard;

  @override
  final Curve? standardAccelerate;

  @override
  final Curve? standardDecelerate;

  @override
  final Curve? legacy;

  @override
  final Curve? legacyAccelerate;

  @override
  final Curve? legacyDecelerate;

  @override
  final Curve? linear;
}

@immutable
abstract class EasingThemeData extends EasingThemeDataPartial {
  const EasingThemeData();

  const factory EasingThemeData.from({
    required Curve emphasized,
    required Curve emphasizedAccelerate,
    required Curve emphasizedDecelerate,
    required Curve standard,
    required Curve standardAccelerate,
    required Curve standardDecelerate,
    required Curve legacy,
    required Curve legacyAccelerate,
    required Curve legacyDecelerate,
    required Curve linear,
  }) = _EasingThemeData.from;

  const factory EasingThemeData.fallback() = _EasingThemeData.fallback;

  @override
  Curve get emphasized;

  @override
  Curve get emphasizedAccelerate;

  @override
  Curve get emphasizedDecelerate;

  @override
  Curve get standard;

  @override
  Curve get standardAccelerate;

  @override
  Curve get standardDecelerate;

  @override
  Curve get legacy;

  @override
  Curve get legacyAccelerate;

  @override
  Curve get legacyDecelerate;

  @override
  Curve get linear;

  @override
  EasingThemeData copyWith({
    Curve? emphasized,
    Curve? emphasizedAccelerate,
    Curve? emphasizedDecelerate,
    Curve? standard,
    Curve? standardAccelerate,
    Curve? standardDecelerate,
    Curve? legacy,
    Curve? legacyAccelerate,
    Curve? legacyDecelerate,
    Curve? linear,
  }) {
    if (emphasized == null &&
        emphasizedAccelerate == null &&
        emphasizedDecelerate == null &&
        standard == null &&
        standardAccelerate == null &&
        standardDecelerate == null &&
        legacy == null &&
        legacyAccelerate == null &&
        legacyDecelerate == null &&
        linear == null) {
      return this;
    }
    return EasingThemeData.from(
      emphasized: emphasized ?? this.emphasized,
      emphasizedAccelerate: emphasizedAccelerate ?? this.emphasizedAccelerate,
      emphasizedDecelerate: emphasizedDecelerate ?? this.emphasizedDecelerate,
      standard: standard ?? this.standard,
      standardAccelerate: standardAccelerate ?? this.standardAccelerate,
      standardDecelerate: standardDecelerate ?? this.standardDecelerate,
      legacy: legacy ?? this.legacy,
      legacyAccelerate: legacyAccelerate ?? this.legacyAccelerate,
      legacyDecelerate: legacyDecelerate ?? this.legacyDecelerate,
      linear: linear ?? this.linear,
    );
  }

  @override
  EasingThemeData merge(EasingThemeDataPartial? other) {
    if (other == null) return this;
    return copyWith(
      emphasized: other.emphasized,
      emphasizedAccelerate: other.emphasizedAccelerate,
      emphasizedDecelerate: other.emphasizedDecelerate,
      standard: other.standard,
      standardAccelerate: other.standardAccelerate,
      standardDecelerate: other.standardDecelerate,
      legacy: other.legacy,
      legacyAccelerate: other.legacyAccelerate,
      legacyDecelerate: other.legacyDecelerate,
      linear: other.linear,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Curve>("emphasized", emphasized));
    properties.add(
      DiagnosticsProperty<Curve>("emphasizedAccelerate", emphasizedAccelerate),
    );
    properties.add(
      DiagnosticsProperty<Curve>("emphasizedDecelerate", emphasizedDecelerate),
    );
    properties.add(DiagnosticsProperty<Curve>("standard", standard));
    properties.add(
      DiagnosticsProperty<Curve>("standardAccelerate", standardAccelerate),
    );
    properties.add(
      DiagnosticsProperty<Curve>("standardDecelerate", standardDecelerate),
    );
    properties.add(DiagnosticsProperty<Curve>("legacy", legacy));
    properties.add(
      DiagnosticsProperty<Curve>("legacyAccelerate", legacyAccelerate),
    );
    properties.add(
      DiagnosticsProperty<Curve>("legacyDecelerate", legacyDecelerate),
    );
    properties.add(DiagnosticsProperty<Curve>("linear", linear));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is EasingThemeData &&
            emphasized == other.emphasized &&
            emphasizedAccelerate == other.emphasizedAccelerate &&
            emphasizedDecelerate == other.emphasizedDecelerate &&
            standard == other.standard &&
            standardAccelerate == other.standardAccelerate &&
            standardDecelerate == other.standardDecelerate &&
            legacy == other.legacy &&
            legacyAccelerate == other.legacyAccelerate &&
            legacyDecelerate == other.legacyDecelerate &&
            linear == other.linear;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    emphasized,
    emphasizedAccelerate,
    emphasizedDecelerate,
    standard,
    standardAccelerate,
    standardDecelerate,
    legacy,
    legacyAccelerate,
    legacyDecelerate,
    linear,
  );
}

@immutable
class _EasingThemeData extends EasingThemeData {
  const _EasingThemeData.from({
    required this.emphasized,
    required this.emphasizedAccelerate,
    required this.emphasizedDecelerate,
    required this.standard,
    required this.standardAccelerate,
    required this.standardDecelerate,
    required this.legacy,
    required this.legacyAccelerate,
    required this.legacyDecelerate,
    required this.linear,
  });

  const _EasingThemeData.fallback()
    : emphasized = const ThreePointCubic(
        Offset(0.05, 0),
        Offset(0.133333, 0.06),
        Offset(0.166666, 0.4),
        Offset(0.208333, 0.82),
        Offset(0.25, 1),
      ),
      emphasizedAccelerate = const Cubic(0.3, 0.0, 0.8, 0.15),
      emphasizedDecelerate = const Cubic(0.05, 0.7, 0.1, 1.0),
      standard = const Cubic(0.2, 0.0, 0.0, 1.0),
      standardAccelerate = const Cubic(0.3, 0.0, 1.0, 1.0),
      standardDecelerate = const Cubic(0.0, 0.0, 0.0, 1.0),
      legacy = const Cubic(0.4, 0.0, 0.2, 1.0),
      legacyAccelerate = const Cubic(0.4, 0.0, 1.0, 1.0),
      legacyDecelerate = const Cubic(0.0, 0.0, 0.2, 1.0),
      linear = const _Linear();

  @override
  final Curve emphasized;

  @override
  final Curve emphasizedAccelerate;

  @override
  final Curve emphasizedDecelerate;

  @override
  final Curve standard;

  @override
  final Curve standardAccelerate;

  @override
  final Curve standardDecelerate;

  @override
  final Curve legacy;

  @override
  final Curve legacyAccelerate;

  @override
  final Curve legacyDecelerate;

  @override
  final Curve linear;
}

@immutable
class EasingTheme extends InheritedTheme {
  const EasingTheme({super.key, required this.data, required super.child});

  final EasingThemeData data;

  @override
  bool updateShouldNotify(covariant EasingTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return EasingTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EasingThemeData>("data", data));
  }

  static Widget merge({
    Key? key,
    required EasingThemeDataPartial data,
    required Widget child,
  }) => Builder(
    builder: (context) =>
        EasingTheme(key: key, data: of(context).merge(data), child: child),
  );

  static EasingThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EasingTheme>()?.data;
  }

  static EasingThemeData of(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) return result;
    return const EasingThemeData.fallback();
  }
}
