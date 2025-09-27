// Exposes functions used to save/load app settings

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:obtainium/flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obtainium/app_sources/github.dart';
import 'package:obtainium/main.dart';
import 'package:obtainium/providers/apps_provider.dart';
import 'package:obtainium/providers/source_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/util/legacy_to_async_migration_util.dart';
import 'package:shared_storage/shared_storage.dart' as saf;

final String obtainiumTempId = 'imranr98_obtainium_${GitHub().hosts[0]}';
const String obtainiumId = 'dev.imranr.obtainium';
const String obtainiumUrl = 'https://github.com/ImranR98/Obtainium';
const Color obtainiumThemeColor = Color(0xFF6438B5);

const String _migration1CompletedKey = "migration1Completed";

enum ThemeSettings { system, light, dark }

enum SortColumnSettings { added, nameAuthor, authorName, releaseDate }

enum SortOrderSettings { ascending, descending }

class SettingsProvider with ChangeNotifier {
  SettingsProvider._({
    required SharedPreferencesWithCache prefsWithCache,
    required String defaultAppDir,
  }) : _prefsWithCache = prefsWithCache,
       _defaultAppDir = defaultAppDir {
    prefsWithCache.reloadCache();
  }

  static SettingsProvider? _instance;

  static Future<SettingsProvider> ensureInitialized() async {
    SettingsProvider? instance = _instance;
    if (instance != null) {
      return instance;
    } else {
      // Options should be shared across all instances
      const sharedPreferencesOptions = SharedPreferencesOptions();

      // First we migrate from legacy SharedPreferences
      await migrateLegacySharedPreferencesToSharedPreferencesAsyncIfNecessary(
        legacySharedPreferencesInstance: await SharedPreferences.getInstance(),
        sharedPreferencesAsyncOptions: sharedPreferencesOptions,
        migrationCompletedKey: _migration1CompletedKey,
      );

      // By setting a local variable way we utilitize Dart's null safety
      instance = SettingsProvider._(
        // create() includes a call to reloadCache already, no need to call it
        prefsWithCache: await SharedPreferencesWithCache.create(
          sharedPreferencesOptions: sharedPreferencesOptions,
          cacheOptions: const SharedPreferencesWithCacheOptions(),
        ),
        defaultAppDir: (await getExternalStorageDirectory())!.path,
      );

      // Don't forget to update the actual field
      _instance = instance;

      // Return local (non-null) variable
      return instance;
    }
  }

  Future<void> reload() async {
    await _prefsWithCache.reloadCache();
    _defaultAppDir = (await getExternalStorageDirectory())!.path;
    notifyListeners();
  }

  final SharedPreferencesWithCache _prefsWithCache;
  SharedPreferencesWithCache get prefsWithCache => _prefsWithCache;

  String _defaultAppDir;
  String get defaultAppDir => _defaultAppDir;

  bool _justStarted = true;

  static const String sourceUrl = 'https://github.com/ImranR98/Obtainium';

  // bool get useSystemFont {
  //   return prefsWithCache.getBool('useSystemFont') ?? false;
  // }

  // set useSystemFont(bool useSystemFont) {
  //   prefsWithCache.setBool('useSystemFont', useSystemFont);
  //   notifyListeners();
  // }

  bool get useShizuku {
    return prefsWithCache.getBool('useShizuku') ?? false;
  }

  set useShizuku(bool useShizuku) {
    prefsWithCache.setBool('useShizuku', useShizuku);
    notifyListeners();
  }

  ThemeSettings get theme {
    return ThemeSettings.values[prefsWithCache.getInt('theme') ??
        ThemeSettings.system.index];
  }

  set theme(ThemeSettings t) {
    prefsWithCache.setInt('theme', t.index);
    notifyListeners();
  }

  Color get themeColor {
    int? colorCode = prefsWithCache.getInt('themeColor');
    return (colorCode != null) ? Color(colorCode) : obtainiumThemeColor;
  }

  set themeColor(Color themeColor) {
    prefsWithCache.setInt('themeColor', themeColor.toARGB32());
    notifyListeners();
  }

  bool get useMaterialYou {
    return prefsWithCache.getBool('useMaterialYou') ?? true;
  }

  set useMaterialYou(bool useMaterialYou) {
    prefsWithCache.setBool('useMaterialYou', useMaterialYou);
    notifyListeners();
  }

  // TODO: decide if useBlackTheme shall be reintroduced
  // bool get useBlackTheme {
  //   return prefsWithCache.getBool('useBlackTheme') ?? false;
  // }

  // set useBlackTheme(bool useBlackTheme) {
  //   prefsWithCache.setBool('useBlackTheme', useBlackTheme);
  //   notifyListeners();
  // }

  int get updateInterval {
    return prefsWithCache.getInt('updateInterval') ?? 360;
  }

  set updateInterval(int min) {
    prefsWithCache.setInt('updateInterval', min);
    notifyListeners();
  }

  double get updateIntervalSliderVal {
    return prefsWithCache.getDouble('updateIntervalSliderVal') ?? 6.0;
  }

  set updateIntervalSliderVal(double val) {
    prefsWithCache.setDouble('updateIntervalSliderVal', val);
    notifyListeners();
  }

  bool get checkOnStart {
    return prefsWithCache.getBool('checkOnStart') ?? false;
  }

  set checkOnStart(bool checkOnStart) {
    prefsWithCache.setBool('checkOnStart', checkOnStart);
    notifyListeners();
  }

  SortColumnSettings get sortColumn {
    return SortColumnSettings.values[prefsWithCache.getInt('sortColumn') ??
        SortColumnSettings.nameAuthor.index];
  }

  set sortColumn(SortColumnSettings s) {
    prefsWithCache.setInt('sortColumn', s.index);
    notifyListeners();
  }

  SortOrderSettings get sortOrder {
    return SortOrderSettings.values[prefsWithCache.getInt('sortOrder') ??
        SortOrderSettings.ascending.index];
  }

  set sortOrder(SortOrderSettings s) {
    prefsWithCache.setInt('sortOrder', s.index);
    notifyListeners();
  }

  bool checkAndFlipFirstRun() {
    bool result = prefsWithCache.getBool('firstRun') ?? true;
    if (result) {
      prefsWithCache.setBool('firstRun', false);
    }
    return result;
  }

  bool get welcomeShown {
    return prefsWithCache.getBool('welcomeShown') ?? false;
  }

  set welcomeShown(bool welcomeShown) {
    prefsWithCache.setBool('welcomeShown', welcomeShown);
    notifyListeners();
  }

  bool checkJustStarted() {
    if (_justStarted) {
      _justStarted = false;
      return true;
    }
    return false;
  }

  Future<bool> getInstallPermission({bool enforce = false}) async {
    while (!(await Permission.requestInstallPackages.isGranted)) {
      // Explicit request as InstallPlugin request sometimes bugged
      Fluttertoast.showToast(
        msg: tr('pleaseAllowInstallPerm'),
        toastLength: Toast.LENGTH_LONG,
      );
      if ((await Permission.requestInstallPackages.request()) ==
          PermissionStatus.granted) {
        return true;
      }
      if (!enforce) {
        return false;
      }
    }
    return true;
  }

  bool get showAppWebpage {
    return prefsWithCache.getBool('showAppWebpage') ?? false;
  }

  set showAppWebpage(bool show) {
    prefsWithCache.setBool('showAppWebpage', show);
    notifyListeners();
  }

  bool get pinUpdates {
    return prefsWithCache.getBool('pinUpdates') ?? true;
  }

  set pinUpdates(bool show) {
    prefsWithCache.setBool('pinUpdates', show);
    notifyListeners();
  }

  bool get buryNonInstalled {
    return prefsWithCache.getBool('buryNonInstalled') ?? false;
  }

  set buryNonInstalled(bool show) {
    prefsWithCache.setBool('buryNonInstalled', show);
    notifyListeners();
  }

  bool get groupByCategory {
    return prefsWithCache.getBool('groupByCategory') ?? false;
  }

  set groupByCategory(bool show) {
    prefsWithCache.setBool('groupByCategory', show);
    notifyListeners();
  }

  bool get hideTrackOnlyWarning {
    return prefsWithCache.getBool('hideTrackOnlyWarning') ?? false;
  }

  set hideTrackOnlyWarning(bool show) {
    prefsWithCache.setBool('hideTrackOnlyWarning', show);
    notifyListeners();
  }

  bool get hideAPKOriginWarning {
    return prefsWithCache.getBool('hideAPKOriginWarning') ?? false;
  }

  set hideAPKOriginWarning(bool show) {
    prefsWithCache.setBool('hideAPKOriginWarning', show);
    notifyListeners();
  }

  String? getSettingString(String settingId) {
    String? str = prefsWithCache.getString(settingId);
    return str?.isNotEmpty == true ? str : null;
  }

  void setSettingString(String settingId, String value) {
    prefsWithCache.setString(settingId, value);
    notifyListeners();
  }

  bool? getSettingBool(String settingId) {
    return prefsWithCache.getBool(settingId) ?? false;
  }

  void setSettingBool(String settingId, bool value) {
    prefsWithCache.setBool(settingId, value);
    notifyListeners();
  }

  Map<String, int> get categories => Map<String, int>.from(
    jsonDecode(prefsWithCache.getString('categories') ?? '{}'),
  );

  void setCategories(Map<String, int> cats, {AppsProvider? appsProvider}) {
    if (appsProvider != null) {
      List<App> changedApps = appsProvider
          .getAppValues()
          .map((a) {
            var n1 = a.app.categories.length;
            a.app.categories.removeWhere((c) => !cats.keys.contains(c));
            return n1 > a.app.categories.length ? a.app : null;
          })
          .where((element) => element != null)
          .map((e) => e as App)
          .toList();
      if (changedApps.isNotEmpty) {
        appsProvider.saveApps(changedApps);
      }
    }
    prefsWithCache.setString('categories', jsonEncode(cats));
    notifyListeners();
  }

  Locale? get forcedLocale {
    var flSegs = prefsWithCache.getString('forcedLocale')?.split('-');
    var fl = flSegs != null && flSegs.isNotEmpty
        ? Locale(flSegs[0], flSegs.length > 1 ? flSegs[1] : null)
        : null;
    var set = supportedLocales.where((element) => element.key == fl).isNotEmpty
        ? fl
        : null;
    return set;
  }

  set forcedLocale(Locale? fl) {
    if (fl == null) {
      prefsWithCache.remove('forcedLocale');
    } else if (supportedLocales
        .where((element) => element.key == fl)
        .isNotEmpty) {
      prefsWithCache.setString('forcedLocale', fl.toLanguageTag());
    }
    notifyListeners();
  }

  bool setEqual(Set<String> a, Set<String> b) =>
      a.length == b.length && a.union(b).length == a.length;

  void resetLocaleSafe(BuildContext context) {
    if (context.supportedLocales.contains(context.deviceLocale)) {
      context.resetLocale();
    } else {
      context.setLocale(context.fallbackLocale!);
      context.deleteSaveLocale();
    }
  }

  bool get removeOnExternalUninstall {
    return prefsWithCache.getBool('removeOnExternalUninstall') ?? false;
  }

  set removeOnExternalUninstall(bool show) {
    prefsWithCache.setBool('removeOnExternalUninstall', show);
    notifyListeners();
  }

  bool get checkUpdateOnDetailPage {
    return prefsWithCache.getBool('checkUpdateOnDetailPage') ?? true;
  }

  set checkUpdateOnDetailPage(bool show) {
    prefsWithCache.setBool('checkUpdateOnDetailPage', show);
    notifyListeners();
  }

  // TODO: uncomment when transitions are reintroduced
  // bool get disablePageTransitions {
  //   return prefs?.getBool('disablePageTransitions') ?? false;
  // }
  // set disablePageTransitions(bool show) {
  //   prefs?.setBool('disablePageTransitions', show);
  //   notifyListeners();
  // }
  // bool get reversePageTransitions {
  //   return prefs?.getBool('reversePageTransitions') ?? false;
  // }
  // set reversePageTransitions(bool show) {
  //   prefs?.setBool('reversePageTransitions', show);
  //   notifyListeners();
  // }

  bool get enableBackgroundUpdates {
    return prefsWithCache.getBool('enableBackgroundUpdates') ?? true;
  }

  set enableBackgroundUpdates(bool val) {
    prefsWithCache.setBool('enableBackgroundUpdates', val);
    notifyListeners();
  }

  bool get bgUpdatesOnWiFiOnly {
    return prefsWithCache.getBool('bgUpdatesOnWiFiOnly') ?? false;
  }

  set bgUpdatesOnWiFiOnly(bool val) {
    prefsWithCache.setBool('bgUpdatesOnWiFiOnly', val);
    notifyListeners();
  }

  bool get bgUpdatesWhileChargingOnly {
    return prefsWithCache.getBool('bgUpdatesWhileChargingOnly') ?? false;
  }

  set bgUpdatesWhileChargingOnly(bool val) {
    prefsWithCache.setBool('bgUpdatesWhileChargingOnly', val);
    notifyListeners();
  }

  DateTime get lastCompletedBGCheckTime {
    int? temp = prefsWithCache.getInt('lastCompletedBGCheckTime');
    return temp != null
        ? DateTime.fromMillisecondsSinceEpoch(temp)
        : DateTime.fromMillisecondsSinceEpoch(0);
  }

  set lastCompletedBGCheckTime(DateTime val) {
    prefsWithCache.setInt(
      'lastCompletedBGCheckTime',
      val.millisecondsSinceEpoch,
    );
    notifyListeners();
  }

  bool get showDebugOpts {
    return prefsWithCache.getBool('showDebugOpts') ?? false;
  }

  set showDebugOpts(bool val) {
    prefsWithCache.setBool('showDebugOpts', val);
    notifyListeners();
  }

  bool get highlightTouchTargets {
    return prefsWithCache.getBool('highlightTouchTargets') ?? false;
  }

  set highlightTouchTargets(bool val) {
    prefsWithCache.setBool('highlightTouchTargets', val);
    notifyListeners();
  }

  Future<Uri?> getExportDir() async {
    var uriString = prefsWithCache.getString('exportDir');
    if (uriString != null) {
      Uri? uri = Uri.parse(uriString);
      if (!(await saf.canRead(uri) ?? false) ||
          !(await saf.canWrite(uri) ?? false)) {
        uri = null;
        prefsWithCache.remove('exportDir');
        notifyListeners();
      }
      return uri;
    } else {
      return null;
    }
  }

  Future<void> pickExportDir({bool remove = false}) async {
    var existingSAFPerms = (await saf.persistedUriPermissions()) ?? [];
    var currentOneWayDataSyncDir = await getExportDir();
    Uri? newOneWayDataSyncDir;
    if (!remove) {
      newOneWayDataSyncDir = (await saf.openDocumentTree());
    }
    if (currentOneWayDataSyncDir?.path != newOneWayDataSyncDir?.path) {
      if (newOneWayDataSyncDir == null) {
        prefsWithCache.remove('exportDir');
      } else {
        prefsWithCache.setString('exportDir', newOneWayDataSyncDir.toString());
      }
      notifyListeners();
    }
    for (var e in existingSAFPerms) {
      await saf.releasePersistableUriPermission(e.uri);
    }
  }

  bool get autoExportOnChanges {
    return prefsWithCache.getBool('autoExportOnChanges') ?? false;
  }

  set autoExportOnChanges(bool val) {
    prefsWithCache.setBool('autoExportOnChanges', val);
    notifyListeners();
  }

  bool get onlyCheckInstalledOrTrackOnlyApps {
    return prefsWithCache.getBool('onlyCheckInstalledOrTrackOnlyApps') ?? false;
  }

  set onlyCheckInstalledOrTrackOnlyApps(bool val) {
    prefsWithCache.setBool('onlyCheckInstalledOrTrackOnlyApps', val);
    notifyListeners();
  }

  int get exportSettings {
    try {
      return prefsWithCache.getInt('exportSettings') ??
          1; // 0 for no, 1 for yes but no secrets, 2 for everything
    } catch (e) {
      var val = prefsWithCache.getBool('exportSettings') == true ? 1 : 0;
      prefsWithCache.setInt('exportSettings', val);
      return val;
    }
  }

  set exportSettings(int val) {
    prefsWithCache.setInt('exportSettings', val > 2 || val < 0 ? 1 : val);
    notifyListeners();
  }

  bool get parallelDownloads {
    return prefsWithCache.getBool('parallelDownloads') ?? false;
  }

  set parallelDownloads(bool val) {
    prefsWithCache.setBool('parallelDownloads', val);
    notifyListeners();
  }

  List<String> get searchDeselected {
    return prefsWithCache.getStringList('searchDeselected') ??
        SourceProvider().sources.map((s) => s.name).toList();
  }

  set searchDeselected(List<String> list) {
    prefsWithCache.setStringList('searchDeselected', list);
    notifyListeners();
  }

  bool get beforeNewInstallsShareToAppVerifier {
    return prefsWithCache.getBool('beforeNewInstallsShareToAppVerifier') ??
        true;
  }

  set beforeNewInstallsShareToAppVerifier(bool val) {
    prefsWithCache.setBool('beforeNewInstallsShareToAppVerifier', val);
    notifyListeners();
  }

  bool get shizukuPretendToBeGooglePlay {
    return prefsWithCache.getBool('shizukuPretendToBeGooglePlay') ?? false;
  }

  set shizukuPretendToBeGooglePlay(bool val) {
    prefsWithCache.setBool('shizukuPretendToBeGooglePlay', val);
    notifyListeners();
  }

  bool get useFGService {
    return prefsWithCache.getBool('useFGService') ?? false;
  }

  set useFGService(bool val) {
    prefsWithCache.setBool('useFGService', val);
    notifyListeners();
  }
}
