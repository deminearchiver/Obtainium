import 'package:material/src/material/flutter.dart';

@immutable
abstract class DurationThemeDataPartial with Diagnosticable {
  const DurationThemeDataPartial();
  const factory DurationThemeDataPartial.from({
    Duration? short1,
    Duration? short2,
    Duration? short3,
    Duration? short4,
    Duration? medium1,
    Duration? medium2,
    Duration? medium3,
    Duration? medium4,
    Duration? long1,
    Duration? long2,
    Duration? long3,
    Duration? long4,
    Duration? extraLong1,
    Duration? extraLong2,
    Duration? extraLong3,
    Duration? extraLong4,
  }) = _DurationThemeDataPartial.from;

  Duration? get short1;

  Duration? get short2;

  Duration? get short3;

  Duration? get short4;

  Duration? get medium1;

  Duration? get medium2;

  Duration? get medium3;

  Duration? get medium4;

  Duration? get long1;

  Duration? get long2;

  Duration? get long3;

  Duration? get long4;

  Duration? get extraLong1;

  Duration? get extraLong2;

  Duration? get extraLong3;

  Duration? get extraLong4;

  DurationThemeDataPartial copyWith({
    Duration? short1,
    Duration? short2,
    Duration? short3,
    Duration? short4,
    Duration? medium1,
    Duration? medium2,
    Duration? medium3,
    Duration? medium4,
    Duration? long1,
    Duration? long2,
    Duration? long3,
    Duration? long4,
    Duration? extraLong1,
    Duration? extraLong2,
    Duration? extraLong3,
    Duration? extraLong4,
  }) =>
      short1 != null ||
          short2 != null ||
          short3 != null ||
          short4 != null ||
          medium1 != null ||
          medium2 != null ||
          medium3 != null ||
          medium4 != null ||
          long1 != null ||
          long2 != null ||
          long3 != null ||
          long4 != null ||
          extraLong1 != null ||
          extraLong2 != null ||
          extraLong3 != null ||
          extraLong4 != null
      ? DurationThemeDataPartial.from(
          short1: short1 ?? this.short1,
          short2: short2 ?? this.short2,
          short3: short3 ?? this.short3,
          short4: short4 ?? this.short4,
          medium1: medium1 ?? this.medium1,
          medium2: medium2 ?? this.medium2,
          medium3: medium3 ?? this.medium3,
          medium4: medium4 ?? this.medium4,
          long1: long1 ?? this.long1,
          long2: long2 ?? this.long2,
          long3: long3 ?? this.long3,
          long4: long4 ?? this.long4,
          extraLong1: extraLong1 ?? this.extraLong1,
          extraLong2: extraLong2 ?? this.extraLong2,
          extraLong3: extraLong3 ?? this.extraLong3,
          extraLong4: extraLong4 ?? this.extraLong4,
        )
      : this;

  DurationThemeDataPartial merge(DurationThemeDataPartial? other) =>
      other != null
      ? copyWith(
          short1: other.short1,
          short2: other.short2,
          short3: other.short3,
          short4: other.short4,
          medium1: other.medium1,
          medium2: other.medium2,
          medium3: other.medium3,
          medium4: other.medium4,
          long1: other.long1,
          long2: other.long2,
          long3: other.long3,
          long4: other.long4,
          extraLong1: other.extraLong1,
          extraLong2: other.extraLong2,
          extraLong3: other.extraLong3,
          extraLong4: other.extraLong4,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty<Duration>("short1", short1, defaultValue: null))
      ..add(DiagnosticsProperty<Duration>("short2", short2, defaultValue: null))
      ..add(DiagnosticsProperty<Duration>("short3", short3, defaultValue: null))
      ..add(DiagnosticsProperty<Duration>("short4", short4, defaultValue: null))
      ..add(
        DiagnosticsProperty<Duration>("medium1", medium1, defaultValue: null),
      )
      ..add(
        DiagnosticsProperty<Duration>("medium2", medium2, defaultValue: null),
      )
      ..add(
        DiagnosticsProperty<Duration>("medium3", medium3, defaultValue: null),
      )
      ..add(
        DiagnosticsProperty<Duration>("medium4", medium4, defaultValue: null),
      )
      ..add(DiagnosticsProperty<Duration>("long1", long1, defaultValue: null))
      ..add(DiagnosticsProperty<Duration>("long2", long2, defaultValue: null))
      ..add(DiagnosticsProperty<Duration>("long3", long3, defaultValue: null))
      ..add(DiagnosticsProperty<Duration>("long4", long4, defaultValue: null))
      ..add(
        DiagnosticsProperty<Duration>(
          "extraLong1",
          extraLong1,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<Duration>(
          "extraLong2",
          extraLong2,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<Duration>(
          "extraLong3",
          extraLong3,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<Duration>(
          "extraLong4",
          extraLong4,
          defaultValue: null,
        ),
      );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is DurationThemeDataPartial &&
          short1 == other.short1 &&
          short2 == other.short2 &&
          short3 == other.short3 &&
          short4 == other.short4 &&
          medium1 == other.medium1 &&
          medium2 == other.medium2 &&
          medium3 == other.medium3 &&
          medium4 == other.medium4 &&
          long1 == other.long1 &&
          long2 == other.long2 &&
          long3 == other.long3 &&
          long4 == other.long4 &&
          extraLong1 == other.extraLong1 &&
          extraLong2 == other.extraLong2 &&
          extraLong3 == other.extraLong3 &&
          extraLong4 == other.extraLong4;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    short1,
    short2,
    short3,
    short4,
    medium1,
    medium2,
    medium3,
    medium4,
    long1,
    long2,
    long3,
    long4,
    extraLong1,
    extraLong2,
    extraLong3,
    extraLong4,
  );
}

@immutable
class _DurationThemeDataPartial extends DurationThemeDataPartial {
  const _DurationThemeDataPartial.from({
    this.short1,
    this.short2,
    this.short3,
    this.short4,
    this.medium1,
    this.medium2,
    this.medium3,
    this.medium4,
    this.long1,
    this.long2,
    this.long3,
    this.long4,
    this.extraLong1,
    this.extraLong2,
    this.extraLong3,
    this.extraLong4,
  });

  @override
  final Duration? short1;

  @override
  final Duration? short2;

  @override
  final Duration? short3;

  @override
  final Duration? short4;

  @override
  final Duration? medium1;

  @override
  final Duration? medium2;

  @override
  final Duration? medium3;

  @override
  final Duration? medium4;

  @override
  final Duration? long1;

  @override
  final Duration? long2;

  @override
  final Duration? long3;

  @override
  final Duration? long4;

  @override
  final Duration? extraLong1;

  @override
  final Duration? extraLong2;

  @override
  final Duration? extraLong3;

  @override
  final Duration? extraLong4;
}

@immutable
abstract class DurationThemeData extends DurationThemeDataPartial {
  const DurationThemeData();

  const factory DurationThemeData.from({
    required Duration short1,
    required Duration short2,
    required Duration short3,
    required Duration short4,
    required Duration medium1,
    required Duration medium2,
    required Duration medium3,
    required Duration medium4,
    required Duration long1,
    required Duration long2,
    required Duration long3,
    required Duration long4,
    required Duration extraLong1,
    required Duration extraLong2,
    required Duration extraLong3,
    required Duration extraLong4,
  }) = _DurationThemeData.from;

  const factory DurationThemeData.fallback() = _DurationThemeData.fallback;

  @override
  Duration get short1;

  @override
  Duration get short2;

  @override
  Duration get short3;

  @override
  Duration get short4;

  @override
  Duration get medium1;

  @override
  Duration get medium2;

  @override
  Duration get medium3;

  @override
  Duration get medium4;

  @override
  Duration get long1;

  @override
  Duration get long2;

  @override
  Duration get long3;

  @override
  Duration get long4;

  @override
  Duration get extraLong1;

  @override
  Duration get extraLong2;

  @override
  Duration get extraLong3;

  @override
  Duration get extraLong4;

  @override
  DurationThemeData copyWith({
    Duration? short1,
    Duration? short2,
    Duration? short3,
    Duration? short4,
    Duration? medium1,
    Duration? medium2,
    Duration? medium3,
    Duration? medium4,
    Duration? long1,
    Duration? long2,
    Duration? long3,
    Duration? long4,
    Duration? extraLong1,
    Duration? extraLong2,
    Duration? extraLong3,
    Duration? extraLong4,
  }) =>
      short1 != null ||
          short2 != null ||
          short3 != null ||
          short4 != null ||
          medium1 != null ||
          medium2 != null ||
          medium3 != null ||
          medium4 != null ||
          long1 != null ||
          long2 != null ||
          long3 != null ||
          long4 != null ||
          extraLong1 != null ||
          extraLong2 != null ||
          extraLong3 != null ||
          extraLong4 != null
      ? DurationThemeData.from(
          short1: short1 ?? this.short1,
          short2: short2 ?? this.short2,
          short3: short3 ?? this.short3,
          short4: short4 ?? this.short4,
          medium1: medium1 ?? this.medium1,
          medium2: medium2 ?? this.medium2,
          medium3: medium3 ?? this.medium3,
          medium4: medium4 ?? this.medium4,
          long1: long1 ?? this.long1,
          long2: long2 ?? this.long2,
          long3: long3 ?? this.long3,
          long4: long4 ?? this.long4,
          extraLong1: extraLong1 ?? this.extraLong1,
          extraLong2: extraLong2 ?? this.extraLong2,
          extraLong3: extraLong3 ?? this.extraLong3,
          extraLong4: extraLong4 ?? this.extraLong4,
        )
      : this;

  @override
  DurationThemeData merge(DurationThemeDataPartial? other) => other != null
      ? copyWith(
          short1: other.short1,
          short2: other.short2,
          short3: other.short3,
          short4: other.short4,
          medium1: other.medium1,
          medium2: other.medium2,
          medium3: other.medium3,
          medium4: other.medium4,
          long1: other.long1,
          long2: other.long2,
          long3: other.long3,
          long4: other.long4,
          extraLong1: other.extraLong1,
          extraLong2: other.extraLong2,
          extraLong3: other.extraLong3,
          extraLong4: other.extraLong4,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty<Duration>("short1", short1))
      ..add(DiagnosticsProperty<Duration>("short2", short2))
      ..add(DiagnosticsProperty<Duration>("short3", short3))
      ..add(DiagnosticsProperty<Duration>("short4", short4))
      ..add(DiagnosticsProperty<Duration>("medium1", medium1))
      ..add(DiagnosticsProperty<Duration>("medium2", medium2))
      ..add(DiagnosticsProperty<Duration>("medium3", medium3))
      ..add(DiagnosticsProperty<Duration>("medium4", medium4))
      ..add(DiagnosticsProperty<Duration>("long1", long1))
      ..add(DiagnosticsProperty<Duration>("long2", long2))
      ..add(DiagnosticsProperty<Duration>("long3", long3))
      ..add(DiagnosticsProperty<Duration>("long4", long4))
      ..add(DiagnosticsProperty<Duration>("extraLong1", extraLong1))
      ..add(DiagnosticsProperty<Duration>("extraLong2", extraLong2))
      ..add(DiagnosticsProperty<Duration>("extraLong3", extraLong3))
      ..add(DiagnosticsProperty<Duration>("extraLong4", extraLong4));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is DurationThemeData &&
          short1 == other.short1 &&
          short2 == other.short2 &&
          short3 == other.short3 &&
          short4 == other.short4 &&
          medium1 == other.medium1 &&
          medium2 == other.medium2 &&
          medium3 == other.medium3 &&
          medium4 == other.medium4 &&
          long1 == other.long1 &&
          long2 == other.long2 &&
          long3 == other.long3 &&
          long4 == other.long4 &&
          extraLong1 == other.extraLong1 &&
          extraLong2 == other.extraLong2 &&
          extraLong3 == other.extraLong3 &&
          extraLong4 == other.extraLong4;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    short1,
    short2,
    short3,
    short4,
    medium1,
    medium2,
    medium3,
    medium4,
    long1,
    long2,
    long3,
    long4,
    extraLong1,
    extraLong2,
    extraLong3,
    extraLong4,
  );
}

@immutable
class _DurationThemeData extends DurationThemeData {
  const _DurationThemeData.from({
    required this.short1,
    required this.short2,
    required this.short3,
    required this.short4,
    required this.medium1,
    required this.medium2,
    required this.medium3,
    required this.medium4,
    required this.long1,
    required this.long2,
    required this.long3,
    required this.long4,
    required this.extraLong1,
    required this.extraLong2,
    required this.extraLong3,
    required this.extraLong4,
  });

  const _DurationThemeData.fallback()
    : short1 = const Duration(milliseconds: 50),
      short2 = const Duration(milliseconds: 100),
      short3 = const Duration(milliseconds: 150),
      short4 = const Duration(milliseconds: 200),
      medium1 = const Duration(milliseconds: 250),
      medium2 = const Duration(milliseconds: 300),
      medium3 = const Duration(milliseconds: 350),
      medium4 = const Duration(milliseconds: 400),
      long1 = const Duration(milliseconds: 450),
      long2 = const Duration(milliseconds: 500),
      long3 = const Duration(milliseconds: 550),
      long4 = const Duration(milliseconds: 600),
      extraLong1 = const Duration(milliseconds: 700),
      extraLong2 = const Duration(milliseconds: 800),
      extraLong3 = const Duration(milliseconds: 900),
      extraLong4 = const Duration(milliseconds: 1000);

  @override
  final Duration short1;

  @override
  final Duration short2;

  @override
  final Duration short3;

  @override
  final Duration short4;

  @override
  final Duration medium1;

  @override
  final Duration medium2;

  @override
  final Duration medium3;

  @override
  final Duration medium4;

  @override
  final Duration long1;

  @override
  final Duration long2;

  @override
  final Duration long3;

  @override
  final Duration long4;

  @override
  final Duration extraLong1;

  @override
  final Duration extraLong2;

  @override
  final Duration extraLong3;

  @override
  final Duration extraLong4;
}

@immutable
class DurationTheme extends InheritedTheme {
  const DurationTheme({super.key, required this.data, required super.child});

  final DurationThemeData data;

  @override
  bool updateShouldNotify(DurationTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      DurationTheme(data: data, child: child);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DurationThemeData>("data", data));
  }

  static Widget merge({
    Key? key,
    required DurationThemeDataPartial data,
    required Widget child,
  }) => Builder(
    builder: (context) =>
        DurationTheme(key: key, data: of(context).merge(data), child: child),
  );

  static DurationThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DurationTheme>()?.data;

  static DurationThemeData of(BuildContext context) =>
      maybeOf(context) ?? const DurationThemeData.fallback();
}
