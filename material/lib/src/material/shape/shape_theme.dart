import 'package:material/src/material/flutter.dart';

@immutable
abstract class ShapeCornerThemeDataPartial with Diagnosticable {
  const ShapeCornerThemeDataPartial();

  const factory ShapeCornerThemeDataPartial.from({
    Corner? none,
    Corner? extraSmall,
    CornersGeometry? extraSmallTop,
    Corner? small,
    Corner? medium,
    Corner? large,
    CornersGeometry? largeStart,
    CornersGeometry? largeEnd,
    CornersGeometry? largeTop,
    Corner? largeIncreased,
    Corner? extraLarge,
    CornersGeometry? extraLargeTop,
    Corner? extraLargeIncreased,
    Corner? extraExtraLarge,
    Corner? full,
  }) = _ShapeCornerThemeDataPartial.from;

  Corner? get none;

  Corner? get extraSmall;

  CornersGeometry? get extraSmallTop;

  Corner? get small;

  Corner? get medium;

  Corner? get large;

  CornersGeometry? get largeStart;

  CornersGeometry? get largeEnd;

  CornersGeometry? get largeTop;

  Corner? get largeIncreased;

  Corner? get extraLarge;

  CornersGeometry? get extraLargeTop;

  Corner? get extraLargeIncreased;

  Corner? get extraExtraLarge;

  Corner? get full;

  ShapeCornerThemeDataPartial copyWith({
    Corner? none,
    Corner? extraSmall,
    CornersGeometry? extraSmallTop,
    Corner? small,
    Corner? medium,
    Corner? large,
    CornersGeometry? largeStart,
    CornersGeometry? largeEnd,
    CornersGeometry? largeTop,
    Corner? largeIncreased,
    Corner? extraLarge,
    CornersGeometry? extraLargeTop,
    Corner? extraLargeIncreased,
    Corner? extraExtraLarge,
    Corner? full,
  }) =>
      none != null ||
          extraSmall != null ||
          extraSmallTop != null ||
          small != null ||
          medium != null ||
          large != null ||
          largeStart != null ||
          largeEnd != null ||
          largeTop != null ||
          largeIncreased != null ||
          extraLarge != null ||
          extraLargeTop != null ||
          extraLargeIncreased != null ||
          extraExtraLarge != null ||
          full != null
      ? ShapeCornerThemeDataPartial.from(
          none: none ?? this.none,
          extraSmall: extraSmall ?? this.extraSmall,
          extraSmallTop: extraSmallTop ?? this.extraSmallTop,
          small: small ?? this.small,
          medium: medium ?? this.medium,
          large: large ?? this.large,
          largeStart: largeStart ?? this.largeStart,
          largeEnd: largeEnd ?? this.largeEnd,
          largeTop: largeTop ?? this.largeTop,
          largeIncreased: largeIncreased ?? this.largeIncreased,
          extraLarge: extraLarge ?? this.extraLarge,
          extraLargeTop: extraLargeTop ?? this.extraLargeTop,
          extraLargeIncreased: extraLargeIncreased ?? this.extraLargeIncreased,
          extraExtraLarge: extraExtraLarge ?? this.extraExtraLarge,
          full: full ?? this.full,
        )
      : this;

  ShapeCornerThemeDataPartial merge(ShapeCornerThemeDataPartial? other) =>
      other != null
      ? copyWith(
          none: other.none,
          extraSmall: other.extraSmall,
          extraSmallTop: other.extraSmallTop,
          small: other.small,
          medium: other.medium,
          large: other.large,
          largeStart: other.largeStart,
          largeEnd: other.largeEnd,
          largeTop: other.largeTop,
          largeIncreased: other.largeIncreased,
          extraLarge: other.extraLarge,
          extraLargeTop: other.extraLargeTop,
          extraLargeIncreased: other.extraLargeIncreased,
          extraExtraLarge: other.extraExtraLarge,
          full: other.full,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement Diagnosticable for Corner, CornersGeometry, etc.
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is ShapeCornerThemeDataPartial &&
          none == other.none &&
          extraSmall == other.extraSmall &&
          extraSmallTop == other.extraSmallTop &&
          small == other.small &&
          medium == other.medium &&
          large == other.large &&
          largeStart == other.largeStart &&
          largeEnd == other.largeEnd &&
          largeTop == other.largeTop &&
          largeIncreased == other.largeIncreased &&
          extraLarge == other.extraLarge &&
          extraLargeTop == other.extraLargeTop &&
          extraLargeIncreased == other.extraLargeIncreased &&
          extraExtraLarge == other.extraExtraLarge &&
          full == other.full;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    none,
    extraSmall,
    extraSmallTop,
    small,
    medium,
    large,
    largeStart,
    largeEnd,
    largeTop,
    largeIncreased,
    extraLarge,
    extraLargeTop,
    extraLargeIncreased,
    extraExtraLarge,
    full,
  );
}

@immutable
class _ShapeCornerThemeDataPartial extends ShapeCornerThemeDataPartial {
  const _ShapeCornerThemeDataPartial.from({
    this.none,
    this.extraSmall,
    this.extraSmallTop,
    this.small,
    this.medium,
    this.large,
    this.largeStart,
    this.largeEnd,
    this.largeTop,
    this.largeIncreased,
    this.extraLarge,
    this.extraLargeTop,
    this.extraLargeIncreased,
    this.extraExtraLarge,
    this.full,
  });

  @override
  final Corner? none;

  @override
  final Corner? extraSmall;

  @override
  final CornersGeometry? extraSmallTop;

  @override
  final Corner? small;

  @override
  final Corner? medium;

  @override
  final Corner? large;

  @override
  final CornersGeometry? largeStart;

  @override
  final CornersGeometry? largeEnd;

  @override
  final CornersGeometry? largeTop;

  @override
  final Corner? largeIncreased;

  @override
  final Corner? extraLarge;

  @override
  final CornersGeometry? extraLargeTop;

  @override
  final Corner? extraLargeIncreased;

  @override
  final Corner? extraExtraLarge;

  @override
  final Corner? full;
}

@immutable
abstract class ShapeCornerThemeData extends ShapeCornerThemeDataPartial {
  const ShapeCornerThemeData();

  const factory ShapeCornerThemeData.from({
    required Corner none,
    required Corner extraSmall,
    required CornersGeometry extraSmallTop,
    required Corner small,
    required Corner medium,
    required Corner large,
    required CornersGeometry largeStart,
    required CornersGeometry largeEnd,
    required CornersGeometry largeTop,
    required Corner largeIncreased,
    required Corner extraLarge,
    required CornersGeometry extraLargeTop,
    required Corner extraLargeIncreased,
    required Corner extraExtraLarge,
    required Corner full,
  }) = _ShapeCornerThemeData.from;

  const factory ShapeCornerThemeData.fallback() =
      _ShapeCornerThemeData.fallback;

  @override
  Corner get none;

  @override
  Corner get extraSmall;

  @override
  CornersGeometry get extraSmallTop;

  @override
  Corner get small;

  @override
  Corner get medium;

  @override
  Corner get large;

  @override
  CornersGeometry get largeStart;

  @override
  CornersGeometry get largeEnd;

  @override
  CornersGeometry get largeTop;

  @override
  Corner get largeIncreased;

  @override
  Corner get extraLarge;

  @override
  CornersGeometry get extraLargeTop;

  @override
  Corner get extraLargeIncreased;

  @override
  Corner get extraExtraLarge;

  @override
  Corner get full;

  @override
  ShapeCornerThemeData copyWith({
    Corner? none,
    Corner? extraSmall,
    CornersGeometry? extraSmallTop,
    Corner? small,
    Corner? medium,
    Corner? large,
    CornersGeometry? largeStart,
    CornersGeometry? largeEnd,
    CornersGeometry? largeTop,
    Corner? largeIncreased,
    Corner? extraLarge,
    CornersGeometry? extraLargeTop,
    Corner? extraLargeIncreased,
    Corner? extraExtraLarge,
    Corner? full,
  }) =>
      none != null ||
          extraSmall != null ||
          extraSmallTop != null ||
          small != null ||
          medium != null ||
          large != null ||
          largeStart != null ||
          largeEnd != null ||
          largeTop != null ||
          largeIncreased != null ||
          extraLarge != null ||
          extraLargeTop != null ||
          extraLargeIncreased != null ||
          extraExtraLarge != null ||
          full != null
      ? ShapeCornerThemeData.from(
          none: none ?? this.none,
          extraSmall: extraSmall ?? this.extraSmall,
          extraSmallTop: extraSmallTop ?? this.extraSmallTop,
          small: small ?? this.small,
          medium: medium ?? this.medium,
          large: large ?? this.large,
          largeStart: largeStart ?? this.largeStart,
          largeEnd: largeEnd ?? this.largeEnd,
          largeTop: largeTop ?? this.largeTop,
          largeIncreased: largeIncreased ?? this.largeIncreased,
          extraLarge: extraLarge ?? this.extraLarge,
          extraLargeTop: extraLargeTop ?? this.extraLargeTop,
          extraLargeIncreased: extraLargeIncreased ?? this.extraLargeIncreased,
          extraExtraLarge: extraExtraLarge ?? this.extraExtraLarge,
          full: full ?? this.full,
        )
      : this;

  @override
  ShapeCornerThemeData merge(ShapeCornerThemeDataPartial? other) =>
      other != null
      ? copyWith(
          none: other.none,
          extraSmall: other.extraSmall,
          extraSmallTop: other.extraSmallTop,
          small: other.small,
          medium: other.medium,
          large: other.large,
          largeStart: other.largeStart,
          largeEnd: other.largeEnd,
          largeTop: other.largeTop,
          largeIncreased: other.largeIncreased,
          extraLarge: other.extraLarge,
          extraLargeTop: other.extraLargeTop,
          extraLargeIncreased: other.extraLargeIncreased,
          extraExtraLarge: other.extraExtraLarge,
          full: other.full,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement Diagnosticable for Corner, CornersGeometry, etc.
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is ShapeCornerThemeData &&
          none == other.none &&
          extraSmall == other.extraSmall &&
          extraSmallTop == other.extraSmallTop &&
          small == other.small &&
          medium == other.medium &&
          large == other.large &&
          largeStart == other.largeStart &&
          largeEnd == other.largeEnd &&
          largeTop == other.largeTop &&
          largeIncreased == other.largeIncreased &&
          extraLarge == other.extraLarge &&
          extraLargeTop == other.extraLargeTop &&
          extraLargeIncreased == other.extraLargeIncreased &&
          extraExtraLarge == other.extraExtraLarge &&
          full == other.full;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    none,
    extraSmall,
    extraSmallTop,
    small,
    medium,
    large,
    largeStart,
    largeEnd,
    largeTop,
    largeIncreased,
    extraLarge,
    extraLargeTop,
    extraLargeIncreased,
    extraExtraLarge,
    full,
  );
}

@immutable
class _ShapeCornerThemeData extends ShapeCornerThemeData {
  const _ShapeCornerThemeData.from({
    required this.none,
    required this.extraSmall,
    required this.extraSmallTop,
    required this.small,
    required this.medium,
    required this.large,
    required this.largeStart,
    required this.largeEnd,
    required this.largeTop,
    required this.largeIncreased,
    required this.extraLarge,
    required this.extraLargeTop,
    required this.extraLargeIncreased,
    required this.extraExtraLarge,
    required this.full,
  });

  const _ShapeCornerThemeData.fallback()
    : none = const Corner.circular(0.0),
      extraSmall = const Corner.circular(4.0),
      extraSmallTop = const CornersDirectional.vertical(
        top: Corner.circular(4.0),
      ),
      small = const Corner.circular(8.0),
      medium = const Corner.circular(12.0),
      large = const Corner.circular(16.0),
      largeStart = const CornersDirectional.horizontal(
        start: Corner.circular(16.0),
      ),
      largeEnd = const CornersDirectional.horizontal(
        end: Corner.circular(16.0),
      ),
      largeTop = const CornersDirectional.vertical(top: Corner.circular(16.0)),
      largeIncreased = const Corner.circular(20.0),
      extraLarge = const Corner.circular(28.0),
      extraLargeTop = const CornersDirectional.vertical(
        top: Corner.circular(28.0),
      ),
      extraLargeIncreased = const Corner.circular(32.0),
      extraExtraLarge = const Corner.circular(48.0),
      full = Corner.full;

  @override
  final Corner none;

  @override
  final Corner extraSmall;

  @override
  final CornersGeometry extraSmallTop;

  @override
  final Corner small;

  @override
  final Corner medium;

  @override
  final Corner large;

  @override
  final CornersGeometry largeStart;

  @override
  final CornersGeometry largeEnd;

  @override
  final CornersGeometry largeTop;

  @override
  final Corner largeIncreased;

  @override
  final Corner extraLarge;

  @override
  final CornersGeometry extraLargeTop;

  @override
  final Corner extraLargeIncreased;

  @override
  final Corner extraExtraLarge;

  @override
  final Corner full;
}

@immutable
abstract class ShapeCornerValueThemeDataPartial with Diagnosticable {
  const ShapeCornerValueThemeDataPartial();

  const factory ShapeCornerValueThemeDataPartial.from({
    double? none,
    double? extraSmall,
    double? small,
    double? medium,
    double? large,
    double? largeIncreased,
    double? extraLarge,
    double? extraLargeIncreased,
    double? extraExtraLarge,
  }) = _ShapeCornerValueThemeDataPartial.from;

  double? get none;
  double? get extraSmall;
  double? get small;
  double? get medium;
  double? get large;
  double? get largeIncreased;
  double? get extraLarge;
  double? get extraLargeIncreased;
  double? get extraExtraLarge;

  ShapeCornerValueThemeDataPartial copyWith({
    double? none,
    double? extraSmall,
    double? small,
    double? medium,
    double? large,
    double? largeIncreased,
    double? extraLarge,
    double? extraLargeIncreased,
    double? extraExtraLarge,
  }) =>
      none != null ||
          extraSmall != null ||
          small != null ||
          medium != null ||
          large != null ||
          largeIncreased != null ||
          extraLarge != null ||
          extraLargeIncreased != null ||
          extraExtraLarge != null
      ? ShapeCornerValueThemeDataPartial.from(
          none: none ?? this.none,
          extraSmall: extraSmall ?? this.extraSmall,
          small: small ?? this.small,
          medium: medium ?? this.medium,
          large: large ?? this.large,
          largeIncreased: largeIncreased ?? this.largeIncreased,
          extraLarge: extraLarge ?? this.extraLarge,
          extraLargeIncreased: extraLargeIncreased ?? this.extraLargeIncreased,
          extraExtraLarge: extraExtraLarge ?? this.extraExtraLarge,
        )
      : this;

  ShapeCornerValueThemeDataPartial merge(
    ShapeCornerValueThemeDataPartial? other,
  ) => other != null
      ? copyWith(
          none: other.none,
          extraSmall: other.extraSmall,
          small: other.small,
          medium: other.medium,
          large: other.large,
          largeIncreased: other.largeIncreased,
          extraLarge: other.extraLarge,
          extraLargeIncreased: other.extraLargeIncreased,
          extraExtraLarge: other.extraExtraLarge,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DoubleProperty("none", none, defaultValue: null))
      ..add(DoubleProperty("extraSmall", extraSmall, defaultValue: null))
      ..add(DoubleProperty("small", small, defaultValue: null))
      ..add(DoubleProperty("medium", medium, defaultValue: null))
      ..add(DoubleProperty("large", large, defaultValue: null))
      ..add(
        DoubleProperty("largeIncreased", largeIncreased, defaultValue: null),
      )
      ..add(DoubleProperty("extraLarge", extraLarge, defaultValue: null))
      ..add(
        DoubleProperty(
          "extraLargeIncreased",
          extraLargeIncreased,
          defaultValue: null,
        ),
      )
      ..add(
        DoubleProperty("extraExtraLarge", extraExtraLarge, defaultValue: null),
      );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is ShapeCornerValueThemeDataPartial &&
            none == other.none &&
            extraSmall == other.extraSmall &&
            small == other.small &&
            medium == other.medium &&
            large == other.large &&
            largeIncreased == other.largeIncreased &&
            extraLarge == other.extraLarge &&
            extraLargeIncreased == other.extraLargeIncreased &&
            extraExtraLarge == other.extraExtraLarge;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    none,
    extraSmall,
    small,
    medium,
    large,
    largeIncreased,
    extraLarge,
    extraLargeIncreased,
    extraExtraLarge,
  );
}

@immutable
class _ShapeCornerValueThemeDataPartial
    extends ShapeCornerValueThemeDataPartial {
  const _ShapeCornerValueThemeDataPartial.from({
    this.none,
    this.extraSmall,
    this.small,
    this.medium,
    this.large,
    this.largeIncreased,
    this.extraLarge,
    this.extraLargeIncreased,
    this.extraExtraLarge,
  });

  @override
  final double? none;

  @override
  final double? extraSmall;

  @override
  final double? small;

  @override
  final double? medium;

  @override
  final double? large;

  @override
  final double? largeIncreased;

  @override
  final double? extraLarge;

  @override
  final double? extraLargeIncreased;

  @override
  final double? extraExtraLarge;
}

@immutable
abstract class ShapeCornerValueThemeData
    extends ShapeCornerValueThemeDataPartial {
  const ShapeCornerValueThemeData();

  const factory ShapeCornerValueThemeData.from({
    required double none,
    required double extraSmall,
    required double small,
    required double medium,
    required double large,
    required double largeIncreased,
    required double extraLarge,
    required double extraLargeIncreased,
    required double extraExtraLarge,
  }) = _ShapeCornerValueThemeData.from;

  const factory ShapeCornerValueThemeData.fallback() =
      _ShapeCornerValueThemeData.fallback;

  @override
  double get none;

  @override
  double get extraSmall;

  @override
  double get small;

  @override
  double get medium;

  @override
  double get large;

  @override
  double get largeIncreased;

  @override
  double get extraLarge;

  @override
  double get extraLargeIncreased;

  @override
  double get extraExtraLarge;

  @override
  ShapeCornerValueThemeData copyWith({
    double? none,
    double? extraSmall,
    double? small,
    double? medium,
    double? large,
    double? largeIncreased,
    double? extraLarge,
    double? extraLargeIncreased,
    double? extraExtraLarge,
  }) =>
      none != null ||
          extraSmall != null ||
          small != null ||
          medium != null ||
          large != null ||
          largeIncreased != null ||
          extraLarge != null ||
          extraLargeIncreased != null ||
          extraExtraLarge != null
      ? ShapeCornerValueThemeData.from(
          none: none ?? this.none,
          extraSmall: extraSmall ?? this.extraSmall,
          small: small ?? this.small,
          medium: medium ?? this.medium,
          large: large ?? this.large,
          largeIncreased: largeIncreased ?? this.largeIncreased,
          extraLarge: extraLarge ?? this.extraLarge,
          extraLargeIncreased: extraLargeIncreased ?? this.extraLargeIncreased,
          extraExtraLarge: extraExtraLarge ?? this.extraExtraLarge,
        )
      : this;

  @override
  ShapeCornerValueThemeData merge(ShapeCornerValueThemeDataPartial? other) =>
      other != null
      ? copyWith(
          none: other.none,
          extraSmall: other.extraSmall,
          small: other.small,
          medium: other.medium,
          large: other.large,
          largeIncreased: other.largeIncreased,
          extraLarge: other.extraLarge,
          extraLargeIncreased: other.extraLargeIncreased,
          extraExtraLarge: other.extraExtraLarge,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DoubleProperty("none", none))
      ..add(DoubleProperty("extraSmall", extraSmall))
      ..add(DoubleProperty("small", small))
      ..add(DoubleProperty("medium", medium))
      ..add(DoubleProperty("large", large))
      ..add(DoubleProperty("largeIncreased", largeIncreased))
      ..add(DoubleProperty("extraLarge", extraLarge))
      ..add(DoubleProperty("extraLargeIncreased", extraLargeIncreased))
      ..add(DoubleProperty("extraExtraLarge", extraExtraLarge));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is ShapeCornerValueThemeData &&
          none == other.none &&
          extraSmall == other.extraSmall &&
          small == other.small &&
          medium == other.medium &&
          large == other.large &&
          largeIncreased == other.largeIncreased &&
          extraLarge == other.extraLarge &&
          extraLargeIncreased == other.extraLargeIncreased &&
          extraExtraLarge == other.extraExtraLarge;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    none,
    extraSmall,
    small,
    medium,
    large,
    largeIncreased,
    extraLarge,
    extraLargeIncreased,
    extraExtraLarge,
  );
}

@immutable
class _ShapeCornerValueThemeData extends ShapeCornerValueThemeData {
  const _ShapeCornerValueThemeData.from({
    required this.none,
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.largeIncreased,
    required this.extraLarge,
    required this.extraLargeIncreased,
    required this.extraExtraLarge,
  });

  const _ShapeCornerValueThemeData.fallback()
    : none = 0.0,
      extraSmall = 4.0,
      small = 8.0,
      medium = 12.0,
      large = 16.0,
      largeIncreased = 20.0,
      extraLarge = 28.0,
      extraLargeIncreased = 32.0,
      extraExtraLarge = 48.0;

  @override
  final double none;

  @override
  final double extraSmall;

  @override
  final double small;

  @override
  final double medium;

  @override
  final double large;

  @override
  final double largeIncreased;

  @override
  final double extraLarge;

  @override
  final double extraLargeIncreased;

  @override
  final double extraExtraLarge;
}

@immutable
abstract class ShapeThemeDataPartial with Diagnosticable {
  const ShapeThemeDataPartial();

  const factory ShapeThemeDataPartial.from({
    ShapeCornerThemeDataPartial? corner,
    ShapeCornerValueThemeDataPartial? cornerValue,
  }) = _ShapeThemeDataPartial.from;

  ShapeCornerThemeDataPartial? get corner;

  ShapeCornerValueThemeDataPartial? get cornerValue;

  ShapeThemeDataPartial copyWith({
    covariant ShapeCornerThemeDataPartial? corner,
    covariant ShapeCornerValueThemeDataPartial? cornerValue,
  }) => corner != null || cornerValue != null
      ? ShapeThemeDataPartial.from(
          corner: corner ?? this.corner,
          cornerValue: cornerValue ?? this.cornerValue,
        )
      : this;

  ShapeThemeDataPartial mergeWith({
    ShapeCornerThemeDataPartial? corner,
    ShapeCornerValueThemeDataPartial? cornerValue,
  }) => corner != null || cornerValue != null
      ? ShapeThemeDataPartial.from(
          corner: this.corner?.merge(corner) ?? corner,
          cornerValue: this.cornerValue?.merge(cornerValue) ?? cornerValue,
        )
      : this;

  ShapeThemeDataPartial merge(ShapeThemeDataPartial? other) => other != null
      ? mergeWith(corner: other.corner, cornerValue: other.cornerValue)
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(
        DiagnosticsProperty<ShapeCornerThemeDataPartial>(
          "corner",
          corner,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<ShapeCornerValueThemeDataPartial>(
          "cornerValue",
          cornerValue,
          defaultValue: null,
        ),
      );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is ShapeThemeDataPartial &&
          corner == other.corner &&
          cornerValue == other.cornerValue;

  @override
  int get hashCode => Object.hash(runtimeType, corner, cornerValue);
}

@immutable
class _ShapeThemeDataPartial extends ShapeThemeDataPartial {
  const _ShapeThemeDataPartial.from({this.corner, this.cornerValue});

  @override
  final ShapeCornerThemeDataPartial? corner;

  @override
  final ShapeCornerValueThemeDataPartial? cornerValue;
}

@immutable
abstract class ShapeThemeData extends ShapeThemeDataPartial {
  const ShapeThemeData();

  const factory ShapeThemeData.from({
    required ShapeCornerThemeData corner,
    required ShapeCornerValueThemeData cornerValue,
  }) = _ShapeThemeData.from;

  const factory ShapeThemeData.fallback() = _ShapeThemeData.fallback;

  @override
  ShapeCornerThemeData get corner;

  @override
  ShapeCornerValueThemeData get cornerValue;

  @override
  ShapeThemeData copyWith({
    covariant ShapeCornerThemeData? corner,
    covariant ShapeCornerValueThemeData? cornerValue,
  }) => corner != null || cornerValue != null
      ? ShapeThemeData.from(
          corner: corner ?? this.corner,
          cornerValue: cornerValue ?? this.cornerValue,
        )
      : this;

  @override
  ShapeThemeData mergeWith({
    ShapeCornerThemeDataPartial? corner,
    ShapeCornerValueThemeDataPartial? cornerValue,
  }) => corner != null || cornerValue != null
      ? ShapeThemeData.from(
          corner: this.corner.merge(corner),
          cornerValue: this.cornerValue.merge(cornerValue),
        )
      : this;

  @override
  ShapeThemeData merge(ShapeThemeDataPartial? other) => other != null
      ? mergeWith(corner: other.corner, cornerValue: other.cornerValue)
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty<ShapeCornerThemeData>("corner", corner))
      ..add(
        DiagnosticsProperty<ShapeCornerValueThemeData>(
          "cornerValue",
          cornerValue,
        ),
      );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is ShapeThemeData &&
          corner == other.corner &&
          cornerValue == other.cornerValue;

  @override
  int get hashCode => Object.hash(runtimeType, corner, cornerValue);
}

@immutable
class _ShapeThemeData extends ShapeThemeData {
  const _ShapeThemeData.from({required this.corner, required this.cornerValue});

  const _ShapeThemeData.fallback()
    : corner = const ShapeCornerThemeData.fallback(),
      cornerValue = const ShapeCornerValueThemeData.fallback();

  @override
  final ShapeCornerThemeData corner;

  @override
  final ShapeCornerValueThemeData cornerValue;
}

@immutable
class ShapeTheme extends InheritedTheme {
  const ShapeTheme({super.key, required this.data, required super.child});

  final ShapeThemeData data;

  @override
  bool updateShouldNotify(ShapeTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      ShapeTheme(data: data, child: child);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ShapeThemeData>("data", data));
  }

  static Widget merge({
    Key? key,
    required ShapeThemeDataPartial data,
    required Widget child,
  }) => Builder(
    builder: (context) =>
        ShapeTheme(key: key, data: of(context).merge(data), child: child),
  );

  static ShapeThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ShapeTheme>()?.data;

  static ShapeThemeData of(BuildContext context) =>
      maybeOf(context) ?? const ShapeThemeData.fallback();
}
