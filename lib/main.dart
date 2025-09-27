import 'dart:io';

import 'package:obtainium/flutter.dart';
import 'package:obtainium/pages/home.dart';
import 'package:obtainium/providers/apps_provider.dart';
import 'package:obtainium/providers/logs_provider.dart';
import 'package:obtainium/providers/notifications_provider.dart';
import 'package:obtainium/providers/settings_provider.dart';
import 'package:obtainium/providers/source_provider.dart';
import 'package:obtainium/theme.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:easy_localization/easy_localization.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/easy_localization_controller.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/localization.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

List<MapEntry<Locale, String>> supportedLocales = const [
  MapEntry(Locale('en'), 'English'),
  MapEntry(Locale('zh'), '简体中文'),
  MapEntry(Locale('zh', 'Hant_TW'), '臺灣話'),
  MapEntry(Locale('it'), 'Italiano'),
  MapEntry(Locale('ja'), '日本語'),
  MapEntry(Locale('hu'), 'Magyar'),
  MapEntry(Locale('de'), 'Deutsch'),
  MapEntry(Locale('fa'), 'فارسی'),
  MapEntry(Locale('fr'), 'Français'),
  MapEntry(Locale('es'), 'Español'),
  MapEntry(Locale('pl'), 'Polski'),
  MapEntry(Locale('ru'), 'Русский'),
  MapEntry(Locale('bs'), 'Bosanski'),
  MapEntry(Locale('pt'), 'Português'),
  MapEntry(Locale('pt', 'BR'), 'Brasileiro'),
  MapEntry(Locale('cs'), 'Česky'),
  MapEntry(Locale('sv'), 'Svenska'),
  MapEntry(Locale('nl'), 'Nederlands'),
  MapEntry(Locale('vi'), 'Tiếng Việt'),
  MapEntry(Locale('tr'), 'Türkçe'),
  MapEntry(Locale('uk'), 'Українська'),
  MapEntry(Locale('da'), 'Dansk'),
  MapEntry(
    Locale('en', 'EO'),
    'Esperanto',
  ), // https://github.com/aissat/easy_localization/issues/220#issuecomment-846035493
  MapEntry(Locale('in'), 'Bahasa Indonesia'),
  MapEntry(Locale('ko'), '한국어'),
  MapEntry(Locale('ca'), 'Català'),
  MapEntry(Locale('ar'), 'العربية'),
  MapEntry(Locale('ml'), 'മലയാളം'),
];
const fallbackLocale = Locale('en');
const localeDir = 'assets/translations';
var fdroid = false;

final globalNavigatorKey = GlobalKey<NavigatorState>();

Future<void> loadTranslations() async {
  // See easy_localization/issues/210
  await EasyLocalizationController.initEasyLocation();
  var s = await SettingsProvider.ensureInitialized();
  var forceLocale = s.forcedLocale;
  final controller = EasyLocalizationController(
    saveLocale: true,
    forceLocale: forceLocale,
    fallbackLocale: fallbackLocale,
    supportedLocales: supportedLocales.map((e) => e.key).toList(),
    assetLoader: const RootBundleAssetLoader(),
    useOnlyLangCode: false,
    useFallbackTranslations: true,
    path: localeDir,
    onLoadError: (e) {
      throw e;
    },
  );
  await controller.loadTranslations();
  Localization.load(
    controller.locale,
    translations: controller.translations,
    fallbackTranslations: controller.fallbackTranslations,
  );
}

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    print('BG update task timed out.');
    BackgroundFetch.finish(taskId);
    return;
  }
  await bgUpdateCheck(taskId, null);
  BackgroundFetch.finish(taskId);
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  static const String incrementCountCommand = 'incrementCount';

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    print('onStart(starter: ${starter.name})');
    bgUpdateCheck('bg_check', null);
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    bgUpdateCheck('bg_check', null);
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    print('Foreground service onDestroy(isTimeout: $isTimeout)');
  }

  @override
  void onReceiveData(Object data) {}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    ByteData data = await PlatformAssetBundle().load(
      'assets/ca/lets-encrypt-r3.pem',
    );
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      data.buffer.asUint8List(),
    );
  } catch (e) {
    // Already added, do nothing (see #375)
  }
  await EasyLocalization.ensureInitialized();
  if ((await DeviceInfoPlugin().androidInfo).version.sdkInt >= 29) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
  final np = NotificationsProvider();
  await np.initialize();
  FlutterForegroundTask.initCommunicationPort();
  await DynamicColorBuilder.preload();
  final settingsProvider = await SettingsProvider.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppsProvider()),
        ChangeNotifierProvider(create: (context) => settingsProvider),
        Provider(create: (context) => np),
        Provider(create: (context) => LogsProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: supportedLocales.map((e) => e.key).toList(),
        path: localeDir,
        fallbackLocale: fallbackLocale,
        useOnlyLangCode: false,
        child: DynamicColorBuilder(
          builder: (context, source) => Obtainium(dynamicColorSource: source),
        ),
      ),
    ),
  );
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class Obtainium extends StatefulWidget {
  const Obtainium({super.key, required this.dynamicColorSource});

  final DynamicColorSource? dynamicColorSource;

  @override
  State<Obtainium> createState() => _ObtainiumState();
}

class _ObtainiumState extends State<Obtainium> {
  var existingUpdateInterval = -1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestNonOptionalPermissions();
    });
  }

  Future<void> requestNonOptionalPermissions() async {
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }
  }

  void initForegroundService() {
    // ignore: invalid_use_of_visible_for_testing_member
    if (!FlutterForegroundTask.isInitialized) {
      FlutterForegroundTask.init(
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'bg_update',
          channelName: tr('foregroundService'),
          channelDescription: tr('foregroundService'),
          onlyAlertOnce: true,
        ),
        iosNotificationOptions: const IOSNotificationOptions(
          showNotification: false,
          playSound: false,
        ),
        foregroundTaskOptions: ForegroundTaskOptions(
          eventAction: ForegroundTaskEventAction.repeat(900000),
          autoRunOnBoot: true,
          autoRunOnMyPackageReplaced: true,
          allowWakeLock: true,
          allowWifiLock: true,
        ),
      );
    }
  }

  Future<ServiceRequestResult?> startForegroundService(bool restart) async {
    initForegroundService();
    if (await FlutterForegroundTask.isRunningService) {
      if (restart) {
        return FlutterForegroundTask.restartService();
      }
    } else {
      return FlutterForegroundTask.startService(
        serviceTypes: [ForegroundServiceTypes.specialUse],
        serviceId: 666,
        notificationTitle: tr('foregroundService'),
        notificationText: tr('fgServiceNotice'),
        notificationIcon: const NotificationIcon(
          metaDataName: 'dev.imranr.obtainium.service.NOTIFICATION_ICON',
        ),
        callback: startCallback,
      );
    }
    return null;
  }

  Future<ServiceRequestResult?> stopForegroundService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.stopService();
    }
    return null;
  }

  // void onReceiveForegroundServiceData(Object data) {
  //   print('onReceiveTaskData: $data');
  // }

  @override
  void dispose() {
    // Remove a callback to receive data sent from the TaskHandler.
    // FlutterForegroundTask.removeTaskDataCallback(onReceiveForegroundServiceData);
    super.dispose();
  }

  Future<void> initPlatformState() async {
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.ANY,
      ),
      (String taskId) async {
        await bgUpdateCheck(taskId, null);
        BackgroundFetch.finish(taskId);
      },
      (String taskId) async {
        context.read<LogsProvider>().add('BG update task timed out.');
        BackgroundFetch.finish(taskId);
      },
    );
    if (!mounted) return;
  }

  ColorThemeData _createColorTheme({
    required SettingsProvider settingsProvider,
    required Brightness brightness,
    bool highContrast = false,
  }) {
    if (settingsProvider.useMaterialYou) {
      final sourceColor = switch (widget.dynamicColorSource) {
        AccentColorSource(:final accentColor) => accentColor,
        _ => const Color(0xFF6750A4),
      };
      final fallback = ColorThemeData.fromSeed(
        sourceColor: sourceColor,
        brightness: brightness,
        contrastLevel: highContrast ? 1.0 : 0.0,
        variant: DynamicSchemeVariant.tonalSpot,
        platform: DynamicSchemePlatform.phone,
        specVersion: DynamicSchemeSpecVersion.spec2025,
      );
      final provided = switch (widget.dynamicColorSource) {
        DynamicColorSchemesSource(
          :final dynamicLightColorScheme,
          :final dynamicDarkColorScheme,
        ) =>
          switch (brightness) {
            Brightness.light => dynamicLightColorScheme.toColorTheme(),
            Brightness.dark => dynamicDarkColorScheme.toColorTheme(),
          },
        DynamicColorSchemeSource(
          brightness: final availableBrightness,
          :final dynamicColorScheme,
        ) =>
          availableBrightness == brightness
              ? dynamicColorScheme.toColorTheme()
              : null,
        _ => null,
      };
      return fallback.merge(provided);
    } else {
      return ColorThemeData.fromSeed(
        sourceColor: settingsProvider.themeColor,
        brightness: brightness,
        contrastLevel: highContrast ? 1.0 : 0.0,
        variant: DynamicSchemeVariant.tonalSpot,
        platform: DynamicSchemePlatform.phone,
        specVersion: DynamicSchemeSpecVersion.spec2025,
      );
    }
  }

  Widget _buildColorTheme(BuildContext context, Widget child) {
    final settingsProvider = context.watch<SettingsProvider>();
    final brightness = switch (settingsProvider.theme) {
      ThemeSettings.system => MediaQuery.platformBrightnessOf(context),
      ThemeSettings.light => Brightness.light,
      ThemeSettings.dark => Brightness.dark,
    };
    final highContrast = MediaQuery.highContrastOf(context);
    return ColorTheme(
      data: _createColorTheme(
        settingsProvider: settingsProvider,
        brightness: brightness,
        highContrast: highContrast,
      ),
      child: child,
    );
  }

  Widget _buildTypographyTheme(BuildContext context, Widget child) {
    return TypographyDefaults.googleMaterial3Expressive.build(context, child);
  }

  Widget _buildSpringTheme(BuildContext context, Widget child) {
    return SpringTheme(data: const SpringThemeData.expressive(), child: child);
  }

  Widget _buildAppWrapper({
    Widget? child,
    required Widget Function(BuildContext context, Widget? child) builder,
  }) {
    return CombiningBuilder(
      builders: [_buildColorTheme, _buildTypographyTheme, _buildSpringTheme],
      child: Builder(builder: (context) => builder(context, child)),
    );
  }

  Widget _buildHomeWrapper(BuildContext context, Widget? child) {
    if (child == null) return const SizedBox.shrink();
    return child;
  }

  Widget _buildMaterialApp(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final typescaleTheme = TypescaleTheme.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Localization
      title: 'Obtainium',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // Theming
      themeMode: switch (settingsProvider.theme) {
        ThemeSettings.system => ThemeMode.system,
        ThemeSettings.light => ThemeMode.light,
        ThemeSettings.dark => ThemeMode.dark,
      },
      theme: LegacyThemeFactory.create(
        colorTheme: _createColorTheme(
          settingsProvider: settingsProvider,
          brightness: Brightness.light,
          highContrast: false,
        ),
        typescaleTheme: typescaleTheme,
      ),
      darkTheme: LegacyThemeFactory.create(
        colorTheme: _createColorTheme(
          settingsProvider: settingsProvider,
          brightness: Brightness.dark,
          highContrast: false,
        ),
        typescaleTheme: typescaleTheme,
      ),
      highContrastTheme: LegacyThemeFactory.create(
        colorTheme: _createColorTheme(
          settingsProvider: settingsProvider,
          brightness: Brightness.light,
          highContrast: true,
        ),
        typescaleTheme: typescaleTheme,
      ),
      highContrastDarkTheme: LegacyThemeFactory.create(
        colorTheme: _createColorTheme(
          settingsProvider: settingsProvider,
          brightness: Brightness.dark,
          highContrast: true,
        ),
        typescaleTheme: typescaleTheme,
      ),

      // Navigation
      navigatorKey: globalNavigatorKey,
      builder: _buildHomeWrapper,
      home: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final appsProvider = context.read<AppsProvider>();
    final logs = context.read<LogsProvider>();
    final notifs = context.read<NotificationsProvider>();
    if (settingsProvider.updateInterval == 0) {
      stopForegroundService();
      BackgroundFetch.stop();
    } else {
      if (settingsProvider.useFGService) {
        BackgroundFetch.stop();
        startForegroundService(false);
      } else {
        stopForegroundService();
        BackgroundFetch.start();
      }
    }
    final isFirstRun = settingsProvider.checkAndFlipFirstRun();
    if (isFirstRun) {
      logs.add('This is the first ever run of Obtainium.');
      // If this is the first run, add Obtainium to the Apps list
      if (!fdroid) {
        getInstalledInfo(obtainiumId)
            .then((value) {
              if (value?.versionName != null) {
                appsProvider.saveApps([
                  App(
                    obtainiumId,
                    obtainiumUrl,
                    'ImranR98',
                    'Obtainium',
                    value!.versionName,
                    value.versionName!,
                    [],
                    0,
                    {
                      'versionDetection': true,
                      'apkFilterRegEx': 'fdroid',
                      'invertAPKFilter': true,
                    },
                    null,
                    false,
                  ),
                ], onlyIfExists: false);
              }
            })
            .catchError((err) {
              print(err);
            });
      }

      if (!supportedLocales.map((e) => e.key).contains(context.locale) ||
          (settingsProvider.forcedLocale == null &&
              context.deviceLocale != context.locale)) {
        settingsProvider.resetLocaleSafe(context);
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifs.checkLaunchByNotif();
    });

    return WithForegroundTask(
      child: _buildAppWrapper(
        builder: (context, child) => _buildMaterialApp(context),
      ),
    );
  }
}
