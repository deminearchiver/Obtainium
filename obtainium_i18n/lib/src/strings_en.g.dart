///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element

class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           );

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => Translations(meta: meta ?? this.$meta);

  // Translations

  /// en: 'Obtainium'
  String get obtainium => 'Obtainium';

  late final TranslationsNavigationV1En navigationV1 =
      TranslationsNavigationV1En.internal(_root);
}

// Path: navigationV1
class TranslationsNavigationV1En {
  TranslationsNavigationV1En.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsNavigationV1AppsEn apps =
      TranslationsNavigationV1AppsEn.internal(_root);
  late final TranslationsNavigationV1AddAppEn addApp =
      TranslationsNavigationV1AddAppEn.internal(_root);
  late final TranslationsNavigationV1ImportExportEn importExport =
      TranslationsNavigationV1ImportExportEn.internal(_root);
  late final TranslationsNavigationV1SettingsEn settings =
      TranslationsNavigationV1SettingsEn.internal(_root);
}

// Path: navigationV1.apps
class TranslationsNavigationV1AppsEn {
  TranslationsNavigationV1AppsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Apps'
  String get label => 'Apps';

  /// en: 'Apps'
  String get title => 'Apps';
}

// Path: navigationV1.addApp
class TranslationsNavigationV1AddAppEn {
  TranslationsNavigationV1AddAppEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Add app'
  String get label => 'Add app';

  /// en: 'Add app'
  String get title => 'Add app';
}

// Path: navigationV1.importExport
class TranslationsNavigationV1ImportExportEn {
  TranslationsNavigationV1ImportExportEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Import / export'
  String get label => 'Import / export';

  /// en: 'Import / export'
  String get title => 'Import / export';
}

// Path: navigationV1.settings
class TranslationsNavigationV1SettingsEn {
  TranslationsNavigationV1SettingsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Settings'
  String get label => 'Settings';

  /// en: 'Settings'
  String get title => 'Settings';
}
