import 'package:material/src/material/flutter.dart';

@immutable
abstract class TypefaceThemeDataPartial with Diagnosticable {
  const TypefaceThemeDataPartial();

  const factory TypefaceThemeDataPartial.from({
    List<String>? plain,
    List<String>? brand,
    double? weightRegular,
    double? weightMedium,
    double? weightBold,
  }) = _TypefaceThemeDataPartial;

  /// md.ref.typeface.plain
  List<String>? get plain;

  /// md.ref.typeface.brand
  List<String>? get brand;

  /// md.ref.typeface.weight-regular
  double? get weightRegular;

  /// md.ref.typeface.weight-medium
  double? get weightMedium;

  /// md.ref.typeface.weight-bold
  double? get weightBold;

  TypefaceThemeDataPartial copyWith({
    List<String>? plain,
    List<String>? brand,
    double? weightRegular,
    double? weightMedium,
    double? weightBold,
  }) =>
      plain != null ||
          brand == null ||
          weightRegular == null ||
          weightMedium == null ||
          weightBold == null
      ? TypefaceThemeDataPartial.from(
          plain: plain ?? this.plain,
          brand: brand ?? this.brand,
          weightRegular: weightRegular ?? this.weightRegular,
          weightMedium: weightMedium ?? this.weightMedium,
          weightBold: weightBold ?? this.weightBold,
        )
      : this;

  TypefaceThemeDataPartial mergeWith({
    List<String>? plain,
    List<String>? brand,
    double? weightRegular,
    double? weightMedium,
    double? weightBold,
  }) =>
      plain != null ||
          brand != null ||
          weightRegular != null ||
          weightMedium != null ||
          weightBold != null
      ? TypefaceThemeDataPartial.from(
          plain: plain != null ? [...plain, ...?this.plain] : this.plain,
          brand: brand != null ? [...brand, ...?this.brand] : this.brand,
          weightRegular: weightRegular ?? this.weightRegular,
          weightMedium: weightMedium ?? this.weightMedium,
          weightBold: weightBold ?? this.weightBold,
        )
      : this;

  TypefaceThemeDataPartial merge(TypefaceThemeDataPartial? other) =>
      other != null
      ? mergeWith(
          plain: other.plain,
          brand: other.brand,
          weightRegular: other.weightRegular,
          weightMedium: other.weightMedium,
          weightBold: other.weightBold,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(IterableProperty("plain", plain, defaultValue: null))
      ..add(IterableProperty("brand", brand, defaultValue: null))
      ..add(DoubleProperty("weightRegular", weightRegular, defaultValue: null))
      ..add(DoubleProperty("weightMedium", weightMedium, defaultValue: null))
      ..add(DoubleProperty("weightBold", weightBold, defaultValue: null));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is TypefaceThemeDataPartial &&
          listEquals(plain, other.plain) &&
          listEquals(brand, other.brand) &&
          weightRegular == other.weightRegular &&
          weightMedium == other.weightMedium &&
          weightBold == other.weightBold;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    plain != null ? Object.hashAll(plain!) : null,
    brand != null ? Object.hashAll(brand!) : null,
    weightRegular,
    weightMedium,
    weightBold,
  );
}

@immutable
class _TypefaceThemeDataPartial extends TypefaceThemeDataPartial {
  const _TypefaceThemeDataPartial({
    this.plain,
    this.brand,
    this.weightRegular,
    this.weightMedium,
    this.weightBold,
  });

  @override
  final List<String>? plain;

  @override
  final List<String>? brand;

  @override
  final double? weightRegular;

  @override
  final double? weightMedium;

  @override
  final double? weightBold;
}

@immutable
abstract class TypefaceThemeData extends TypefaceThemeDataPartial {
  const TypefaceThemeData();

  const factory TypefaceThemeData.from({
    required List<String> plain,
    required List<String> brand,
    required double weightRegular,
    required double weightMedium,
    required double weightBold,
  }) = _TypefaceThemeData;

  const factory TypefaceThemeData.fallback() = _TypefaceThemeData.fallback;

  @override
  List<String> get plain;

  @override
  List<String> get brand;

  @override
  double get weightRegular;

  @override
  double get weightMedium;

  @override
  double get weightBold;

  @override
  TypefaceThemeData copyWith({
    List<String>? plain,
    List<String>? brand,
    double? weightRegular,
    double? weightMedium,
    double? weightBold,
  }) =>
      plain != null ||
          brand != null ||
          weightRegular != null ||
          weightMedium != null ||
          weightBold != null
      ? TypefaceThemeData.from(
          plain: plain ?? this.plain,
          brand: brand ?? this.brand,
          weightRegular: weightRegular ?? this.weightRegular,
          weightMedium: weightMedium ?? this.weightMedium,
          weightBold: weightBold ?? this.weightBold,
        )
      : this;

  @override
  TypefaceThemeData mergeWith({
    List<String>? plain,
    List<String>? brand,
    double? weightRegular,
    double? weightMedium,
    double? weightBold,
  }) =>
      plain != null ||
          brand != null ||
          weightRegular != null ||
          weightMedium != null ||
          weightBold != null
      ? TypefaceThemeData.from(
          plain: plain != null ? [...plain, ...this.plain] : this.plain,
          brand: brand != null ? [...brand, ...this.brand] : this.brand,
          weightRegular: weightRegular ?? this.weightRegular,
          weightMedium: weightMedium ?? this.weightMedium,
          weightBold: weightBold ?? this.weightBold,
        )
      : this;

  @override
  TypefaceThemeData merge(TypefaceThemeDataPartial? other) => other != null
      ? mergeWith(
          plain: other.plain,
          brand: other.brand,
          weightRegular: other.weightRegular,
          weightMedium: other.weightMedium,
          weightBold: other.weightBold,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(IterableProperty("plain", plain))
      ..add(IterableProperty("brand", brand))
      ..add(DoubleProperty("weightRegular", weightRegular))
      ..add(DoubleProperty("weightMedium", weightMedium))
      ..add(DoubleProperty("weightBold", weightBold));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is TypefaceThemeData &&
          listEquals(plain, other.plain) &&
          listEquals(brand, other.brand) &&
          weightRegular == other.weightRegular &&
          weightMedium == other.weightMedium &&
          weightBold == other.weightBold;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    Object.hashAll(plain),
    Object.hashAll(brand),
    weightRegular,
    weightMedium,
    weightBold,
  );
}

@immutable
class _TypefaceThemeData extends TypefaceThemeData {
  const _TypefaceThemeData({
    required this.plain,
    required this.brand,
    required this.weightRegular,
    required this.weightMedium,
    required this.weightBold,
  });

  const _TypefaceThemeData.fallback()
    : plain = const ["Roboto"],
      brand = const ["Roboto"],
      weightRegular = 400.0,
      weightMedium = 500.0,
      weightBold = 700.0;

  @override
  final List<String> plain;

  @override
  final List<String> brand;

  @override
  final double weightRegular;

  @override
  final double weightMedium;

  @override
  final double weightBold;
}

class TypefaceTheme extends InheritedTheme {
  const TypefaceTheme({super.key, required this.data, required super.child});

  final TypefaceThemeData data;

  @override
  bool updateShouldNotify(TypefaceTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      TypefaceTheme(data: data, child: child);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TypefaceThemeData>("data", data));
  }

  static Widget merge({
    Key? key,
    required TypefaceThemeDataPartial data,
    required Widget child,
  }) => Builder(
    builder: (context) =>
        TypefaceTheme(key: key, data: of(context).merge(data), child: child),
  );

  static TypefaceThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TypefaceTheme>()?.data;

  static TypefaceThemeData of(BuildContext context) =>
      maybeOf(context) ?? const TypefaceThemeData.fallback();
}
