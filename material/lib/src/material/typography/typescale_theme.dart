import 'package:material/src/material/flutter.dart';

@immutable
abstract class TypescaleThemeDataPartial with Diagnosticable {
  const TypescaleThemeDataPartial();

  const factory TypescaleThemeDataPartial.from({
    TypeStylePartial? displayLarge,
    TypeStylePartial? displayMedium,
    TypeStylePartial? displaySmall,
    TypeStylePartial? headlineLarge,
    TypeStylePartial? headlineMedium,
    TypeStylePartial? headlineSmall,
    TypeStylePartial? titleLarge,
    TypeStylePartial? titleMedium,
    TypeStylePartial? titleSmall,
    TypeStylePartial? bodyLarge,
    TypeStylePartial? bodyMedium,
    TypeStylePartial? bodySmall,
    TypeStylePartial? labelLarge,
    TypeStylePartial? labelMedium,
    TypeStylePartial? labelSmall,
    TypeStylePartial? displayLargeEmphasized,
    TypeStylePartial? displayMediumEmphasized,
    TypeStylePartial? displaySmallEmphasized,
    TypeStylePartial? headlineLargeEmphasized,
    TypeStylePartial? headlineMediumEmphasized,
    TypeStylePartial? headlineSmallEmphasized,
    TypeStylePartial? titleLargeEmphasized,
    TypeStylePartial? titleMediumEmphasized,
    TypeStylePartial? titleSmallEmphasized,
    TypeStylePartial? bodyLargeEmphasized,
    TypeStylePartial? bodyMediumEmphasized,
    TypeStylePartial? bodySmallEmphasized,
    TypeStylePartial? labelLargeEmphasized,
    TypeStylePartial? labelMediumEmphasized,
    TypeStylePartial? labelSmallEmphasized,
  }) = _TypescaleThemeDataPartial;

  TypeStylePartial? get displayLarge;

  TypeStylePartial? get displayMedium;

  TypeStylePartial? get displaySmall;

  TypeStylePartial? get headlineLarge;

  TypeStylePartial? get headlineMedium;

  TypeStylePartial? get headlineSmall;

  TypeStylePartial? get titleLarge;

  TypeStylePartial? get titleMedium;

  TypeStylePartial? get titleSmall;

  TypeStylePartial? get bodyLarge;

  TypeStylePartial? get bodyMedium;

  TypeStylePartial? get bodySmall;

  TypeStylePartial? get labelLarge;

  TypeStylePartial? get labelMedium;

  TypeStylePartial? get labelSmall;

  TypeStylePartial? get displayLargeEmphasized;

  TypeStylePartial? get displayMediumEmphasized;

  TypeStylePartial? get displaySmallEmphasized;

  TypeStylePartial? get headlineLargeEmphasized;

  TypeStylePartial? get headlineMediumEmphasized;

  TypeStylePartial? get headlineSmallEmphasized;

  TypeStylePartial? get titleLargeEmphasized;

  TypeStylePartial? get titleMediumEmphasized;

  TypeStylePartial? get titleSmallEmphasized;

  TypeStylePartial? get bodyLargeEmphasized;

  TypeStylePartial? get bodyMediumEmphasized;

  TypeStylePartial? get bodySmallEmphasized;

  TypeStylePartial? get labelLargeEmphasized;

  TypeStylePartial? get labelMediumEmphasized;

  TypeStylePartial? get labelSmallEmphasized;

  TypescaleThemeDataPartial copyWith({
    covariant TypeStylePartial? displayLarge,
    covariant TypeStylePartial? displayMedium,
    covariant TypeStylePartial? displaySmall,
    covariant TypeStylePartial? headlineLarge,
    covariant TypeStylePartial? headlineMedium,
    covariant TypeStylePartial? headlineSmall,
    covariant TypeStylePartial? titleLarge,
    covariant TypeStylePartial? titleMedium,
    covariant TypeStylePartial? titleSmall,
    covariant TypeStylePartial? bodyLarge,
    covariant TypeStylePartial? bodyMedium,
    covariant TypeStylePartial? bodySmall,
    covariant TypeStylePartial? labelLarge,
    covariant TypeStylePartial? labelMedium,
    covariant TypeStylePartial? labelSmall,
    covariant TypeStylePartial? displayLargeEmphasized,
    covariant TypeStylePartial? displayMediumEmphasized,
    covariant TypeStylePartial? displaySmallEmphasized,
    covariant TypeStylePartial? headlineLargeEmphasized,
    covariant TypeStylePartial? headlineMediumEmphasized,
    covariant TypeStylePartial? headlineSmallEmphasized,
    covariant TypeStylePartial? titleLargeEmphasized,
    covariant TypeStylePartial? titleMediumEmphasized,
    covariant TypeStylePartial? titleSmallEmphasized,
    covariant TypeStylePartial? bodyLargeEmphasized,
    covariant TypeStylePartial? bodyMediumEmphasized,
    covariant TypeStylePartial? bodySmallEmphasized,
    covariant TypeStylePartial? labelLargeEmphasized,
    covariant TypeStylePartial? labelMediumEmphasized,
    covariant TypeStylePartial? labelSmallEmphasized,
  }) =>
      displayLarge != null ||
          displayMedium != null ||
          displaySmall != null ||
          headlineLarge != null ||
          headlineMedium != null ||
          headlineSmall != null ||
          titleLarge != null ||
          titleMedium != null ||
          titleSmall != null ||
          bodyLarge != null ||
          bodyMedium != null ||
          bodySmall != null ||
          labelLarge != null ||
          labelMedium != null ||
          labelSmall != null ||
          displayLargeEmphasized != null ||
          displayMediumEmphasized != null ||
          displaySmallEmphasized != null ||
          headlineLargeEmphasized != null ||
          headlineMediumEmphasized != null ||
          headlineSmallEmphasized != null ||
          titleLargeEmphasized != null ||
          titleMediumEmphasized != null ||
          titleSmallEmphasized != null ||
          bodyLargeEmphasized != null ||
          bodyMediumEmphasized != null ||
          bodySmallEmphasized != null ||
          labelLargeEmphasized != null ||
          labelMediumEmphasized != null ||
          labelSmallEmphasized != null
      ? TypescaleThemeDataPartial.from(
          displayLarge: displayLarge ?? this.displayLarge,
          displayMedium: displayMedium ?? this.displayMedium,
          displaySmall: displaySmall ?? this.displaySmall,
          headlineLarge: headlineLarge ?? this.headlineLarge,
          headlineMedium: headlineMedium ?? this.headlineMedium,
          headlineSmall: headlineSmall ?? this.headlineSmall,
          titleLarge: titleLarge ?? this.titleLarge,
          titleMedium: titleMedium ?? this.titleMedium,
          titleSmall: titleSmall ?? this.titleSmall,
          bodyLarge: bodyLarge ?? this.bodyLarge,
          bodyMedium: bodyMedium ?? this.bodyMedium,
          bodySmall: bodySmall ?? this.bodySmall,
          labelLarge: labelLarge ?? this.labelLarge,
          labelMedium: labelMedium ?? this.labelMedium,
          labelSmall: labelSmall ?? this.labelSmall,
          displayLargeEmphasized:
              displayLargeEmphasized ?? this.displayLargeEmphasized,
          displayMediumEmphasized:
              displayMediumEmphasized ?? this.displayMediumEmphasized,
          displaySmallEmphasized:
              displaySmallEmphasized ?? this.displaySmallEmphasized,
          headlineLargeEmphasized:
              headlineLargeEmphasized ?? this.headlineLargeEmphasized,
          headlineMediumEmphasized:
              headlineMediumEmphasized ?? this.headlineMediumEmphasized,
          headlineSmallEmphasized:
              headlineSmallEmphasized ?? this.headlineSmallEmphasized,
          titleLargeEmphasized:
              titleLargeEmphasized ?? this.titleLargeEmphasized,
          titleMediumEmphasized:
              titleMediumEmphasized ?? this.titleMediumEmphasized,
          titleSmallEmphasized:
              titleSmallEmphasized ?? this.titleSmallEmphasized,
          bodyLargeEmphasized: bodyLargeEmphasized ?? this.bodyLargeEmphasized,
          bodyMediumEmphasized:
              bodyMediumEmphasized ?? this.bodyMediumEmphasized,
          bodySmallEmphasized: bodySmallEmphasized ?? this.bodySmallEmphasized,
          labelLargeEmphasized:
              labelLargeEmphasized ?? this.labelLargeEmphasized,
          labelMediumEmphasized:
              labelMediumEmphasized ?? this.labelMediumEmphasized,
          labelSmallEmphasized:
              labelSmallEmphasized ?? this.labelSmallEmphasized,
        )
      : this;

  TypescaleThemeDataPartial mergeWith({
    TypeStylePartial? displayLarge,
    TypeStylePartial? displayMedium,
    TypeStylePartial? displaySmall,
    TypeStylePartial? headlineLarge,
    TypeStylePartial? headlineMedium,
    TypeStylePartial? headlineSmall,
    TypeStylePartial? titleLarge,
    TypeStylePartial? titleMedium,
    TypeStylePartial? titleSmall,
    TypeStylePartial? bodyLarge,
    TypeStylePartial? bodyMedium,
    TypeStylePartial? bodySmall,
    TypeStylePartial? labelLarge,
    TypeStylePartial? labelMedium,
    TypeStylePartial? labelSmall,
    TypeStylePartial? displayLargeEmphasized,
    TypeStylePartial? displayMediumEmphasized,
    TypeStylePartial? displaySmallEmphasized,
    TypeStylePartial? headlineLargeEmphasized,
    TypeStylePartial? headlineMediumEmphasized,
    TypeStylePartial? headlineSmallEmphasized,
    TypeStylePartial? titleLargeEmphasized,
    TypeStylePartial? titleMediumEmphasized,
    TypeStylePartial? titleSmallEmphasized,
    TypeStylePartial? bodyLargeEmphasized,
    TypeStylePartial? bodyMediumEmphasized,
    TypeStylePartial? bodySmallEmphasized,
    TypeStylePartial? labelLargeEmphasized,
    TypeStylePartial? labelMediumEmphasized,
    TypeStylePartial? labelSmallEmphasized,
  }) =>
      displayLarge != null ||
          displayMedium != null ||
          displaySmall != null ||
          headlineLarge != null ||
          headlineMedium != null ||
          headlineSmall != null ||
          titleLarge != null ||
          titleMedium != null ||
          titleSmall != null ||
          bodyLarge != null ||
          bodyMedium != null ||
          bodySmall != null ||
          labelLarge != null ||
          labelMedium != null ||
          labelSmall != null ||
          displayLargeEmphasized != null ||
          displayMediumEmphasized != null ||
          displaySmallEmphasized != null ||
          headlineLargeEmphasized != null ||
          headlineMediumEmphasized != null ||
          headlineSmallEmphasized != null ||
          titleLargeEmphasized != null ||
          titleMediumEmphasized != null ||
          titleSmallEmphasized != null ||
          bodyLargeEmphasized != null ||
          bodyMediumEmphasized != null ||
          bodySmallEmphasized != null ||
          labelLargeEmphasized != null ||
          labelMediumEmphasized != null ||
          labelSmallEmphasized != null
      ? TypescaleThemeDataPartial.from(
          displayLarge: this.displayLarge?.merge(displayLarge) ?? displayLarge,
          displayMedium:
              this.displayMedium?.merge(displayMedium) ?? displayMedium,
          displaySmall: this.displaySmall?.merge(displaySmall) ?? displaySmall,
          headlineLarge:
              this.headlineLarge?.merge(headlineLarge) ?? headlineLarge,
          headlineMedium:
              this.headlineMedium?.merge(headlineMedium) ?? headlineMedium,
          headlineSmall:
              this.headlineSmall?.merge(headlineSmall) ?? headlineSmall,
          titleLarge: this.titleLarge?.merge(titleLarge) ?? titleLarge,
          titleMedium: this.titleMedium?.merge(titleMedium) ?? titleMedium,
          titleSmall: this.titleSmall?.merge(titleSmall) ?? titleSmall,
          bodyLarge: this.bodyLarge?.merge(bodyLarge) ?? bodyLarge,
          bodyMedium: this.bodyMedium?.merge(bodyMedium) ?? bodyMedium,
          bodySmall: this.bodySmall?.merge(bodySmall) ?? bodySmall,
          labelLarge: this.labelLarge?.merge(labelLarge) ?? labelLarge,
          labelMedium: this.labelMedium?.merge(labelMedium) ?? labelMedium,
          labelSmall: this.labelSmall?.merge(labelSmall) ?? labelSmall,
          displayLargeEmphasized:
              this.displayLargeEmphasized?.merge(displayLargeEmphasized) ??
              displayLargeEmphasized,
          displayMediumEmphasized:
              this.displayMediumEmphasized?.merge(displayMediumEmphasized) ??
              displayMediumEmphasized,
          displaySmallEmphasized:
              this.displaySmallEmphasized?.merge(displaySmallEmphasized) ??
              displaySmallEmphasized,
          headlineLargeEmphasized:
              this.headlineLargeEmphasized?.merge(headlineLargeEmphasized) ??
              headlineLargeEmphasized,
          headlineMediumEmphasized:
              this.headlineMediumEmphasized?.merge(headlineMediumEmphasized) ??
              headlineMediumEmphasized,
          headlineSmallEmphasized:
              this.headlineSmallEmphasized?.merge(headlineSmallEmphasized) ??
              headlineSmallEmphasized,
          titleLargeEmphasized:
              this.titleLargeEmphasized?.merge(titleLargeEmphasized) ??
              titleLargeEmphasized,
          titleMediumEmphasized:
              this.titleMediumEmphasized?.merge(titleMediumEmphasized) ??
              titleMediumEmphasized,
          titleSmallEmphasized:
              this.titleSmallEmphasized?.merge(titleSmallEmphasized) ??
              titleSmallEmphasized,
          bodyLargeEmphasized:
              this.bodyLargeEmphasized?.merge(bodyLargeEmphasized) ??
              bodyLargeEmphasized,
          bodyMediumEmphasized:
              this.bodyMediumEmphasized?.merge(bodyMediumEmphasized) ??
              bodyMediumEmphasized,
          bodySmallEmphasized:
              this.bodySmallEmphasized?.merge(bodySmallEmphasized) ??
              bodySmallEmphasized,
          labelLargeEmphasized:
              this.labelLargeEmphasized?.merge(labelLargeEmphasized) ??
              labelLargeEmphasized,
          labelMediumEmphasized:
              this.labelMediumEmphasized?.merge(labelMediumEmphasized) ??
              labelMediumEmphasized,
          labelSmallEmphasized:
              this.labelSmallEmphasized?.merge(labelSmallEmphasized) ??
              labelSmallEmphasized,
        )
      : this;

  TypescaleThemeDataPartial merge(TypescaleThemeDataPartial? other) =>
      other != null
      ? mergeWith(
          displayLarge: other.displayLarge,
          displayMedium: other.displayMedium,
          displaySmall: other.displaySmall,
          headlineLarge: other.headlineLarge,
          headlineMedium: other.headlineMedium,
          headlineSmall: other.headlineSmall,
          titleLarge: other.titleLarge,
          titleMedium: other.titleMedium,
          titleSmall: other.titleSmall,
          bodyLarge: other.bodyLarge,
          bodyMedium: other.bodyMedium,
          bodySmall: other.bodySmall,
          labelLarge: other.labelLarge,
          labelMedium: other.labelMedium,
          labelSmall: other.labelSmall,
          displayLargeEmphasized: other.displayLargeEmphasized,
          displayMediumEmphasized: other.displayMediumEmphasized,
          displaySmallEmphasized: other.displaySmallEmphasized,
          headlineLargeEmphasized: other.headlineLargeEmphasized,
          headlineMediumEmphasized: other.headlineMediumEmphasized,
          headlineSmallEmphasized: other.headlineSmallEmphasized,
          titleLargeEmphasized: other.titleLargeEmphasized,
          titleMediumEmphasized: other.titleMediumEmphasized,
          titleSmallEmphasized: other.titleSmallEmphasized,
          bodyLargeEmphasized: other.bodyLargeEmphasized,
          bodyMediumEmphasized: other.bodyMediumEmphasized,
          bodySmallEmphasized: other.bodySmallEmphasized,
          labelLargeEmphasized: other.labelLargeEmphasized,
          labelMediumEmphasized: other.labelMediumEmphasized,
          labelSmallEmphasized: other.labelSmallEmphasized,
        )
      : this;

  @Deprecated("Use toBaselineTextTheme instead.")
  TextTheme toTextTheme() => toBaselineTextTheme();

  TextTheme toBaselineTextTheme() => TextTheme(
    displayLarge: displayLarge?.toTextStyle(),
    displayMedium: displayMedium?.toTextStyle(),
    displaySmall: displaySmall?.toTextStyle(),
    headlineLarge: headlineLarge?.toTextStyle(),
    headlineMedium: headlineMedium?.toTextStyle(),
    headlineSmall: headlineSmall?.toTextStyle(),
    titleLarge: titleLarge?.toTextStyle(),
    titleMedium: titleMedium?.toTextStyle(),
    titleSmall: titleSmall?.toTextStyle(),
    bodyLarge: bodyLarge?.toTextStyle(),
    bodyMedium: bodyMedium?.toTextStyle(),
    bodySmall: bodySmall?.toTextStyle(),
    labelLarge: labelLarge?.toTextStyle(),
    labelMedium: labelMedium?.toTextStyle(),
    labelSmall: labelSmall?.toTextStyle(),
  );

  TextTheme toEmphasizedTextTheme() => TextTheme(
    displayLarge: displayLargeEmphasized?.toTextStyle(),
    displayMedium: displayMediumEmphasized?.toTextStyle(),
    displaySmall: displaySmallEmphasized?.toTextStyle(),
    headlineLarge: headlineLargeEmphasized?.toTextStyle(),
    headlineMedium: headlineMediumEmphasized?.toTextStyle(),
    headlineSmall: headlineSmallEmphasized?.toTextStyle(),
    titleLarge: titleLargeEmphasized?.toTextStyle(),
    titleMedium: titleMediumEmphasized?.toTextStyle(),
    titleSmall: titleSmallEmphasized?.toTextStyle(),
    bodyLarge: bodyLargeEmphasized?.toTextStyle(),
    bodyMedium: bodyMediumEmphasized?.toTextStyle(),
    bodySmall: bodySmallEmphasized?.toTextStyle(),
    labelLarge: labelLargeEmphasized?.toTextStyle(),
    labelMedium: labelMediumEmphasized?.toTextStyle(),
    labelSmall: labelSmallEmphasized?.toTextStyle(),
  );

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "displayLarge",
          displayLarge,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "displayMedium",
          displayMedium,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "displaySmall",
          displaySmall,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "headlineLarge",
          headlineLarge,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "headlineMedium",
          headlineMedium,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "headlineSmall",
          headlineSmall,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "titleLarge",
          titleLarge,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "titleMedium",
          titleMedium,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "titleSmall",
          titleSmall,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "bodyLarge",
          bodyLarge,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "bodyMedium",
          bodyMedium,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "bodySmall",
          bodySmall,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "labelLarge",
          labelLarge,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "labelMedium",
          labelMedium,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "labelSmall",
          labelSmall,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "displayLargeEmphasized",
          displayLargeEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "displayMediumEmphasized",
          displayMediumEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "displaySmallEmphasized",
          displaySmallEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "headlineLargeEmphasized",
          headlineLargeEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "headlineMediumEmphasized",
          headlineMediumEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "headlineSmallEmphasized",
          headlineSmallEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "titleLargeEmphasized",
          titleLargeEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "titleMediumEmphasized",
          titleMediumEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "titleSmallEmphasized",
          titleSmallEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "bodyLargeEmphasized",
          bodyLargeEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "bodyMediumEmphasized",
          bodyMediumEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "bodySmallEmphasized",
          bodySmallEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "labelLargeEmphasized",
          labelLargeEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "labelMediumEmphasized",
          labelMediumEmphasized,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStylePartial>(
          "labelSmallEmphasized",
          labelSmallEmphasized,
          defaultValue: null,
        ),
      );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is TypescaleThemeDataPartial &&
          displayLarge == other.displayLarge &&
          displayMedium == other.displayMedium &&
          displaySmall == other.displaySmall &&
          headlineLarge == other.headlineLarge &&
          headlineMedium == other.headlineMedium &&
          headlineSmall == other.headlineSmall &&
          titleLarge == other.titleLarge &&
          titleMedium == other.titleMedium &&
          titleSmall == other.titleSmall &&
          bodyLarge == other.bodyLarge &&
          bodyMedium == other.bodyMedium &&
          bodySmall == other.bodySmall &&
          labelLarge == other.labelLarge &&
          labelMedium == other.labelMedium &&
          labelSmall == other.labelSmall &&
          displayLargeEmphasized == other.displayLargeEmphasized &&
          displayMediumEmphasized == other.displayMediumEmphasized &&
          displaySmallEmphasized == other.displaySmallEmphasized &&
          headlineLargeEmphasized == other.headlineLargeEmphasized &&
          headlineMediumEmphasized == other.headlineMediumEmphasized &&
          headlineSmallEmphasized == other.headlineSmallEmphasized &&
          titleLargeEmphasized == other.titleLargeEmphasized &&
          titleMediumEmphasized == other.titleMediumEmphasized &&
          titleSmallEmphasized == other.titleSmallEmphasized &&
          bodyLargeEmphasized == other.bodyLargeEmphasized &&
          bodyMediumEmphasized == other.bodyMediumEmphasized &&
          bodySmallEmphasized == other.bodySmallEmphasized &&
          labelLargeEmphasized == other.labelLargeEmphasized &&
          labelMediumEmphasized == other.labelMediumEmphasized &&
          labelSmallEmphasized == other.labelSmallEmphasized;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    displayLarge,
    displayMedium,
    displaySmall,
    headlineLarge,
    headlineMedium,
    headlineSmall,
    titleLarge,
    titleMedium,
    titleSmall,
    bodyLarge,
    bodyMedium,
    bodySmall,
    labelLarge,
    labelMedium,
    labelSmall,
    displayLargeEmphasized,
    displayMediumEmphasized,
    displaySmallEmphasized,
    Object.hash(
      headlineLargeEmphasized,
      headlineMediumEmphasized,
      headlineSmallEmphasized,
      titleLargeEmphasized,
      titleMediumEmphasized,
      titleSmallEmphasized,
      bodyLargeEmphasized,
      bodyMediumEmphasized,
      bodySmallEmphasized,
      labelLargeEmphasized,
      labelMediumEmphasized,
      labelSmallEmphasized,
    ),
  );
}

@immutable
class _TypescaleThemeDataPartial extends TypescaleThemeDataPartial {
  const _TypescaleThemeDataPartial({
    this.displayLarge,
    this.displayMedium,
    this.displaySmall,
    this.headlineLarge,
    this.headlineMedium,
    this.headlineSmall,
    this.titleLarge,
    this.titleMedium,
    this.titleSmall,
    this.bodyLarge,
    this.bodyMedium,
    this.bodySmall,
    this.labelLarge,
    this.labelMedium,
    this.labelSmall,
    this.displayLargeEmphasized,
    this.displayMediumEmphasized,
    this.displaySmallEmphasized,
    this.headlineLargeEmphasized,
    this.headlineMediumEmphasized,
    this.headlineSmallEmphasized,
    this.titleLargeEmphasized,
    this.titleMediumEmphasized,
    this.titleSmallEmphasized,
    this.bodyLargeEmphasized,
    this.bodyMediumEmphasized,
    this.bodySmallEmphasized,
    this.labelLargeEmphasized,
    this.labelMediumEmphasized,
    this.labelSmallEmphasized,
  });

  @override
  final TypeStylePartial? displayLarge;

  @override
  final TypeStylePartial? displayMedium;

  @override
  final TypeStylePartial? displaySmall;

  @override
  final TypeStylePartial? headlineLarge;

  @override
  final TypeStylePartial? headlineMedium;

  @override
  final TypeStylePartial? headlineSmall;

  @override
  final TypeStylePartial? titleLarge;

  @override
  final TypeStylePartial? titleMedium;

  @override
  final TypeStylePartial? titleSmall;

  @override
  final TypeStylePartial? bodyLarge;

  @override
  final TypeStylePartial? bodyMedium;

  @override
  final TypeStylePartial? bodySmall;

  @override
  final TypeStylePartial? labelLarge;

  @override
  final TypeStylePartial? labelMedium;

  @override
  final TypeStylePartial? labelSmall;

  @override
  final TypeStylePartial? displayLargeEmphasized;

  @override
  final TypeStylePartial? displayMediumEmphasized;

  @override
  final TypeStylePartial? displaySmallEmphasized;

  @override
  final TypeStylePartial? headlineLargeEmphasized;

  @override
  final TypeStylePartial? headlineMediumEmphasized;

  @override
  final TypeStylePartial? headlineSmallEmphasized;

  @override
  final TypeStylePartial? titleLargeEmphasized;

  @override
  final TypeStylePartial? titleMediumEmphasized;

  @override
  final TypeStylePartial? titleSmallEmphasized;

  @override
  final TypeStylePartial? bodyLargeEmphasized;

  @override
  final TypeStylePartial? bodyMediumEmphasized;

  @override
  final TypeStylePartial? bodySmallEmphasized;

  @override
  final TypeStylePartial? labelLargeEmphasized;

  @override
  final TypeStylePartial? labelMediumEmphasized;

  @override
  final TypeStylePartial? labelSmallEmphasized;
}

@immutable
abstract class TypescaleThemeData extends TypescaleThemeDataPartial {
  const TypescaleThemeData();

  const factory TypescaleThemeData.from({
    required TypeStyle displayLarge,
    required TypeStyle displayMedium,
    required TypeStyle displaySmall,
    required TypeStyle headlineLarge,
    required TypeStyle headlineMedium,
    required TypeStyle headlineSmall,
    required TypeStyle titleLarge,
    required TypeStyle titleMedium,
    required TypeStyle titleSmall,
    required TypeStyle bodyLarge,
    required TypeStyle bodyMedium,
    required TypeStyle bodySmall,
    required TypeStyle labelLarge,
    required TypeStyle labelMedium,
    required TypeStyle labelSmall,
    required TypeStyle displayLargeEmphasized,
    required TypeStyle displayMediumEmphasized,
    required TypeStyle displaySmallEmphasized,
    required TypeStyle headlineLargeEmphasized,
    required TypeStyle headlineMediumEmphasized,
    required TypeStyle headlineSmallEmphasized,
    required TypeStyle titleLargeEmphasized,
    required TypeStyle titleMediumEmphasized,
    required TypeStyle titleSmallEmphasized,
    required TypeStyle bodyLargeEmphasized,
    required TypeStyle bodyMediumEmphasized,
    required TypeStyle bodySmallEmphasized,
    required TypeStyle labelLargeEmphasized,
    required TypeStyle labelMediumEmphasized,
    required TypeStyle labelSmallEmphasized,
  }) = _TypescaleThemeData;

  const factory TypescaleThemeData.fallback({
    required TypefaceThemeData typefaceTheme,
  }) = _TypescaleThemeDataFallback;

  @override
  TypeStyle get displayLarge;

  @override
  TypeStyle get displayMedium;

  @override
  TypeStyle get displaySmall;

  @override
  TypeStyle get headlineLarge;

  @override
  TypeStyle get headlineMedium;

  @override
  TypeStyle get headlineSmall;

  @override
  TypeStyle get titleLarge;

  @override
  TypeStyle get titleMedium;

  @override
  TypeStyle get titleSmall;

  @override
  TypeStyle get bodyLarge;

  @override
  TypeStyle get bodyMedium;

  @override
  TypeStyle get bodySmall;

  @override
  TypeStyle get labelLarge;

  @override
  TypeStyle get labelMedium;

  @override
  TypeStyle get labelSmall;

  @override
  TypeStyle get displayLargeEmphasized;

  @override
  TypeStyle get displayMediumEmphasized;

  @override
  TypeStyle get displaySmallEmphasized;

  @override
  TypeStyle get headlineLargeEmphasized;

  @override
  TypeStyle get headlineMediumEmphasized;

  @override
  TypeStyle get headlineSmallEmphasized;

  @override
  TypeStyle get titleLargeEmphasized;

  @override
  TypeStyle get titleMediumEmphasized;

  @override
  TypeStyle get titleSmallEmphasized;

  @override
  TypeStyle get bodyLargeEmphasized;

  @override
  TypeStyle get bodyMediumEmphasized;

  @override
  TypeStyle get bodySmallEmphasized;

  @override
  TypeStyle get labelLargeEmphasized;

  @override
  TypeStyle get labelMediumEmphasized;

  @override
  TypeStyle get labelSmallEmphasized;

  @override
  TypescaleThemeData copyWith({
    covariant TypeStyle? displayLarge,
    covariant TypeStyle? displayMedium,
    covariant TypeStyle? displaySmall,
    covariant TypeStyle? headlineLarge,
    covariant TypeStyle? headlineMedium,
    covariant TypeStyle? headlineSmall,
    covariant TypeStyle? titleLarge,
    covariant TypeStyle? titleMedium,
    covariant TypeStyle? titleSmall,
    covariant TypeStyle? bodyLarge,
    covariant TypeStyle? bodyMedium,
    covariant TypeStyle? bodySmall,
    covariant TypeStyle? labelLarge,
    covariant TypeStyle? labelMedium,
    covariant TypeStyle? labelSmall,
    covariant TypeStyle? displayLargeEmphasized,
    covariant TypeStyle? displayMediumEmphasized,
    covariant TypeStyle? displaySmallEmphasized,
    covariant TypeStyle? headlineLargeEmphasized,
    covariant TypeStyle? headlineMediumEmphasized,
    covariant TypeStyle? headlineSmallEmphasized,
    covariant TypeStyle? titleLargeEmphasized,
    covariant TypeStyle? titleMediumEmphasized,
    covariant TypeStyle? titleSmallEmphasized,
    covariant TypeStyle? bodyLargeEmphasized,
    covariant TypeStyle? bodyMediumEmphasized,
    covariant TypeStyle? bodySmallEmphasized,
    covariant TypeStyle? labelLargeEmphasized,
    covariant TypeStyle? labelMediumEmphasized,
    covariant TypeStyle? labelSmallEmphasized,
  }) =>
      displayLarge != null ||
          displayMedium != null ||
          displaySmall != null ||
          headlineLarge != null ||
          headlineMedium != null ||
          headlineSmall != null ||
          titleLarge != null ||
          titleMedium != null ||
          titleSmall != null ||
          bodyLarge != null ||
          bodyMedium != null ||
          bodySmall != null ||
          labelLarge != null ||
          labelMedium != null ||
          labelSmall != null ||
          displayLargeEmphasized != null ||
          displayMediumEmphasized != null ||
          displaySmallEmphasized != null ||
          headlineLargeEmphasized != null ||
          headlineMediumEmphasized != null ||
          headlineSmallEmphasized != null ||
          titleLargeEmphasized != null ||
          titleMediumEmphasized != null ||
          titleSmallEmphasized != null ||
          bodyLargeEmphasized != null ||
          bodyMediumEmphasized != null ||
          bodySmallEmphasized != null ||
          labelLargeEmphasized != null ||
          labelMediumEmphasized != null ||
          labelSmallEmphasized != null
      ? TypescaleThemeData.from(
          displayLarge: displayLarge ?? this.displayLarge,
          displayMedium: displayMedium ?? this.displayMedium,
          displaySmall: displaySmall ?? this.displaySmall,
          headlineLarge: headlineLarge ?? this.headlineLarge,
          headlineMedium: headlineMedium ?? this.headlineMedium,
          headlineSmall: headlineSmall ?? this.headlineSmall,
          titleLarge: titleLarge ?? this.titleLarge,
          titleMedium: titleMedium ?? this.titleMedium,
          titleSmall: titleSmall ?? this.titleSmall,
          bodyLarge: bodyLarge ?? this.bodyLarge,
          bodyMedium: bodyMedium ?? this.bodyMedium,
          bodySmall: bodySmall ?? this.bodySmall,
          labelLarge: labelLarge ?? this.labelLarge,
          labelMedium: labelMedium ?? this.labelMedium,
          labelSmall: labelSmall ?? this.labelSmall,
          displayLargeEmphasized:
              displayLargeEmphasized ?? this.displayLargeEmphasized,
          displayMediumEmphasized:
              displayMediumEmphasized ?? this.displayMediumEmphasized,
          displaySmallEmphasized:
              displaySmallEmphasized ?? this.displaySmallEmphasized,
          headlineLargeEmphasized:
              headlineLargeEmphasized ?? this.headlineLargeEmphasized,
          headlineMediumEmphasized:
              headlineMediumEmphasized ?? this.headlineMediumEmphasized,
          headlineSmallEmphasized:
              headlineSmallEmphasized ?? this.headlineSmallEmphasized,
          titleLargeEmphasized:
              titleLargeEmphasized ?? this.titleLargeEmphasized,
          titleMediumEmphasized:
              titleMediumEmphasized ?? this.titleMediumEmphasized,
          titleSmallEmphasized:
              titleSmallEmphasized ?? this.titleSmallEmphasized,
          bodyLargeEmphasized: bodyLargeEmphasized ?? this.bodyLargeEmphasized,
          bodyMediumEmphasized:
              bodyMediumEmphasized ?? this.bodyMediumEmphasized,
          bodySmallEmphasized: bodySmallEmphasized ?? this.bodySmallEmphasized,
          labelLargeEmphasized:
              labelLargeEmphasized ?? this.labelLargeEmphasized,
          labelMediumEmphasized:
              labelMediumEmphasized ?? this.labelMediumEmphasized,
          labelSmallEmphasized:
              labelSmallEmphasized ?? this.labelSmallEmphasized,
        )
      : this;

  @override
  TypescaleThemeData mergeWith({
    TypeStylePartial? displayLarge,
    TypeStylePartial? displayMedium,
    TypeStylePartial? displaySmall,
    TypeStylePartial? headlineLarge,
    TypeStylePartial? headlineMedium,
    TypeStylePartial? headlineSmall,
    TypeStylePartial? titleLarge,
    TypeStylePartial? titleMedium,
    TypeStylePartial? titleSmall,
    TypeStylePartial? bodyLarge,
    TypeStylePartial? bodyMedium,
    TypeStylePartial? bodySmall,
    TypeStylePartial? labelLarge,
    TypeStylePartial? labelMedium,
    TypeStylePartial? labelSmall,
    TypeStylePartial? displayLargeEmphasized,
    TypeStylePartial? displayMediumEmphasized,
    TypeStylePartial? displaySmallEmphasized,
    TypeStylePartial? headlineLargeEmphasized,
    TypeStylePartial? headlineMediumEmphasized,
    TypeStylePartial? headlineSmallEmphasized,
    TypeStylePartial? titleLargeEmphasized,
    TypeStylePartial? titleMediumEmphasized,
    TypeStylePartial? titleSmallEmphasized,
    TypeStylePartial? bodyLargeEmphasized,
    TypeStylePartial? bodyMediumEmphasized,
    TypeStylePartial? bodySmallEmphasized,
    TypeStylePartial? labelLargeEmphasized,
    TypeStylePartial? labelMediumEmphasized,
    TypeStylePartial? labelSmallEmphasized,
  }) =>
      displayLarge != null ||
          displayMedium != null ||
          displaySmall != null ||
          headlineLarge != null ||
          headlineMedium != null ||
          headlineSmall != null ||
          titleLarge != null ||
          titleMedium != null ||
          titleSmall != null ||
          bodyLarge != null ||
          bodyMedium != null ||
          bodySmall != null ||
          labelLarge != null ||
          labelMedium != null ||
          labelSmall != null ||
          displayLargeEmphasized != null ||
          displayMediumEmphasized != null ||
          displaySmallEmphasized != null ||
          headlineLargeEmphasized != null ||
          headlineMediumEmphasized != null ||
          headlineSmallEmphasized != null ||
          titleLargeEmphasized != null ||
          titleMediumEmphasized != null ||
          titleSmallEmphasized != null ||
          bodyLargeEmphasized != null ||
          bodyMediumEmphasized != null ||
          bodySmallEmphasized != null ||
          labelLargeEmphasized != null ||
          labelMediumEmphasized != null ||
          labelSmallEmphasized != null
      ? TypescaleThemeData.from(
          displayLarge: this.displayLarge.merge(displayLarge),
          displayMedium: this.displayMedium.merge(displayMedium),
          displaySmall: this.displaySmall.merge(displaySmall),
          headlineLarge: this.headlineLarge.merge(headlineLarge),
          headlineMedium: this.headlineMedium.merge(headlineMedium),
          headlineSmall: this.headlineSmall.merge(headlineSmall),
          titleLarge: this.titleLarge.merge(titleLarge),
          titleMedium: this.titleMedium.merge(titleMedium),
          titleSmall: this.titleSmall.merge(titleSmall),
          bodyLarge: this.bodyLarge.merge(bodyLarge),
          bodyMedium: this.bodyMedium.merge(bodyMedium),
          bodySmall: this.bodySmall.merge(bodySmall),
          labelLarge: this.labelLarge.merge(labelLarge),
          labelMedium: this.labelMedium.merge(labelMedium),
          labelSmall: this.labelSmall.merge(labelSmall),
          displayLargeEmphasized: this.displayLargeEmphasized.merge(
            displayLargeEmphasized,
          ),
          displayMediumEmphasized: this.displayMediumEmphasized.merge(
            displayMediumEmphasized,
          ),
          displaySmallEmphasized: this.displaySmallEmphasized.merge(
            displaySmallEmphasized,
          ),
          headlineLargeEmphasized: this.headlineLargeEmphasized.merge(
            headlineLargeEmphasized,
          ),
          headlineMediumEmphasized: this.headlineMediumEmphasized.merge(
            headlineMediumEmphasized,
          ),
          headlineSmallEmphasized: this.headlineSmallEmphasized.merge(
            headlineSmallEmphasized,
          ),
          titleLargeEmphasized: this.titleLargeEmphasized.merge(
            titleLargeEmphasized,
          ),
          titleMediumEmphasized: this.titleMediumEmphasized.merge(
            titleMediumEmphasized,
          ),
          titleSmallEmphasized: this.titleSmallEmphasized.merge(
            titleSmallEmphasized,
          ),
          bodyLargeEmphasized: this.bodyLargeEmphasized.merge(
            bodyLargeEmphasized,
          ),
          bodyMediumEmphasized: this.bodyMediumEmphasized.merge(
            bodyMediumEmphasized,
          ),
          bodySmallEmphasized: this.bodySmallEmphasized.merge(
            bodySmallEmphasized,
          ),
          labelLargeEmphasized: this.labelLargeEmphasized.merge(
            labelLargeEmphasized,
          ),
          labelMediumEmphasized: this.labelMediumEmphasized.merge(
            labelMediumEmphasized,
          ),
          labelSmallEmphasized: this.labelSmallEmphasized.merge(
            labelSmallEmphasized,
          ),
        )
      : this;

  @override
  TypescaleThemeData merge(TypescaleThemeDataPartial? other) => other != null
      ? mergeWith(
          displayLarge: other.displayLarge,
          displayMedium: other.displayMedium,
          displaySmall: other.displaySmall,
          headlineLarge: other.headlineLarge,
          headlineMedium: other.headlineMedium,
          headlineSmall: other.headlineSmall,
          titleLarge: other.titleLarge,
          titleMedium: other.titleMedium,
          titleSmall: other.titleSmall,
          bodyLarge: other.bodyLarge,
          bodyMedium: other.bodyMedium,
          bodySmall: other.bodySmall,
          labelLarge: other.labelLarge,
          labelMedium: other.labelMedium,
          labelSmall: other.labelSmall,
          displayLargeEmphasized: other.displayLargeEmphasized,
          displayMediumEmphasized: other.displayMediumEmphasized,
          displaySmallEmphasized: other.displaySmallEmphasized,
          headlineLargeEmphasized: other.headlineLargeEmphasized,
          headlineMediumEmphasized: other.headlineMediumEmphasized,
          headlineSmallEmphasized: other.headlineSmallEmphasized,
          titleLargeEmphasized: other.titleLargeEmphasized,
          titleMediumEmphasized: other.titleMediumEmphasized,
          titleSmallEmphasized: other.titleSmallEmphasized,
          bodyLargeEmphasized: other.bodyLargeEmphasized,
          bodyMediumEmphasized: other.bodyMediumEmphasized,
          bodySmallEmphasized: other.bodySmallEmphasized,
          labelLargeEmphasized: other.labelLargeEmphasized,
          labelMediumEmphasized: other.labelMediumEmphasized,
          labelSmallEmphasized: other.labelSmallEmphasized,
        )
      : this;

  @override
  // ignore: must_call_super
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty<TypeStyle>("displayLarge", displayLarge))
      ..add(DiagnosticsProperty<TypeStyle>("displayMedium", displayMedium))
      ..add(DiagnosticsProperty<TypeStyle>("displaySmall", displaySmall))
      ..add(DiagnosticsProperty<TypeStyle>("headlineLarge", headlineLarge))
      ..add(DiagnosticsProperty<TypeStyle>("headlineMedium", headlineMedium))
      ..add(DiagnosticsProperty<TypeStyle>("headlineSmall", headlineSmall))
      ..add(DiagnosticsProperty<TypeStyle>("titleLarge", titleLarge))
      ..add(DiagnosticsProperty<TypeStyle>("titleMedium", titleMedium))
      ..add(DiagnosticsProperty<TypeStyle>("titleSmall", titleSmall))
      ..add(DiagnosticsProperty<TypeStyle>("bodyLarge", bodyLarge))
      ..add(DiagnosticsProperty<TypeStyle>("bodyMedium", bodyMedium))
      ..add(DiagnosticsProperty<TypeStyle>("bodySmall", bodySmall))
      ..add(DiagnosticsProperty<TypeStyle>("labelLarge", labelLarge))
      ..add(DiagnosticsProperty<TypeStyle>("labelMedium", labelMedium))
      ..add(DiagnosticsProperty<TypeStyle>("labelSmall", labelSmall))
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "displayLargeEmphasized",
          displayLargeEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "displayMediumEmphasized",
          displayMediumEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "displaySmallEmphasized",
          displaySmallEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "headlineLargeEmphasized",
          headlineLargeEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "headlineMediumEmphasized",
          headlineMediumEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "headlineSmallEmphasized",
          headlineSmallEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "titleLargeEmphasized",
          titleLargeEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "titleMediumEmphasized",
          titleMediumEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "titleSmallEmphasized",
          titleSmallEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "bodyLargeEmphasized",
          bodyLargeEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "bodyMediumEmphasized",
          bodyMediumEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "bodySmallEmphasized",
          bodySmallEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "labelLargeEmphasized",
          labelLargeEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "labelMediumEmphasized",
          labelMediumEmphasized,
        ),
      )
      ..add(
        DiagnosticsProperty<TypeStyle>(
          "labelSmallEmphasized",
          labelSmallEmphasized,
        ),
      );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is TypescaleThemeData &&
          displayLarge == other.displayLarge &&
          displayMedium == other.displayMedium &&
          displaySmall == other.displaySmall &&
          headlineLarge == other.headlineLarge &&
          headlineMedium == other.headlineMedium &&
          headlineSmall == other.headlineSmall &&
          titleLarge == other.titleLarge &&
          titleMedium == other.titleMedium &&
          titleSmall == other.titleSmall &&
          bodyLarge == other.bodyLarge &&
          bodyMedium == other.bodyMedium &&
          bodySmall == other.bodySmall &&
          labelLarge == other.labelLarge &&
          labelMedium == other.labelMedium &&
          labelSmall == other.labelSmall &&
          displayLargeEmphasized == other.displayLargeEmphasized &&
          displayMediumEmphasized == other.displayMediumEmphasized &&
          displaySmallEmphasized == other.displaySmallEmphasized &&
          headlineLargeEmphasized == other.headlineLargeEmphasized &&
          headlineMediumEmphasized == other.headlineMediumEmphasized &&
          headlineSmallEmphasized == other.headlineSmallEmphasized &&
          titleLargeEmphasized == other.titleLargeEmphasized &&
          titleMediumEmphasized == other.titleMediumEmphasized &&
          titleSmallEmphasized == other.titleSmallEmphasized &&
          bodyLargeEmphasized == other.bodyLargeEmphasized &&
          bodyMediumEmphasized == other.bodyMediumEmphasized &&
          bodySmallEmphasized == other.bodySmallEmphasized &&
          labelLargeEmphasized == other.labelLargeEmphasized &&
          labelMediumEmphasized == other.labelMediumEmphasized &&
          labelSmallEmphasized == other.labelSmallEmphasized;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    displayLarge,
    displayMedium,
    displaySmall,
    headlineLarge,
    headlineMedium,
    headlineSmall,
    titleLarge,
    titleMedium,
    titleSmall,
    bodyLarge,
    bodyMedium,
    bodySmall,
    labelLarge,
    labelMedium,
    labelSmall,
    displayLargeEmphasized,
    displayMediumEmphasized,
    displaySmallEmphasized,
    Object.hash(
      headlineLargeEmphasized,
      headlineMediumEmphasized,
      headlineSmallEmphasized,
      titleLargeEmphasized,
      titleMediumEmphasized,
      titleSmallEmphasized,
      bodyLargeEmphasized,
      bodyMediumEmphasized,
      bodySmallEmphasized,
      labelLargeEmphasized,
      labelMediumEmphasized,
      labelSmallEmphasized,
    ),
  );
}

@immutable
class _TypescaleThemeData extends TypescaleThemeData {
  const _TypescaleThemeData({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.displayLargeEmphasized,
    required this.displayMediumEmphasized,
    required this.displaySmallEmphasized,
    required this.headlineLargeEmphasized,
    required this.headlineMediumEmphasized,
    required this.headlineSmallEmphasized,
    required this.titleLargeEmphasized,
    required this.titleMediumEmphasized,
    required this.titleSmallEmphasized,
    required this.bodyLargeEmphasized,
    required this.bodyMediumEmphasized,
    required this.bodySmallEmphasized,
    required this.labelLargeEmphasized,
    required this.labelMediumEmphasized,
    required this.labelSmallEmphasized,
  });

  @override
  final TypeStyle displayLarge;

  @override
  final TypeStyle displayMedium;

  @override
  final TypeStyle displaySmall;

  @override
  final TypeStyle headlineLarge;

  @override
  final TypeStyle headlineMedium;

  @override
  final TypeStyle headlineSmall;

  @override
  final TypeStyle titleLarge;

  @override
  final TypeStyle titleMedium;

  @override
  final TypeStyle titleSmall;

  @override
  final TypeStyle bodyLarge;

  @override
  final TypeStyle bodyMedium;

  @override
  final TypeStyle bodySmall;

  @override
  final TypeStyle labelLarge;

  @override
  final TypeStyle labelMedium;

  @override
  final TypeStyle labelSmall;

  @override
  final TypeStyle displayLargeEmphasized;

  @override
  final TypeStyle displayMediumEmphasized;

  @override
  final TypeStyle displaySmallEmphasized;

  @override
  final TypeStyle headlineLargeEmphasized;

  @override
  final TypeStyle headlineMediumEmphasized;

  @override
  final TypeStyle headlineSmallEmphasized;

  @override
  final TypeStyle titleLargeEmphasized;

  @override
  final TypeStyle titleMediumEmphasized;

  @override
  final TypeStyle titleSmallEmphasized;

  @override
  final TypeStyle bodyLargeEmphasized;

  @override
  final TypeStyle bodyMediumEmphasized;

  @override
  final TypeStyle bodySmallEmphasized;

  @override
  final TypeStyle labelLargeEmphasized;

  @override
  final TypeStyle labelMediumEmphasized;

  @override
  final TypeStyle labelSmallEmphasized;
}

@immutable
class _TypescaleThemeDataFallback extends TypescaleThemeData {
  const _TypescaleThemeDataFallback({required TypefaceThemeData typefaceTheme})
    : _typefaceTheme = typefaceTheme;

  final TypefaceThemeData _typefaceTheme;

  TypeStyle _buildTypeStyle({
    required List<String> font,
    required double weight,
    required double size,
    required double lineHeight,
    required double tracking,
  }) => TypeStyle.from(
    font: font,
    weight: weight,
    size: size,
    lineHeight: lineHeight,
    tracking: tracking,
    wght: weight,
    grad: 0.0,
    wdth: 100.0,
    rond: 0.0,
    opsz: size,
    crsv: 0.0,
    slnt: 0.0,
    fill: 0.0,
    hexp: 0.0,
  );

  @override
  TypeStyle get displayLarge => _buildTypeStyle(
    font: _typefaceTheme.brand,
    weight: _typefaceTheme.weightRegular,
    size: 57.0,
    lineHeight: 64.0,
    tracking: -0.25,
  );

  @override
  TypeStyle get displayMedium => _buildTypeStyle(
    font: _typefaceTheme.brand,
    weight: _typefaceTheme.weightRegular,
    size: 45.0,
    lineHeight: 52.0,
    tracking: 0.0,
  );

  @override
  TypeStyle get displaySmall => _buildTypeStyle(
    font: _typefaceTheme.brand,
    weight: _typefaceTheme.weightRegular,
    size: 36.0,
    lineHeight: 44.0,
    tracking: 0.0,
  );

  @override
  TypeStyle get headlineLarge => _buildTypeStyle(
    font: _typefaceTheme.brand,
    weight: _typefaceTheme.weightRegular,
    size: 32.0,
    lineHeight: 40.0,
    tracking: 0.0,
  );

  @override
  TypeStyle get headlineMedium => _buildTypeStyle(
    font: _typefaceTheme.brand,
    weight: _typefaceTheme.weightRegular,
    size: 28.0,
    lineHeight: 36.0,
    tracking: 0.0,
  );

  @override
  TypeStyle get headlineSmall => _buildTypeStyle(
    font: _typefaceTheme.brand,
    weight: _typefaceTheme.weightRegular,
    size: 24.0,
    lineHeight: 32.0,
    tracking: 0.0,
  );

  @override
  TypeStyle get titleLarge => _buildTypeStyle(
    font: _typefaceTheme.brand,
    weight: _typefaceTheme.weightRegular,
    size: 22.0,
    lineHeight: 28.0,
    tracking: 0.0,
  );

  @override
  TypeStyle get titleMedium => _buildTypeStyle(
    font: _typefaceTheme.plain,
    weight: _typefaceTheme.weightMedium,
    size: 16.0,
    lineHeight: 24.0,
    tracking: 0.15,
  );

  @override
  TypeStyle get titleSmall => _buildTypeStyle(
    font: _typefaceTheme.plain,
    weight: _typefaceTheme.weightMedium,
    size: 14.0,
    lineHeight: 20.0,
    tracking: 0.1,
  );

  @override
  TypeStyle get bodyLarge => _buildTypeStyle(
    font: _typefaceTheme.plain,
    weight: _typefaceTheme.weightRegular,
    size: 16.0,
    lineHeight: 24.0,
    tracking: 0.5,
  );

  @override
  TypeStyle get bodyMedium => _buildTypeStyle(
    font: _typefaceTheme.plain,
    weight: _typefaceTheme.weightRegular,
    size: 14.0,
    lineHeight: 20.0,
    tracking: 0.25,
  );

  @override
  TypeStyle get bodySmall => _buildTypeStyle(
    font: _typefaceTheme.plain,
    weight: _typefaceTheme.weightRegular,
    size: 12.0,
    lineHeight: 16.0,
    tracking: 0.4,
  );

  @override
  TypeStyle get labelLarge => _buildTypeStyle(
    font: _typefaceTheme.plain,
    weight: _typefaceTheme.weightMedium,
    size: 14.0,
    lineHeight: 20.0,
    tracking: 0.1,
  );

  @override
  TypeStyle get labelMedium => _buildTypeStyle(
    font: _typefaceTheme.plain,
    weight: _typefaceTheme.weightMedium,
    size: 12.0,
    lineHeight: 16.0,
    tracking: 0.5,
  );

  @override
  TypeStyle get labelSmall => _buildTypeStyle(
    font: _typefaceTheme.plain,
    weight: _typefaceTheme.weightMedium,
    size: 11.0,
    lineHeight: 16.0,
    tracking: 0.5,
  );

  @override
  TypeStyle get displayLargeEmphasized =>
      displayLarge.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get displayMediumEmphasized =>
      displayMedium.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get displaySmallEmphasized =>
      displaySmall.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get headlineLargeEmphasized =>
      headlineLarge.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get headlineMediumEmphasized =>
      headlineMedium.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get headlineSmallEmphasized =>
      headlineSmall.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get titleLargeEmphasized =>
      titleLarge.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get titleMediumEmphasized =>
      titleMedium.copyWith(weight: _typefaceTheme.weightBold, wght: 600.0);

  @override
  TypeStyle get titleSmallEmphasized =>
      titleSmall.copyWith(weight: _typefaceTheme.weightBold, wght: 600.0);

  @override
  TypeStyle get bodyLargeEmphasized =>
      bodyLarge.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get bodyMediumEmphasized =>
      bodyMedium.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get bodySmallEmphasized =>
      bodySmall.copyWith(weight: _typefaceTheme.weightMedium, wght: 500.0);

  @override
  TypeStyle get labelLargeEmphasized =>
      labelLarge.copyWith(weight: _typefaceTheme.weightBold, wght: 600.0);

  @override
  TypeStyle get labelMediumEmphasized =>
      labelMedium.copyWith(weight: _typefaceTheme.weightBold, wght: 600.0);

  @override
  TypeStyle get labelSmallEmphasized =>
      labelSmall.copyWith(weight: _typefaceTheme.weightBold, wght: 600.0);
}

class TypescaleTheme extends InheritedTheme {
  const TypescaleTheme({super.key, required this.data, required super.child});

  final TypescaleThemeData data;

  @override
  bool updateShouldNotify(TypescaleTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      TypescaleTheme(data: data, child: child);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TypescaleThemeData>("data", data));
  }

  static Widget merge({
    Key? key,
    required TypescaleThemeDataPartial data,
    required Widget child,
  }) => Builder(
    builder: (context) =>
        TypescaleTheme(key: key, data: of(context).merge(data), child: child),
  );

  static TypescaleThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TypescaleTheme>()?.data;

  static TypescaleThemeData of(BuildContext context) =>
      maybeOf(context) ??
      TypescaleThemeData.fallback(typefaceTheme: TypefaceTheme.of(context));
}
