import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:obtainium/flutter.dart';
import 'package:obtainium/components/generated_form_modal.dart';
import 'package:obtainium/custom_errors.dart';
import 'package:obtainium/pages/add_app.dart';
import 'package:obtainium/pages/apps.dart';
import 'package:obtainium/pages/import_export.dart';
import 'package:obtainium/pages/settings.dart';
import 'package:obtainium/providers/apps_provider.dart';
import 'package:obtainium/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class NavigationPageItem {
  late String title;
  late IconData icon;
  late Widget widget;

  NavigationPageItem(this.title, this.icon, this.widget);
}

class _HomePageState extends State<HomePage> {
  List<int> selectedIndexHistory = [];
  bool isReversing = false;
  int prevAppCount = -1;
  bool prevIsLoading = true;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  bool isLinkActivity = false;

  List<NavigationPageItem> pages = [
    NavigationPageItem(
      tr('appsString'),
      Symbols.apps_rounded,
      AppsPage(key: GlobalKey<AppsPageState>()),
    ),
    NavigationPageItem(
      tr('addApp'),
      Symbols.add_rounded,
      AddAppPage(key: GlobalKey<AddAppPageState>()),
    ),
    NavigationPageItem(
      tr('importExport'),
      Symbols.import_export_rounded,
      const ImportExportPage(),
    ),
    NavigationPageItem(
      tr('settings'),
      // TODO: this icon must have fill: 1
      Symbols.settings_rounded,
      const SettingsPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    initDeepLinks();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var sp = context.read<SettingsProvider>();
      if (!sp.welcomeShown) {
        await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(tr('welcome')),
              content: Flex.vertical(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  Text(tr('documentationLinksNote')),
                  GestureDetector(
                    onTap: () {
                      launchUrlString(
                        'https://github.com/ImranR98/Obtainium/blob/main/README.md',
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: const Text(
                      'https://github.com/ImranR98/Obtainium/blob/main/README.md',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flex.vertical(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('batteryOptimizationNote')),
                      GestureDetector(
                        onTap: () {
                          final intent = AndroidIntent(
                            action:
                                'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
                            package:
                                obtainiumId, // Replace with your app's package name
                          );

                          intent.launch();
                        },
                        child: Text(
                          tr('settings'),
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    sp.welcomeShown = true;
                    Navigator.of(context).pop(null);
                  },
                  child: Text(tr('ok')),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    Future<void> goToAddApp(String data) async {
      switchToPage(1);
      while ((pages[1].widget.key as GlobalKey<AddAppPageState>?)
              ?.currentState ==
          null) {
        await Future.delayed(const Duration(microseconds: 1));
      }
      (pages[1].widget.key as GlobalKey<AddAppPageState>?)?.currentState
          ?.linkFn(data);
    }

    Future<void> interpretLink(Uri uri) async {
      isLinkActivity = true;
      var action = uri.host;
      var data = uri.path.length > 1 ? uri.path.substring(1) : "";
      try {
        if (action == 'add') {
          await goToAddApp(data);
        } else if (action == 'app' || action == 'apps') {
          var dataStr = Uri.decodeComponent(data);
          if (await showDialog(
                context: context,
                builder: (ctx) {
                  return GeneratedFormModal(
                    title: tr(
                      'importX',
                      args: [
                        (action == 'app' ? tr('app') : tr('appsString'))
                            .toLowerCase(),
                      ],
                    ),
                    items: const [],
                    additionalWidgets: [
                      ExpansionTile(
                        title: const Text('Raw JSON'),
                        children: [
                          Text(
                            dataStr,
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ) !=
              null) {
            var appsProvider = context.read<AppsProvider>();
            var result = await appsProvider.import(
              action == 'app'
                  ? '{ "apps": [$dataStr] }'
                  : '{ "apps": $dataStr }',
            );

            showMessage(
              tr(
                'importedX',
                args: [plural('apps', result.key.length).toLowerCase()],
              ),
              context,
            );
          }
        } else {
          throw ObtainiumError(tr('unknown'));
        }
      } catch (e) {
        showError(e, context);
      }
    }

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialLink();
    var initLinked = false;
    if (appLink != null) {
      await interpretLink(appLink);
      initLinked = true;
    }
    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
      if (!initLinked) {
        await interpretLink(uri);
      } else {
        initLinked = false;
      }
    });
  }

  void setIsReversing(int targetIndex) {
    bool reversing =
        selectedIndexHistory.isNotEmpty &&
        selectedIndexHistory.last > targetIndex;
    setState(() {
      isReversing = reversing;
    });
  }

  Future<void> switchToPage(int index) async {
    setIsReversing(index);
    if (index == 0) {
      while ((pages[0].widget.key as GlobalKey<AppsPageState>).currentState !=
          null) {
        // Avoid duplicate GlobalKey error
        await Future.delayed(const Duration(microseconds: 1));
      }
      setState(() {
        selectedIndexHistory.clear();
      });
    } else if (selectedIndexHistory.isEmpty ||
        (selectedIndexHistory.isNotEmpty &&
            selectedIndexHistory.last != index)) {
      setState(() {
        int existingInd = selectedIndexHistory.indexOf(index);
        if (existingInd >= 0) {
          selectedIndexHistory.removeAt(existingInd);
        }
        selectedIndexHistory.add(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppsProvider appsProvider = context.watch<AppsProvider>();
    SettingsProvider settingsProvider = context.watch<SettingsProvider>();

    if (!prevIsLoading &&
        prevAppCount >= 0 &&
        appsProvider.apps.length > prevAppCount &&
        selectedIndexHistory.isNotEmpty &&
        selectedIndexHistory.last == 1 &&
        !isLinkActivity) {
      switchToPage(0);
    }
    prevAppCount = appsProvider.apps.length;
    prevIsLoading = appsProvider.loadingApps;

    // TODO: this doesn't seem to do anything because onWillPop is null
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorTheme.of(context).surface,
        body: pages
            .elementAt(
              selectedIndexHistory.isEmpty ? 0 : selectedIndexHistory.last,
            )
            .widget,
        bottomNavigationBar: NavigationBar(
          destinations: pages
              .map(
                (e) => NavigationDestination(
                  icon: IconLegacy(e.icon),
                  label: e.title,
                ),
              )
              .toList(),
          onDestinationSelected: (index) async {
            HapticFeedback.selectionClick();
            switchToPage(index);
          },
          selectedIndex: selectedIndexHistory.isEmpty
              ? 0
              : selectedIndexHistory.last,
        ),
      ),
      onWillPop: () async {
        if (isLinkActivity &&
            selectedIndexHistory.length == 1 &&
            selectedIndexHistory.last == 1) {
          return true;
        }
        setIsReversing(
          selectedIndexHistory.length >= 2
              ? selectedIndexHistory.reversed.toList()[1]
              : 0,
        );
        if (selectedIndexHistory.isNotEmpty) {
          setState(() {
            selectedIndexHistory.removeLast();
          });
          return false;
        }
        return !(pages[0].widget.key as GlobalKey<AppsPageState>).currentState!
            .clearSelected();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _linkSubscription?.cancel();
  }
}
