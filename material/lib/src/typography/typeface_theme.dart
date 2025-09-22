import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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

  List<String>? get plain;
  List<String>? get brand;
  double? get weightRegular;
  double? get weightMedium;
  double? get weightBold;

  TypefaceThemeDataPartial copyWith({
    List<String>? plain,
    List<String>? brand,
    double? weightRegular,
    double? weightMedium,
    double? weightBold,
  }) {
    if (plain == null &&
        brand == null &&
        weightRegular == null &&
        weightMedium == null &&
        weightBold == null) {
      return this;
    }
    return TypefaceThemeDataPartial.from(
      plain: plain ?? this.plain,
      brand: brand ?? this.brand,
      weightRegular: weightRegular ?? this.weightRegular,
      weightMedium: weightMedium ?? this.weightMedium,
      weightBold: weightBold ?? this.weightBold,
    );
  }

  TypefaceThemeDataPartial mergeWith({
    List<String>? plain,
    List<String>? brand,
    double? weightRegular,
    double? weightMedium,
    double? weightBold,
  }) {
    if (plain == null &&
        brand == null &&
        weightRegular == null &&
        weightMedium == null &&
        weightBold == null) {
      return this;
    }
    return TypefaceThemeDataPartial.from(
      plain: plain != null ? [...plain, ...?this.plain] : this.plain,
      brand: brand != null ? [...brand, ...?this.brand] : this.brand,
      weightRegular: weightRegular ?? this.weightRegular,
      weightMedium: weightMedium ?? this.weightMedium,
      weightBold: weightBold ?? this.weightBold,
    );
  }

  TypefaceThemeDataPartial merge(TypefaceThemeDataPartial? other) {
    if (other == null) return this;
    return mergeWith(
      plain: other.plain,
      brand: other.brand,
      weightRegular: other.weightRegular,
      weightMedium: other.weightMedium,
      weightBold: other.weightBold,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty("plain", plain, defaultValue: null));
    properties.add(IterableProperty("brand", brand, defaultValue: null));
    properties.add(
      DoubleProperty("weightRegular", weightRegular, defaultValue: null),
    );
    properties.add(
      DoubleProperty("weightMedium", weightMedium, defaultValue: null),
    );
    properties.add(
      DoubleProperty("weightBold", weightBold, defaultValue: null),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is TypefaceThemeDataPartial &&
            listEquals(plain, other.plain) &&
            listEquals(brand, other.brand) &&
            weightRegular == other.weightRegular &&
            weightMedium == other.weightMedium &&
            weightBold == other.weightBold;
  }

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
  }) {
    if (plain == null &&
        brand == null &&
        weightRegular == null &&
        weightMedium == null &&
        weightBold == null) {
      return this;
    }
    return TypefaceThemeData.from(
      plain: plain ?? this.plain,
      brand: brand ?? this.brand,
      weightRegular: weightRegular ?? this.weightRegular,
      weightMedium: weightMedium ?? this.weightMedium,
      weightBold: weightBold ?? this.weightBold,
    );
  }

  @override
  TypefaceThemeData mergeWith({
    List<String>? plain,
    List<String>? brand,
    double? weightRegular,
    double? weightMedium,
    double? weightBold,
  }) {
    if (plain == null &&
        brand == null &&
        weightRegular == null &&
        weightMedium == null &&
        weightBold == null) {
      return this;
    }
    return TypefaceThemeData.from(
      plain: plain != null ? [...plain, ...this.plain] : this.plain,
      brand: brand != null ? [...brand, ...this.brand] : this.brand,
      weightRegular: weightRegular ?? this.weightRegular,
      weightMedium: weightMedium ?? this.weightMedium,
      weightBold: weightBold ?? this.weightBold,
    );
  }

  @override
  TypefaceThemeData merge(TypefaceThemeDataPartial? other) {
    if (other == null) return this;
    return mergeWith(
      plain: other.plain,
      brand: other.brand,
      weightRegular: other.weightRegular,
      weightMedium: other.weightMedium,
      weightBold: other.weightBold,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty("plain", plain));
    properties.add(IterableProperty("brand", brand));
    properties.add(DoubleProperty("weightRegular", weightRegular));
    properties.add(DoubleProperty("weightMedium", weightMedium));
    properties.add(DoubleProperty("weightBold", weightBold));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is TypefaceThemeData &&
            listEquals(plain, other.plain) &&
            listEquals(brand, other.brand) &&
            weightRegular == other.weightRegular &&
            weightMedium == other.weightMedium &&
            weightBold == other.weightBold;
  }

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

@immutable
class TypefaceTheme extends InheritedTheme {
  const TypefaceTheme({super.key, required this.data, required super.child});

  final TypefaceThemeData data;

  @override
  bool updateShouldNotify(covariant TypefaceTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TypefaceTheme(data: data, child: child);
  }

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

  static TypefaceThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TypefaceTheme>()?.data;
  }

  static TypefaceThemeData of(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) return result;
    return const TypefaceThemeData.fallback();
  }
}
