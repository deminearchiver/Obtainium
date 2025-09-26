import 'package:device_info_plus/device_info_plus.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equations/equations.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:obtainium/components/custom_decorated_sliver.dart';
import 'package:obtainium/flutter.dart';
import 'package:obtainium/components/custom_app_bar.dart';
import 'package:obtainium/components/generated_form.dart';
import 'package:obtainium/components/generated_form_modal.dart';
import 'package:obtainium/custom_errors.dart';
import 'package:obtainium/main.dart';
import 'package:obtainium/providers/apps_provider.dart';
import 'package:obtainium/providers/logs_provider.dart';
import 'package:obtainium/providers/settings_provider.dart';
import 'package:obtainium/providers/source_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shizuku_apk_installer/shizuku_apk_installer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<int> updateIntervalNodes = [
    15,
    30,
    60,
    120,
    180,
    360,
    720,
    1440,
    4320,
    10080,
    20160,
    43200,
  ];
  int updateInterval = 0;
  late SplineInterpolation updateIntervalInterpolator; // 🤓
  String updateIntervalLabel = tr('neverManualOnly');
  bool showIntervalLabel = true;
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
        ColorTools.createPrimarySwatch(obtainiumThemeColor): 'Obtainium',
      };

  void initUpdateIntervalInterpolator() {
    List<InterpolationNode> nodes = [];
    for (final (index, element) in updateIntervalNodes.indexed) {
      nodes.add(
        InterpolationNode(x: index.toDouble() + 1, y: element.toDouble()),
      );
    }
    updateIntervalInterpolator = SplineInterpolation(nodes: nodes);
  }

  void processIntervalSliderValue(double val) {
    if (val < 0.5) {
      updateInterval = 0;
      updateIntervalLabel = tr('neverManualOnly');
      return;
    }
    int valInterpolated = 0;
    if (val < 1) {
      valInterpolated = 15;
    } else {
      valInterpolated = updateIntervalInterpolator.compute(val).round();
    }
    if (valInterpolated < 60) {
      updateInterval = valInterpolated;
      updateIntervalLabel = plural('minute', valInterpolated);
    } else if (valInterpolated < 8 * 60) {
      int valRounded = (valInterpolated / 15).floor() * 15;
      updateInterval = valRounded;
      updateIntervalLabel = plural('hour', valRounded ~/ 60);
      int mins = valRounded % 60;
      if (mins != 0) updateIntervalLabel += " ${plural('minute', mins)}";
    } else if (valInterpolated < 24 * 60) {
      int valRounded = (valInterpolated / 30).floor() * 30;
      updateInterval = valRounded;
      updateIntervalLabel = plural('hour', valRounded / 60);
    } else if (valInterpolated < 7 * 24 * 60) {
      int valRounded = (valInterpolated / (12 * 60)).floor() * 12 * 60;
      updateInterval = valRounded;
      updateIntervalLabel = plural('day', valRounded / (24 * 60));
    } else {
      int valRounded = (valInterpolated / (24 * 60)).floor() * 24 * 60;
      updateInterval = valRounded;
      updateIntervalLabel = plural('day', valRounded ~/ (24 * 60));
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final sourceProvider = SourceProvider();
    initUpdateIntervalInterpolator();
    processIntervalSliderValue(settingsProvider.updateIntervalSliderVal);

    final Widget followSystemThemeExplanation = FutureBuilder(
      builder: (ctx, val) {
        return ((val.data?.version.sdkInt ?? 30) < 29)
            ? Text(
                tr('followSystemThemeExplanation'),
                style: TypescaleTheme.of(context).labelSmall.toTextStyle(),
              )
            : const SizedBox.shrink();
      },
      future: DeviceInfoPlugin().androidInfo,
    );

    Future<bool> colorPickerDialog() async {
      return ColorPicker(
        color: settingsProvider.themeColor,
        onColorChanged: (color) =>
            setState(() => settingsProvider.themeColor = color),
        actionButtons: const ColorPickerActionButtons(
          okButton: true,
          closeButton: true,
          dialogActionButtons: false,
        ),
        pickersEnabled: const <ColorPickerType, bool>{
          ColorPickerType.both: false,
          ColorPickerType.primary: false,
          ColorPickerType.accent: false,
          ColorPickerType.bw: false,
          ColorPickerType.custom: true,
          ColorPickerType.wheel: true,
        },
        pickerTypeLabels: <ColorPickerType, String>{
          ColorPickerType.custom: tr('standard'),
          ColorPickerType.wheel: tr('custom'),
        },
        title: Text(
          tr('selectX', args: [tr('colour').toLowerCase()]),
          style: TypescaleTheme.of(context).titleLarge.toTextStyle(),
        ),
        wheelDiameter: 192,
        wheelSquareBorderRadius: 32,
        width: 48,
        height: 48,
        borderRadius: 24,
        spacing: 8,
        runSpacing: 8,
        enableShadesSelection: false,
        customColorSwatchesAndNames: colorsNameMap,
        showMaterialName: true,
        showColorName: true,
        materialNameTextStyle: TypescaleTheme.of(
          context,
        ).bodySmall.toTextStyle(),
        colorNameTextStyle: TypescaleTheme.of(context).bodySmall.toTextStyle(),
        copyPasteBehavior: const ColorPickerCopyPasteBehavior(
          longPressMenu: true,
        ),
      ).showPickerDialog(
        context,
        transitionBuilder:
            (
              BuildContext context,
              Animation<double> a1,
              Animation<double> a2,
              Widget widget,
            ) {
              final double curvedValue = Curves.easeInCubic.transform(a1.value);
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(curvedValue, curvedValue, 1),
                child: Opacity(opacity: curvedValue, child: widget),
              );
            },
        transitionDuration: const Duration(milliseconds: 250),
      );
    }

    final Widget colorPicker = ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(tr('selectX', args: [tr('colour').toLowerCase()])),
      subtitle: Text(
        "${ColorTools.nameThatColor(settingsProvider.themeColor)} "
        "(${ColorTools.materialNameAndCode(settingsProvider.themeColor, colorSwatchNameMap: colorsNameMap)})",
      ),
      trailing: ColorIndicator(
        width: 40,
        height: 40,
        borderRadius: 20,
        color: settingsProvider.themeColor,
        onSelectFocus: false,
        onSelect: () async {
          final Color colorBeforeDialog = settingsProvider.themeColor;
          if (!(await colorPickerDialog())) {
            setState(() {
              settingsProvider.themeColor = colorBeforeDialog;
            });
          }
        },
      ),
    );

    final Widget useMaterialThemeSwitch = FutureBuilder(
      builder: (ctx, val) {
        return (val.data ?? false)
            ? Flex.horizontal(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible.loose(child: Text(tr('useMaterialYou'))),
                  Switch(
                    value: settingsProvider.useMaterialYou,
                    onChanged: (value) {
                      settingsProvider.useMaterialYou = value;
                    },
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
      future: const DynamicColor().isDynamicColorAvailable(),
    );

    final Widget sortDropdown = DropdownMenuFormField<SortColumnSettings>(
      expandedInsets: EdgeInsets.zero,
      inputDecorationTheme: const InputDecorationThemeData(
        border: UnderlineInputBorder(),
        filled: true,
      ),
      label: Text(tr('appSortBy')),
      initialSelection: settingsProvider.sortColumn,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: SortColumnSettings.authorName,
          label: tr('authorName'),
        ),
        DropdownMenuEntry(
          value: SortColumnSettings.nameAuthor,
          label: tr('nameAuthor'),
        ),
        DropdownMenuEntry(
          value: SortColumnSettings.added,
          label: tr('asAdded'),
        ),
        DropdownMenuEntry(
          value: SortColumnSettings.releaseDate,
          label: tr('releaseDate'),
        ),
      ],
      onSelected: (value) {
        if (value != null) {
          settingsProvider.sortColumn = value;
        }
      },
    );

    final Widget orderDropdown = DropdownMenuFormField<SortOrderSettings>(
      expandedInsets: EdgeInsets.zero,
      inputDecorationTheme: const InputDecorationThemeData(
        border: UnderlineInputBorder(),
        filled: true,
      ),
      label: Text(tr('appSortOrder')),
      initialSelection: settingsProvider.sortOrder,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: SortOrderSettings.ascending,
          label: tr('ascending'),
        ),
        DropdownMenuEntry(
          value: SortOrderSettings.descending,
          label: tr('descending'),
        ),
      ],
      onSelected: (value) {
        if (value != null) {
          settingsProvider.sortOrder = value;
        }
      },
    );

    final Widget localeDropdown = DropdownMenuFormField<Locale?>(
      expandedInsets: EdgeInsets.zero,
      inputDecorationTheme: const InputDecorationThemeData(
        border: UnderlineInputBorder(),
        filled: true,
      ),
      label: Text(tr('language')),
      enableFilter: true,
      enableSearch: true,
      requestFocusOnTap: true,

      initialSelection: settingsProvider.forcedLocale,
      dropdownMenuEntries: [
        DropdownMenuEntry(value: null, label: tr('followSystem')),
        ...supportedLocales.map(
          (e) => DropdownMenuEntry(value: e.key, label: e.value),
        ),
      ],
      onSelected: (value) {
        settingsProvider.forcedLocale = value;
        if (value != null) {
          context.setLocale(value);
        } else {
          settingsProvider.resetLocaleSafe(context);
        }
      },
    );

    final Widget intervalSlider = Slider(
      value: settingsProvider.updateIntervalSliderVal,
      max: updateIntervalNodes.length.toDouble(),
      divisions: updateIntervalNodes.length * 20,
      label: updateIntervalLabel,
      onChanged: (double value) {
        setState(() {
          settingsProvider.updateIntervalSliderVal = value;
          processIntervalSliderValue(value);
        });
      },
      onChangeStart: (double value) {
        setState(() {
          showIntervalLabel = false;
        });
      },
      onChangeEnd: (double value) {
        setState(() {
          showIntervalLabel = true;
          settingsProvider.updateInterval = updateInterval;
        });
      },
    );

    final sourceSpecificFields = sourceProvider.sources.map((e) {
      if (e.sourceConfigSettingFormItems.isNotEmpty) {
        return GeneratedForm(
          items: e.sourceConfigSettingFormItems.map((e) {
            if (e is GeneratedFormSwitch) {
              e.defaultValue = settingsProvider.getSettingBool(e.key);
            } else {
              e.defaultValue = settingsProvider.getSettingString(e.key);
            }
            return [e];
          }).toList(),
          onValueChanges: (values, valid, isBuilding) {
            if (valid && !isBuilding) {
              values.forEach((key, value) {
                final formItem = e.sourceConfigSettingFormItems
                    .where((i) => i.key == key)
                    .firstOrNull;
                if (formItem is GeneratedFormSwitch) {
                  settingsProvider.setSettingBool(key, value == true);
                } else {
                  settingsProvider.setSettingString(key, value ?? '');
                }
              });
            }
          },
        );
      } else {
        return Container();
      }
    });

    const Widget height8 = SizedBox(height: 8);

    const Widget height16 = SizedBox(height: 16);

    const Widget height32 = SizedBox(height: 32);

    final ButtonStyle footerButtonsStyle = ButtonStyle(
      animationDuration: Duration.zero,
      elevation: const WidgetStatePropertyAll(0.0),
      shadowColor: WidgetStateColor.transparent,
      minimumSize: const WidgetStatePropertyAll(Size.zero),
      fixedSize: const WidgetStatePropertyAll(Size(72.0, 56.0)),
      maximumSize: const WidgetStatePropertyAll(Size.infinite),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      iconSize: const WidgetStatePropertyAll(24.0),
      shape: WidgetStatePropertyAll(
        CornersBorder.rounded(
          corners: Corners.all(ShapeTheme.of(context).corner.full),
        ),
      ),
      overlayColor: WidgetStateLayerColor(
        color: WidgetStatePropertyAll(ColorTheme.of(context).onSecondary),
        opacity: StateTheme.of(context).stateLayerOpacity,
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? ColorTheme.of(context).onSurface.withValues(alpha: 0.1)
            : ColorTheme.of(context).secondary,
      ),
      iconColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? ColorTheme.of(context).onSurface.withValues(alpha: 0.38)
            : ColorTheme.of(context).onSecondary,
      ),
    );

    return Scaffold(
      backgroundColor: ColorTheme.of(context).surfaceContainer,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar.largeFlexible(
            expandedContainerColor: ColorTheme.of(context).surfaceContainer,
            collapsedContainerColor: ColorTheme.of(context).surfaceContainer,
            title: Text(tr('settings')),
          ),
          // if (kDebugMode)
          //   const SliverToBoxAdapter(
          //     child: Align.center(
          //       child: SizedBox.square(
          //         // dimension: 240.0,
          //         child: CircularProgressIndicator(
          //           // strokeWidth: 32.0,
          //           // trackGap: 32.0,
          //           value: null,
          //         ),
          //       ),
          //     ),
          //   ),
          // if (kDebugMode)
          //   const SliverToBoxAdapter(
          //     child: Align.center(
          //       child: SizedBox(
          //         width: 220.0,
          //         child: LinearProgressIndicator(
          //           // strokeWidth: 32.0,
          //           // trackGap: 32.0,
          //           minHeight: 16.0,
          //           trackGap: 16.0,
          //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
          //           value: null,
          //         ),
          //       ),
          //     ),
          //   ),
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0),
          //   sliver: SliverSettingsList(
          //     items: [
          //       SettingsListItem(
          //         onTap: () {},
          //         leading: const IconLegacy(Symbols.magic_button_rounded),
          //         headline: Text("Use Material You"),
          //         supportingText: Text("Use Dynamic color"),
          //         trailing: Switch(onChanged: (value) {}, value: true),
          //       ),
          //       SettingsListItem(headline: Text("Hello world!")),
          //       SettingsListItem(headline: Text("Hello world!")),
          //     ],
          //   ),
          // ),
          CustomDecoratedSliver(
            position: DecorationPosition.background,
            decoration: ShapeDecoration(
              shape: CornersBorder.rounded(
                corners: Corners.all(ShapeTheme.of(context).corner.large),
              ),
              color: ColorTheme.of(context).surfaceContainerLow,
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.list(
                children: [
                  Text(
                    tr('updates'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.of(context).primary,
                    ),
                  ),
                  //intervalDropdown,
                  height16,
                  if (showIntervalLabel)
                    SizedBox(
                      child: Text(
                        "${tr('bgUpdateCheckInterval')}: $updateIntervalLabel",
                      ),
                    )
                  else
                    const SizedBox(height: 16),
                  intervalSlider,
                  FutureBuilder(
                    builder: (ctx, val) {
                      return (settingsProvider.updateInterval > 0) &&
                              (((val.data?.version.sdkInt ?? 0) >= 30) ||
                                  settingsProvider.useShizuku)
                          ? Flex.vertical(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flex.horizontal(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible.loose(
                                      child: Text(
                                        tr('foregroundServiceExplanation'),
                                      ),
                                    ),
                                    Switch(
                                      value: settingsProvider.useFGService,
                                      onChanged: (value) {
                                        settingsProvider.useFGService = value;
                                      },
                                    ),
                                  ],
                                ),
                                Flex.horizontal(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible.loose(
                                      child: Text(
                                        tr('enableBackgroundUpdates'),
                                      ),
                                    ),
                                    Switch(
                                      value: settingsProvider
                                          .enableBackgroundUpdates,
                                      onChanged: (value) {
                                        settingsProvider
                                                .enableBackgroundUpdates =
                                            value;
                                      },
                                    ),
                                  ],
                                ),
                                height8,
                                Text(
                                  tr('backgroundUpdateReqsExplanation'),
                                  style: TypescaleTheme.of(
                                    context,
                                  ).labelSmall.toTextStyle(),
                                ),
                                Text(
                                  tr('backgroundUpdateLimitsExplanation'),
                                  style: TypescaleTheme.of(
                                    context,
                                  ).labelSmall.toTextStyle(),
                                ),
                                height8,
                                if (settingsProvider.enableBackgroundUpdates)
                                  Flex.vertical(
                                    children: [
                                      height16,
                                      Flex.horizontal(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible.loose(
                                            child: Text(
                                              tr('bgUpdatesOnWiFiOnly'),
                                            ),
                                          ),
                                          Switch(
                                            value: settingsProvider
                                                .bgUpdatesOnWiFiOnly,
                                            onChanged: (value) {
                                              settingsProvider
                                                      .bgUpdatesOnWiFiOnly =
                                                  value;
                                            },
                                          ),
                                        ],
                                      ),
                                      height16,
                                      Flex.horizontal(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible.loose(
                                            child: Text(
                                              tr('bgUpdatesWhileChargingOnly'),
                                            ),
                                          ),
                                          Switch(
                                            value: settingsProvider
                                                .bgUpdatesWhileChargingOnly,
                                            onChanged: (value) {
                                              settingsProvider
                                                      .bgUpdatesWhileChargingOnly =
                                                  value;
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          : const SizedBox.shrink();
                    },
                    future: DeviceInfoPlugin().androidInfo,
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(child: Text(tr('checkOnStart'))),
                      Switch(
                        value: settingsProvider.checkOnStart,
                        onChanged: (value) {
                          settingsProvider.checkOnStart = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(
                        child: Text(tr('checkUpdateOnDetailPage')),
                      ),
                      Switch(
                        value: settingsProvider.checkUpdateOnDetailPage,
                        onChanged: (value) {
                          settingsProvider.checkUpdateOnDetailPage = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(
                        child: Text(tr('onlyCheckInstalledOrTrackOnlyApps')),
                      ),
                      Switch(
                        value:
                            settingsProvider.onlyCheckInstalledOrTrackOnlyApps,
                        onChanged: (value) {
                          settingsProvider.onlyCheckInstalledOrTrackOnlyApps =
                              value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(
                        child: Text(tr('removeOnExternalUninstall')),
                      ),
                      Switch(
                        value: settingsProvider.removeOnExternalUninstall,
                        onChanged: (value) {
                          settingsProvider.removeOnExternalUninstall = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(child: Text(tr('parallelDownloads'))),
                      Switch(
                        value: settingsProvider.parallelDownloads,
                        onChanged: (value) {
                          settingsProvider.parallelDownloads = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(
                        child: Flex.vertical(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(tr('beforeNewInstallsShareToAppVerifier')),
                            GestureDetector(
                              onTap: () {
                                launchUrlString(
                                  'https://github.com/soupslurpr/AppVerifier',
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: Text(
                                tr('about'),
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: settingsProvider
                            .beforeNewInstallsShareToAppVerifier,
                        onChanged: (value) {
                          settingsProvider.beforeNewInstallsShareToAppVerifier =
                              value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(child: Text(tr('useShizuku'))),
                      Switch(
                        value: settingsProvider.useShizuku,
                        onChanged: (useShizuku) {
                          if (useShizuku) {
                            ShizukuApkInstaller.checkPermission().then((
                              resCode,
                            ) {
                              settingsProvider.useShizuku = resCode!.startsWith(
                                'granted',
                              );
                              if (!context.mounted) return;
                              switch (resCode) {
                                case 'binder_not_found':
                                  showError(
                                    ObtainiumError(tr('shizukuBinderNotFound')),
                                    context,
                                  );
                                case 'old_shizuku':
                                  showError(
                                    ObtainiumError(tr('shizukuOld')),
                                    context,
                                  );
                                case 'old_android_with_adb':
                                  showError(
                                    ObtainiumError(
                                      tr('shizukuOldAndroidWithADB'),
                                    ),
                                    context,
                                  );
                                case 'denied':
                                  showError(
                                    ObtainiumError(tr('cancelled')),
                                    context,
                                  );
                              }
                            });
                          } else {
                            settingsProvider.useShizuku = false;
                          }
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(
                        child: Text(tr('shizukuPretendToBeGooglePlay')),
                      ),
                      Switch(
                        value: settingsProvider.shizukuPretendToBeGooglePlay,
                        onChanged: (value) {
                          settingsProvider.shizukuPretendToBeGooglePlay = value;
                        },
                      ),
                    ],
                  ),
                  height32,
                  Text(
                    tr('sourceSpecific'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.of(context).primary,
                    ),
                  ),
                  ...sourceSpecificFields,
                  height32,
                  Text(
                    tr('appearance'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.of(context).primary,
                    ),
                  ),
                  DropdownMenuFormField<ThemeSettings>(
                    expandedInsets: EdgeInsets.zero,
                    inputDecorationTheme: const InputDecorationThemeData(
                      border: UnderlineInputBorder(),
                      filled: true,
                    ),
                    label: Text(tr("theme")),
                    initialSelection: settingsProvider.theme,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: ThemeSettings.system,
                        label: tr("followSystem"),
                      ),
                      DropdownMenuEntry(
                        value: ThemeSettings.light,
                        label: tr("light"),
                      ),
                      DropdownMenuEntry(
                        value: ThemeSettings.dark,
                        label: tr("dark"),
                      ),
                    ],
                    onSelected: (value) {
                      if (value != null) {
                        settingsProvider.theme = value;
                      }
                    },
                  ),
                  height8,
                  if (settingsProvider.theme == ThemeSettings.system)
                    followSystemThemeExplanation,
                  height16,
                  // TODO: decide if useBlackTheme shall be reintroduced
                  // if (settingsProvider.theme != ThemeSettings.light)
                  //   Flex.horizontal(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Flexible.loose(child: Text(tr('useBlackTheme'))),
                  //       Switch(
                  //         value: settingsProvider.useBlackTheme,
                  //         onChanged: (value) {
                  //           settingsProvider.useBlackTheme = value;
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // height8,
                  useMaterialThemeSwitch,
                  if (!settingsProvider.useMaterialYou) colorPicker,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible.tight(child: sortDropdown),
                      const SizedBox(width: 16),
                      Flexible.tight(child: orderDropdown),
                    ],
                  ),
                  height16,
                  localeDropdown,
                  // TODO: uncomment if system font support is reintroduced
                  // FutureBuilder(
                  //   builder: (ctx, val) {
                  //     return (val.data?.version.sdkInt ?? 0) >= 34
                  //         ? Flex.vertical(
                  //             crossAxisAlignment:
                  //                 CrossAxisAlignment.start,
                  //             children: [
                  //               height16,
                  //               Flex.horizontal(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Flexible.loose(
                  //                     child: Text(tr('useSystemFont')),
                  //                   ),
                  //                   Switch(
                  //                     value:
                  //                         settingsProvider.useSystemFont,
                  //                     onChanged: (useSystemFont) {
                  //                       if (useSystemFont) {
                  //                         NativeFeatures.loadSystemFont()
                  //                             .then((val) {
                  //                               settingsProvider
                  //                                       .useSystemFont =
                  //                                   true;
                  //                             });
                  //                       } else {
                  //                         settingsProvider.useSystemFont =
                  //                             false;
                  //                       }
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           )
                  //         : const SizedBox.shrink();
                  //   },
                  //   future: DeviceInfoPlugin().androidInfo,
                  // ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(child: Text(tr('showWebInAppView'))),
                      Switch(
                        value: settingsProvider.showAppWebpage,
                        onChanged: (value) {
                          settingsProvider.showAppWebpage = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(child: Text(tr('pinUpdates'))),
                      Switch(
                        value: settingsProvider.pinUpdates,
                        onChanged: (value) {
                          settingsProvider.pinUpdates = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(
                        child: Text(tr('moveNonInstalledAppsToBottom')),
                      ),
                      Switch(
                        value: settingsProvider.buryNonInstalled,
                        onChanged: (value) {
                          settingsProvider.buryNonInstalled = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(child: Text(tr('groupByCategory'))),
                      Switch(
                        value: settingsProvider.groupByCategory,
                        onChanged: (value) {
                          settingsProvider.groupByCategory = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(
                        child: Text(tr('dontShowTrackOnlyWarnings')),
                      ),
                      Switch(
                        value: settingsProvider.hideTrackOnlyWarning,
                        onChanged: (value) {
                          settingsProvider.hideTrackOnlyWarning = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(
                        child: Text(tr('dontShowAPKOriginWarnings')),
                      ),
                      Switch(
                        value: settingsProvider.hideAPKOriginWarning,
                        onChanged: (value) {
                          settingsProvider.hideAPKOriginWarning = value;
                        },
                      ),
                    ],
                  ),
                  height16,
                  // TODO: uncomment when transitions are reintroduced
                  // Flex.horizontal(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Flexible.loose(child: Text(tr('disablePageTransitions'))),
                  //     Switch(
                  //       value: settingsProvider.disablePageTransitions,
                  //       onChanged: (value) {
                  //         settingsProvider.disablePageTransitions = value;
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // height16,
                  // Flex.horizontal(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Flexible.loose(child: Text(tr('reversePageTransitions'))),
                  //     Switch(
                  //       value: settingsProvider.reversePageTransitions,
                  //       onChanged: settingsProvider.disablePageTransitions
                  //           ? null
                  //           : (value) {
                  //               settingsProvider.reversePageTransitions =
                  //                   value;
                  //             },
                  //     ),
                  //   ],
                  // ),
                  // height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible.loose(child: Text(tr('highlightTouchTargets'))),
                      Switch(
                        value: settingsProvider.highlightTouchTargets,
                        onChanged: (value) {
                          settingsProvider.highlightTouchTargets = value;
                        },
                      ),
                    ],
                  ),
                  height32,
                  Text(
                    tr('categories'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.of(context).primary,
                    ),
                  ),
                  height16,
                  const CategoryEditorSelector(showLabelWhenNotEmpty: false),
                  height16,
                  Flex.horizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          launchUrlString(
                            SettingsProvider.sourceUrl,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        style: footerButtonsStyle,
                        icon: const IconLegacy(Symbols.code),
                        tooltip: tr('appSource'),
                      ),
                      IconButton(
                        onPressed: () {
                          launchUrlString(
                            'https://wiki.obtainium.imranr.dev/',
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        style: footerButtonsStyle,
                        icon: const IconLegacy(Symbols.help_rounded, fill: 1.0),
                        tooltip: tr('wiki'),
                      ),
                      IconButton(
                        onPressed: () {
                          launchUrlString(
                            'https://apps.obtainium.imranr.dev/',
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        style: footerButtonsStyle,
                        icon: const IconLegacy(Symbols.apps_rounded),
                        tooltip: tr('crowdsourcedConfigsLabel'),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<LogsProvider>().get().then((logs) {
                            if (!context.mounted) return;
                            if (logs.isEmpty) {
                              showMessage(
                                ObtainiumError(tr('noLogs')),
                                context,
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return const LogsDialog();
                                },
                              );
                            }
                          });
                        },
                        style: footerButtonsStyle,
                        icon: const IconLegacy(
                          Symbols.bug_report_rounded,
                          fill: 1.0,
                        ),
                        tooltip: tr('appLogs'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogsDialog extends StatefulWidget {
  const LogsDialog({super.key});

  @override
  State<LogsDialog> createState() => _LogsDialogState();
}

class _LogsDialogState extends State<LogsDialog> {
  String? logString;
  List<int> days = [7, 5, 4, 3, 2, 1];

  @override
  Widget build(BuildContext context) {
    final logsProvider = context.read<LogsProvider>();
    void filterLogs(int days) {
      logsProvider
          .get(after: DateTime.now().subtract(Duration(days: days)))
          .then((value) {
            setState(() {
              String l = value.map((e) => e.toString()).join('\n\n');
              logString = l.isNotEmpty ? l : tr('noLogs');
            });
          });
    }

    if (logString == null) {
      filterLogs(days.first);
    }

    return AlertDialog(
      scrollable: true,
      title: Text(tr('appLogs')),
      content: Flex.vertical(
        children: [
          DropdownMenuFormField<int>(
            expandedInsets: EdgeInsets.zero,
            inputDecorationTheme: const InputDecorationThemeData(
              border: OutlineInputBorder(),
            ),
            initialSelection: days.first,
            dropdownMenuEntries: days
                .map(
                  (e) => DropdownMenuEntry(value: e, label: plural("day", e)),
                )
                .toList(),
            onSelected: (d) {
              filterLogs(d ?? 7);
            },
          ),
          const SizedBox(height: 32),
          Text(logString ?? ''),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final cont =
                (await showDialog<Map<String, dynamic>?>(
                  context: context,
                  builder: (ctx) {
                    return GeneratedFormModal(
                      title: tr('appLogs'),
                      items: const [],
                      initValid: true,
                      message: tr('removeFromObtainium'),
                    );
                  },
                )) !=
                null;
            if (cont) {
              logsProvider.clear();
              if (context.mounted) Navigator.of(context).pop();
            }
          },
          child: Text(tr('remove')),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(tr('close')),
        ),
        TextButton(
          onPressed: () {
            SharePlus.instance.share(
              ShareParams(text: logString ?? '', subject: tr('appLogs')),
            );
            Navigator.of(context).pop();
          },
          child: Text(tr('share')),
        ),
      ],
    );
  }
}

class CategoryEditorSelector extends StatefulWidget {
  final void Function(List<String> categories)? onSelected;
  final bool singleSelect;
  final Set<String> preselected;
  final WrapAlignment alignment;
  final bool showLabelWhenNotEmpty;
  const CategoryEditorSelector({
    super.key,
    this.onSelected,
    this.singleSelect = false,
    this.preselected = const {},
    this.alignment = WrapAlignment.start,
    this.showLabelWhenNotEmpty = true,
  });

  @override
  State<CategoryEditorSelector> createState() => _CategoryEditorSelectorState();
}

class _CategoryEditorSelectorState extends State<CategoryEditorSelector> {
  Map<String, MapEntry<int, bool>> storedValues = {};

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final appsProvider = context.watch<AppsProvider>();
    storedValues = settingsProvider.categories.map(
      (key, value) => MapEntry(
        key,
        MapEntry(
          value,
          storedValues[key]?.value ?? widget.preselected.contains(key),
        ),
      ),
    );
    return GeneratedForm(
      items: [
        [
          GeneratedFormTagInput(
            'categories',
            label: tr('categories'),
            emptyMessage: tr('noCategories'),
            defaultValue: storedValues,
            alignment: widget.alignment,
            deleteConfirmationMessage: MapEntry(
              tr('deleteCategoriesQuestion'),
              tr('categoryDeleteWarning'),
            ),
            singleSelect: widget.singleSelect,
            showLabelWhenNotEmpty: widget.showLabelWhenNotEmpty,
          ),
        ],
      ],
      onValueChanges: ((values, valid, isBuilding) {
        if (!isBuilding) {
          storedValues =
              values['categories'] as Map<String, MapEntry<int, bool>>;
          settingsProvider.setCategories(
            storedValues.map((key, value) => MapEntry(key, value.key)),
            appsProvider: appsProvider,
          );
          if (widget.onSelected != null) {
            widget.onSelected!(
              storedValues.keys.where((k) => storedValues[k]!.value).toList(),
            );
          }
        }
      }),
    );
  }
}

class SliverSettingsList extends StatelessWidget {
  const SliverSettingsList({super.key, required this.items});

  final List<SettingsListItem> items;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final shapeTheme = ShapeTheme.of(context);
    final lastIndex = items.length - 1;
    return SliverList.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isFirst = index == 0;
        final isLast = index == lastIndex;
        final edgeCorner = shapeTheme.corner.largeIncreased;
        final middleCorner = shapeTheme.corner.extraSmall;
        final shape = CornersBorder.rounded(
          corners: Corners.vertical(
            top: isFirst ? edgeCorner : middleCorner,
            bottom: isLast ? edgeCorner : middleCorner,
          ),
        );
        return Material(
          animationDuration: Duration.zero,
          type: MaterialType.card,
          clipBehavior: Clip.antiAlias,
          color: colorTheme.surfaceBright,
          elevation: 0.0,
          shape: shape,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: item.onTap,
            onLongPress: item.onLongPress,
            child: SettingsListItemLayout(
              leading: item.leading,
              headline: item.headline,
              supportingText: item.supportingText,
              trailing: item.trailing,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 2.0),
    );
  }
}

class SettingsListItem with Diagnosticable {
  const SettingsListItem({
    this.key,
    this.onTap,
    this.onLongPress,
    this.leading,
    required this.headline,
    this.supportingText,
    this.trailing,
    this.bottom,
  });

  final Key? key;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? leading;
  final Widget headline;
  final Widget? supportingText;
  final Widget? trailing;
  final Widget? bottom;
}

class SettingsListItemLayout extends StatefulWidget {
  const SettingsListItemLayout({
    super.key,
    this.leading,
    required this.headline,
    this.supportingText,
    this.trailing,
  });

  final Widget? leading;
  final Widget headline;
  final Widget? supportingText;
  final Widget? trailing;

  @override
  State<SettingsListItemLayout> createState() => _SettingsListItemLayoutState();
}

class _SettingsListItemLayoutState extends State<SettingsListItemLayout> {
  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.supportingText != null ? 72.0 : 56.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: widget.supportingText != null ? 12.0 : 8.0,
        ),
        child: Flex.horizontal(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.leading case final leading?) ...[
              leading,
              const SizedBox(width: 12.0),
            ],
            Flexible.tight(
              child: Flex.vertical(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DefaultTextStyle(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: typescaleTheme.titleMediumEmphasized.toTextStyle(
                      color: colorTheme.onSurface,
                    ),
                    child: widget.headline,
                  ),
                  if (widget.supportingText case final supportingText?)
                    DefaultTextStyle(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: typescaleTheme.bodyMedium.toTextStyle(
                        color: colorTheme.onSurfaceVariant,
                      ),
                      child: supportingText,
                    ),
                ],
              ),
            ),
            if (widget.trailing case final trailing?) ...[
              const SizedBox(width: 12.0),
              trailing,
            ],
          ],
        ),
      ),
    );
  }
}
