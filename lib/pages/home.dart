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
  const NavigationPageItem(this.destination, this.widget);

  final NavigationDestination destination;
  final Widget widget;
}

class _HomePageState extends State<HomePage> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  bool _isLinkActivity = false;

  final List<int> _selectedIndexHistory = <int>[];
  int _prevAppCount = -1;
  bool _prevIsLoading = true;

  List<NavigationPageItem> pages = [
    NavigationPageItem(
      NavigationDestination(
        icon: const IconLegacy(Symbols.apps_rounded, fill: 0.0),
        selectedIcon: const IconLegacy(Symbols.apps_rounded, fill: 1.0),
        label: tr("appsString"),
      ),
      AppsPage(key: GlobalKey<AppsPageState>()),
    ),
    NavigationPageItem(
      NavigationDestination(
        icon: const IconLegacy(Symbols.add_rounded, fill: 0.0),
        selectedIcon: const IconLegacy(Symbols.add_rounded, fill: 1.0),
        label: tr("addApp"),
      ),
      AddAppPage(key: GlobalKey<AddAppPageState>()),
    ),
    NavigationPageItem(
      NavigationDestination(
        icon: const IconLegacy(Symbols.swap_vert_rounded, fill: 0.0),
        selectedIcon: const IconLegacy(Symbols.swap_vert_rounded, fill: 1.0),
        label: tr("importExport"),
      ),
      const ImportExportPage(),
    ),
    NavigationPageItem(
      NavigationDestination(
        icon: const IconLegacy(Symbols.settings_rounded, fill: 0.0),
        selectedIcon: const IconLegacy(Symbols.settings_rounded, fill: 1.0),
        label: tr("settings"),
      ),
      const SettingsPage(),
    ),
  ];

  Future<void> _initDeepLinks() async {
    Future<void> goToAddApp(String data) async {
      _switchToPage(1);
      while ((pages[1].widget.key as GlobalKey<AddAppPageState>?)
              ?.currentState ==
          null) {
        await Future.delayed(const Duration(microseconds: 1));
      }
      (pages[1].widget.key as GlobalKey<AddAppPageState>?)?.currentState
          ?.linkFn(data);
    }

    Future<void> interpretLink(Uri uri) async {
      _isLinkActivity = true;
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
            if (!mounted) return;
            var appsProvider = context.read<AppsProvider>();
            var result = await appsProvider.import(
              action == 'app'
                  ? '{ "apps": [$dataStr] }'
                  : '{ "apps": $dataStr }',
            );

            if (!mounted) return;
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
        if (!mounted) return;
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

  Future<void> _switchToPage(int index) async {
    if (index == 0) {
      while ((pages[0].widget.key as GlobalKey<AppsPageState>).currentState !=
          null) {
        // Avoid duplicate GlobalKey error
        await Future.delayed(const Duration(microseconds: 1));
      }
      setState(() {
        _selectedIndexHistory.clear();
      });
    } else if (_selectedIndexHistory.isEmpty ||
        (_selectedIndexHistory.isNotEmpty &&
            _selectedIndexHistory.last != index)) {
      setState(() {
        int existingInd = _selectedIndexHistory.indexOf(index);
        if (existingInd >= 0) {
          _selectedIndexHistory.removeAt(existingInd);
        }
        _selectedIndexHistory.add(index);
      });
    }
  }

  // TODO: migrate to use PopScope for top-level navigation history handling

  // The tricky part is that onPopInvokedWithResult gets called AFTER a pop
  // has NOT been prevented, so the logic of the previous onWillPop callback
  // becomes useless. A suggestion is to use either ModalRoute.registerPopEntry
  // or ModalRoute.addLocalHistoryEntry in this scenario. Until this gets
  // implemented, top-level navigation history is unsupported, attempting to
  // pop a top-level route pops the whole application.

  // Future<bool> _onWillPop() async {
  //   if (isLinkActivity &&
  //       selectedIndexHistory.length == 1 &&
  //       selectedIndexHistory.last == 1) {
  //     return true;
  //   }
  //   setIsReversing(
  //     selectedIndexHistory.length >= 2
  //         ? selectedIndexHistory.reversed.toList()[1]
  //         : 0,
  //   );
  //   if (selectedIndexHistory.isNotEmpty) {
  //     setState(() {
  //       selectedIndexHistory.removeLast();
  //     });
  //     return false;
  //   }
  //   return !(pages[0].widget.key as GlobalKey<AppsPageState>).currentState!
  //       .clearSelected();
  // }

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      var sp = context.read<SettingsProvider>();
      if (!sp.welcomeShown) {
        await showDialog(
          context: context,
          builder: (ctx) {
            final colorTheme = ColorTheme.of(ctx);
            final shapeTheme = ShapeTheme.of(ctx);
            final stateTheme = StateTheme.of(ctx);
            final typescaleTheme = TypescaleTheme.of(ctx);

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
                          const intent = AndroidIntent(
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
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    animationDuration: Duration.zero,
                    elevation: const WidgetStatePropertyAll(0.0),
                    shadowColor: WidgetStateColor.transparent,
                    minimumSize: const WidgetStatePropertyAll(Size(48.0, 40.0)),
                    fixedSize: const WidgetStatePropertyAll(null),
                    maximumSize: const WidgetStatePropertyAll(Size.infinite),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    ),
                    iconSize: const WidgetStatePropertyAll(20.0),
                    shape: WidgetStatePropertyAll(
                      CornersBorder.rounded(
                        corners: Corners.all(shapeTheme.corner.full),
                      ),
                    ),
                    overlayColor: WidgetStateLayerColor(
                      color: WidgetStatePropertyAll(colorTheme.primary),
                      opacity: stateTheme.stateLayerOpacity,
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => states.contains(WidgetState.disabled)
                          ? colorTheme.onSurface.withValues(alpha: 0.1)
                          : Colors.transparent,
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith(
                      (states) => states.contains(WidgetState.disabled)
                          ? colorTheme.onSurface.withValues(alpha: 0.38)
                          : colorTheme.primary,
                    ),
                    textStyle: WidgetStateProperty.resolveWith(
                      (states) => typescaleTheme.labelLarge.toTextStyle(),
                    ),
                  ),
                  child: Text(tr('ok')),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appsProvider = context.watch<AppsProvider>();

    if (!_prevIsLoading &&
        _prevAppCount >= 0 &&
        appsProvider.apps.length > _prevAppCount &&
        _selectedIndexHistory.isNotEmpty &&
        _selectedIndexHistory.last == 1 &&
        !_isLinkActivity) {
      _switchToPage(0);
    }

    final colorTheme = ColorTheme.of(context);

    _prevAppCount = appsProvider.apps.length;
    _prevIsLoading = appsProvider.loadingApps;

    final selectedIndex = _selectedIndexHistory.isEmpty
        ? 0
        : _selectedIndexHistory.last;

    // TODO: this doesn't seem to do anything because onWillPop is null
    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      body: pages
          .elementAt(
            _selectedIndexHistory.isEmpty ? 0 : _selectedIndexHistory.last,
          )
          .widget,
      bottomNavigationBar: NavigationBar(
        backgroundColor: switch (selectedIndex) {
          0 => colorTheme.surfaceContainerHigh,
          1 || 2 || 3 => colorTheme.surfaceContainerHigh,
          _ => colorTheme.surfaceContainer,
        },
        onDestinationSelected: (index) async {
          HapticFeedback.selectionClick();
          _switchToPage(index);
        },
        selectedIndex: selectedIndex,
        destinations: pages.map((e) => e.destination).toList(),
      ),
    );
  }
}
