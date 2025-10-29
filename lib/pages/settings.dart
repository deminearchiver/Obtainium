import 'package:device_info_plus/device_info_plus.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equations/equations.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:obtainium/components/custom_list.dart';
import 'package:obtainium/components/custom_progress_indicator.dart';
import 'package:obtainium/flutter.dart';
import 'package:obtainium/components/custom_app_bar.dart';
import 'package:obtainium/components/generated_form.dart';
import 'package:obtainium/components/generated_form_modal.dart';
import 'package:obtainium/custom_errors.dart';
import 'package:obtainium/main.dart';
import 'package:obtainium/pages/developer.dart';
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

    final colorTheme = ColorTheme.of(context);
    final shapeTheme = ShapeTheme.of(context);
    final stateTheme = StateTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);

    initUpdateIntervalInterpolator();
    processIntervalSliderValue(settingsProvider.updateIntervalSliderVal);

    void onUseShizukuChanged(bool useShizuku) {
      if (useShizuku) {
        ShizukuApkInstaller.checkPermission().then((resCode) {
          settingsProvider.useShizuku = resCode!.startsWith('granted');
          if (!context.mounted) return;
          switch (resCode) {
            case 'binder_not_found':
              showError(ObtainiumError(tr('shizukuBinderNotFound')), context);
            case 'old_shizuku':
              showError(ObtainiumError(tr('shizukuOld')), context);
            case 'old_android_with_adb':
              showError(
                ObtainiumError(tr('shizukuOldAndroidWithADB')),
                context,
              );
            case 'denied':
              showError(ObtainiumError(tr('cancelled')), context);
          }
        });
      } else {
        settingsProvider.useShizuku = false;
      }
    }

    final Widget followSystemThemeExplanation = FutureBuilder(
      builder: (ctx, val) {
        return ((val.data?.version.sdkInt ?? 30) < 29)
            ? Text(
                tr('followSystemThemeExplanation'),
                style: typescaleTheme.labelSmall.toTextStyle(),
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
          style: typescaleTheme.titleLarge.toTextStyle(),
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
        materialNameTextStyle: typescaleTheme.bodySmall.toTextStyle(),
        colorNameTextStyle: typescaleTheme.bodySmall.toTextStyle(),
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
      future: const DynamicColor().isDynamicColorAvailable(),
      builder: (ctx, snapshot) {
        final isDynamicColorAvailable = snapshot.data ?? false;
        if (!isDynamicColorAvailable) return const SizedBox.shrink();
        return _ListItemContainer(
          isFirst: true,
          isLast: true,
          child: MergeSemantics(
            child: ListItemInteraction(
              onTap: () => settingsProvider.useMaterialYou =
                  !settingsProvider.useMaterialYou,
              child: ListItemLayout(
                isMultiline: true,
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  12.0,
                  16.0 - 8.0,
                  12.0,
                ),
                headline: Text(tr("useMaterialYou"), maxLines: 2),
                trailing: ExcludeFocus(
                  child: Switch(
                    onCheckedChanged: (value) =>
                        settingsProvider.useMaterialYou = value,
                    checked: settingsProvider.useMaterialYou,
                  ),
                ),
              ),
            ),
          ),
        );
        // return Flex.horizontal(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Flexible.loose(child: Text(tr('useMaterialYou'))),
        //     Switch(
        //       value: settingsProvider.useMaterialYou,
        //       onChanged: (value) {
        //         settingsProvider.useMaterialYou = value;
        //       },
        //     ),
        //   ],
        // );
      },
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
      onChanged: (value) => setState(() {
        settingsProvider.updateIntervalSliderVal = value;
        processIntervalSliderValue(value);
      }),
      onChangeStart: (value) => setState(() {
        showIntervalLabel = false;
      }),
      onChangeEnd: (value) => setState(() {
        showIntervalLabel = true;
        settingsProvider.updateInterval = updateInterval;
      }),
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

    const Widget height4 = SizedBox(height: 4.0);

    const Widget height8 = SizedBox(height: 8.0);

    const Widget height12 = SizedBox(height: 12.0);

    const Widget height16 = SizedBox(height: 16.0);

    const Widget height24 = SizedBox(height: 24.0);

    const Widget height32 = SizedBox(height: 32.0);

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
        CornersBorder.rounded(corners: Corners.all(shapeTheme.corner.full)),
      ),
      overlayColor: WidgetStateLayerColor(
        color: WidgetStatePropertyAll(colorTheme.onSurfaceVariant),
        opacity: stateTheme.stateLayerOpacity,
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? colorTheme.onSurface.withValues(alpha: 0.1)
            : colorTheme.surfaceBright,
      ),
      iconColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? colorTheme.onSurface.withValues(alpha: 0.38)
            : colorTheme.onSurfaceVariant,
      ),
    );

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(
            type: CustomAppBarType.largeFlexible,
            behavior: CustomAppBarBehavior.duplicate,
            expandedContainerColor: colorTheme.surfaceContainer,
            collapsedContainerColor: colorTheme.surfaceContainer,
            title: Text(tr("settings")),
            // subtitle: kDebugMode ? const Text("Debug mode") : null,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            sliver: SliverList.list(
              children: [
                if (kDebugMode) ...[
                  _ListItemContainer(
                    isFirst: true,
                    isLast: true,
                    child: MergeSemantics(
                      child: ListItemInteraction(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DeveloperPage(),
                          ),
                        ),
                        child: const ListItemLayout(
                          isMultiline: true,
                          leading: Icon(Symbols.developer_mode_rounded),
                          headline: Text("Developer options"),
                          supportingText: Text("Options for developers"),
                          trailing: Icon(Symbols.keyboard_arrow_right_rounded),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    tr("updates"),
                    style: typescaleTheme.labelLarge.toTextStyle(
                      color: colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
                height8,
                _ListItemContainer(
                  isFirst: true,
                  child: Flex.vertical(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListItemLayout(
                        isMultiline: true,
                        headline: Text(tr("bgUpdateCheckInterval")),
                        supportingText: Visibility.maintain(
                          visible: showIntervalLabel,
                          child: Text(updateIntervalLabel, maxLines: 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          0.0,
                          16.0,
                          12.0,
                        ),
                        child: intervalSlider,
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  builder: (ctx, val) {
                    return (settingsProvider.updateInterval > 0) &&
                            (((val.data?.version.sdkInt ?? 0) >= 30) ||
                                settingsProvider.useShizuku)
                        ? Flex.vertical(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2.0),
                              _ListItemContainer(
                                child: MergeSemantics(
                                  child: ListItemInteraction(
                                    onTap: () => settingsProvider.useFGService =
                                        !settingsProvider.useFGService,
                                    child: ListItemLayout(
                                      isMultiline: true,
                                      padding: const EdgeInsets.fromLTRB(
                                        16.0,
                                        12.0,
                                        16.0 - 8.0,
                                        12.0,
                                      ),
                                      headline: Text(
                                        tr("foregroundServiceExplanation"),
                                        maxLines: 3,
                                      ),
                                      trailing: ExcludeFocus(
                                        child: Switch(
                                          onCheckedChanged: (value) =>
                                              settingsProvider.useFGService =
                                                  value,
                                          checked:
                                              settingsProvider.useFGService,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              _ListItemContainer(
                                child: Flex.vertical(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MergeSemantics(
                                      child: ListItemInteraction(
                                        onTap: () =>
                                            settingsProvider
                                                    .enableBackgroundUpdates =
                                                !settingsProvider
                                                    .enableBackgroundUpdates,
                                        child: ListItemLayout(
                                          isMultiline: false,
                                          padding: const EdgeInsets.fromLTRB(
                                            16.0,
                                            8.0,
                                            16.0 - 8.0,
                                            8.0,
                                          ),
                                          headline: Text(
                                            tr("enableBackgroundUpdates"),
                                          ),
                                          trailing: ExcludeFocus(
                                            child: Switch(
                                              onCheckedChanged: (value) =>
                                                  settingsProvider
                                                          .enableBackgroundUpdates =
                                                      value,
                                              checked: settingsProvider
                                                  .enableBackgroundUpdates,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        16.0,
                                        0.0,
                                        16.0,
                                        12.0,
                                      ),
                                      child: DefaultTextStyle(
                                        style: TypescaleTheme.of(context)
                                            .bodyMedium
                                            .toTextStyle(
                                              color:
                                                  colorTheme.onSurfaceVariant,
                                            ),
                                        child: Flex.vertical(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 8.0,
                                          children: [
                                            Text(
                                              tr(
                                                'backgroundUpdateReqsExplanation',
                                              ),
                                            ),
                                            Text(
                                              tr(
                                                'backgroundUpdateLimitsExplanation',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (settingsProvider.enableBackgroundUpdates)
                                Flex.vertical(
                                  children: [
                                    const SizedBox(height: 2.0),
                                    _ListItemContainer(
                                      child: MergeSemantics(
                                        child: ListItemInteraction(
                                          onTap: () =>
                                              settingsProvider
                                                      .bgUpdatesOnWiFiOnly =
                                                  !settingsProvider
                                                      .bgUpdatesOnWiFiOnly,
                                          child: ListItemLayout(
                                            isMultiline: true,
                                            padding: const EdgeInsets.fromLTRB(
                                              16.0,
                                              12.0,
                                              16.0 - 8.0,
                                              12.0,
                                            ),
                                            headline: Text(
                                              tr("bgUpdatesOnWiFiOnly"),
                                              maxLines: 3,
                                            ),
                                            trailing: ExcludeFocus(
                                              child: Switch(
                                                onCheckedChanged: (value) =>
                                                    settingsProvider
                                                            .bgUpdatesOnWiFiOnly =
                                                        value,
                                                checked: settingsProvider
                                                    .bgUpdatesOnWiFiOnly,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    _ListItemContainer(
                                      child: MergeSemantics(
                                        child: ListItemInteraction(
                                          onTap: () =>
                                              settingsProvider
                                                      .bgUpdatesWhileChargingOnly =
                                                  !settingsProvider
                                                      .bgUpdatesWhileChargingOnly,
                                          child: ListItemLayout(
                                            isMultiline: true,
                                            padding: const EdgeInsets.fromLTRB(
                                              16.0,
                                              12.0,
                                              16.0 - 8.0,
                                              12.0,
                                            ),
                                            headline: Text(
                                              tr("bgUpdatesWhileChargingOnly"),
                                              maxLines: 3,
                                            ),
                                            trailing: ExcludeFocus(
                                              child: Switch(
                                                onCheckedChanged: (value) =>
                                                    settingsProvider
                                                            .bgUpdatesWhileChargingOnly =
                                                        value,
                                                checked: settingsProvider
                                                    .bgUpdatesWhileChargingOnly,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )
                        : const SizedBox.shrink();
                  },
                  future: DeviceInfoPlugin().androidInfo,
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.checkOnStart =
                          !settingsProvider.checkOnStart,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(tr("checkOnStart"), maxLines: 3),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.checkOnStart = value,
                            checked: settingsProvider.checkOnStart,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.checkUpdateOnDetailPage =
                          !settingsProvider.checkUpdateOnDetailPage,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(
                          tr("checkUpdateOnDetailPage"),
                          maxLines: 3,
                        ),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.checkUpdateOnDetailPage =
                                    value,
                            checked: settingsProvider.checkUpdateOnDetailPage,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () =>
                          settingsProvider.onlyCheckInstalledOrTrackOnlyApps =
                              !settingsProvider
                                  .onlyCheckInstalledOrTrackOnlyApps,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(
                          tr("onlyCheckInstalledOrTrackOnlyApps"),
                          maxLines: 3,
                        ),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider
                                        .onlyCheckInstalledOrTrackOnlyApps =
                                    value,
                            checked: settingsProvider
                                .onlyCheckInstalledOrTrackOnlyApps,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: ListItemInteraction(
                    onTap: () => settingsProvider.removeOnExternalUninstall =
                        !settingsProvider.removeOnExternalUninstall,
                    child: ListItemLayout(
                      isMultiline: true,
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        12.0,
                        16.0 - 8.0,
                        12.0,
                      ),
                      headline: Text(
                        tr("removeOnExternalUninstall"),
                        maxLines: 3,
                      ),
                      trailing: ExcludeFocus(
                        child: Switch(
                          onCheckedChanged: (value) =>
                              settingsProvider.removeOnExternalUninstall =
                                  value,
                          checked: settingsProvider.removeOnExternalUninstall,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.parallelDownloads =
                          !settingsProvider.parallelDownloads,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(tr("parallelDownloads"), maxLines: 3),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.parallelDownloads = value,
                            checked: settingsProvider.parallelDownloads,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: Flex.vertical(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MergeSemantics(
                        child: ListItemInteraction(
                          onTap: () =>
                              settingsProvider
                                      .beforeNewInstallsShareToAppVerifier =
                                  !settingsProvider
                                      .beforeNewInstallsShareToAppVerifier,
                          child: ListItemLayout(
                            isMultiline: true,
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              12.0,
                              16.0 - 8.0,
                              12.0,
                            ),
                            headline: Text(
                              tr("beforeNewInstallsShareToAppVerifier"),
                              maxLines: 3,
                            ),
                            trailing: ExcludeFocus(
                              child: Switch(
                                onCheckedChanged: (value) =>
                                    settingsProvider
                                            .beforeNewInstallsShareToAppVerifier =
                                        value,
                                checked: settingsProvider
                                    .beforeNewInstallsShareToAppVerifier,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListItemInteraction(
                        onTap: () => launchUrlString(
                          "https://github.com/soupslurpr/AppVerifier",
                          mode: LaunchMode.externalApplication,
                        ),
                        child: ListItemLayout(
                          leading: const Icon(Symbols.open_in_new_rounded),
                          supportingText: Text(tr("about")),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () =>
                          onUseShizukuChanged(!settingsProvider.useShizuku),
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(tr("useShizuku"), maxLines: 3),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: onUseShizukuChanged,
                            checked: settingsProvider.useShizuku,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  isLast: true,
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () =>
                          settingsProvider.shizukuPretendToBeGooglePlay =
                              !settingsProvider.shizukuPretendToBeGooglePlay,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(
                          tr("shizukuPretendToBeGooglePlay"),
                          maxLines: 3,
                        ),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.shizukuPretendToBeGooglePlay =
                                    value,
                            checked:
                                settingsProvider.shizukuPretendToBeGooglePlay,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0 + 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    tr("sourceSpecific"),
                    style: typescaleTheme.labelLarge.toTextStyle(
                      color: colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
                height8,
                ...sourceSpecificFields,
                const SizedBox(height: 12.0 + 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    tr("appearance"),
                    style: typescaleTheme.labelLarge.toTextStyle(
                      color: colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
                height8,
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
                height4,
                useMaterialThemeSwitch,
                height12,
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
                height16,
                _ListItemContainer(
                  isFirst: true,
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.showAppWebpage =
                          !settingsProvider.showAppWebpage,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(tr("showWebInAppView"), maxLines: 3),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.showAppWebpage = value,
                            checked: settingsProvider.showAppWebpage,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.pinUpdates =
                          !settingsProvider.pinUpdates,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(tr("pinUpdates"), maxLines: 3),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.pinUpdates = value,
                            checked: settingsProvider.pinUpdates,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.buryNonInstalled =
                          !settingsProvider.buryNonInstalled,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(
                          tr("moveNonInstalledAppsToBottom"),
                          maxLines: 3,
                        ),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.buryNonInstalled = value,
                            checked: settingsProvider.buryNonInstalled,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.groupByCategory =
                          !settingsProvider.groupByCategory,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(tr("groupByCategory"), maxLines: 3),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.groupByCategory = value,
                            checked: settingsProvider.groupByCategory,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.hideTrackOnlyWarning =
                          !settingsProvider.hideTrackOnlyWarning,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(
                          tr("dontShowTrackOnlyWarnings"),
                          maxLines: 3,
                        ),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.hideTrackOnlyWarning = value,
                            checked: settingsProvider.hideTrackOnlyWarning,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  isLast: true,
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => settingsProvider.hideAPKOriginWarning =
                          !settingsProvider.hideAPKOriginWarning,
                      child: ListItemLayout(
                        isMultiline: true,
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0 - 8.0,
                          12.0,
                        ),
                        headline: Text(
                          tr("dontShowAPKOriginWarnings"),
                          maxLines: 3,
                        ),
                        trailing: ExcludeFocus(
                          child: Switch(
                            onCheckedChanged: (value) =>
                                settingsProvider.hideAPKOriginWarning = value,
                            checked: settingsProvider.hideAPKOriginWarning,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 2.0),
                // _ListItemContainer(
                //   isLast: true,
                //   child: MergeSemantics(
                //     child: ListItemInteraction(
                //       onTap: () => settingsProvider.highlightTouchTargets =
                //           !settingsProvider.highlightTouchTargets,
                //       child: ListItemLayout(
                //         isMultiline: true,
                //         padding: const EdgeInsets.fromLTRB(
                //           16.0,
                //           12.0,
                //           16.0 - 8.0,
                //           12.0,
                //         ),
                //         headline: Text(
                //           tr("highlightTouchTargets"),
                //           maxLines: 3,
                //         ),
                //         trailing: ExcludeFocus(
                //           child: Switch(
                //             onCheckedChanged: (value) =>
                //                 settingsProvider.highlightTouchTargets = value,
                //             checked: settingsProvider.highlightTouchTargets,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 12.0 + 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    tr("categories"),
                    style: typescaleTheme.labelLarge.toTextStyle(
                      color: colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
                height16,
                const CategoryEditorSelector(showLabelWhenNotEmpty: false),
                height16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    tr("about"),
                    style: typescaleTheme.labelLarge.toTextStyle(
                      color: colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
                height8,
                _ListItemContainer(
                  isFirst: true,
                  child: ListItemInteraction(
                    onTap: () => launchUrlString(
                      SettingsProvider.sourceUrl,
                      mode: LaunchMode.externalApplication,
                    ),
                    child: ListItemLayout(
                      isMultiline: true,
                      leading: const Icon(Symbols.code_rounded),
                      headline: Text(tr("appSource"), maxLines: 3),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: ListItemInteraction(
                    onTap: () => launchUrlString(
                      "https://wiki.obtainium.imranr.dev/",
                      mode: LaunchMode.externalApplication,
                    ),
                    child: ListItemLayout(
                      isMultiline: true,
                      leading: const Icon(Symbols.help_rounded, fill: 1.0),
                      headline: Text(tr("wiki"), maxLines: 3),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  child: ListItemInteraction(
                    onTap: () => launchUrlString(
                      "https://apps.obtainium.imranr.dev/",
                      mode: LaunchMode.externalApplication,
                    ),
                    child: ListItemLayout(
                      isMultiline: true,
                      leading: const Icon(Symbols.apps_rounded),
                      headline: Text(
                        tr("crowdsourcedConfigsLabel"),
                        maxLines: 3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                _ListItemContainer(
                  isLast: true,
                  child: ListItemInteraction(
                    onTap: () =>
                        context.read<LogsProvider>().get().then((logs) {
                          if (!context.mounted) return;
                          if (logs.isEmpty) {
                            showMessage(ObtainiumError(tr('noLogs')), context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return const LogsDialog();
                              },
                            );
                          }
                        }),
                    child: ListItemLayout(
                      isMultiline: true,
                      leading: const Icon(
                        Symbols.bug_report_rounded,
                        fill: 1.0,
                      ),
                      headline: Text(tr("appLogs"), maxLines: 3),
                    ),
                  ),
                ),
              ],
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

class _ListItemContainer extends StatelessWidget {
  const _ListItemContainer({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    required this.child,
  });

  final bool isFirst;
  final bool isLast;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final shapeTheme = ShapeTheme.of(context);
    final edgeCorner = shapeTheme.corner.largeIncreased;
    final middleCorner = shapeTheme.corner.extraSmall;
    return Material(
      animationDuration: Duration.zero,
      type: MaterialType.card,
      clipBehavior: Clip.antiAlias,
      color: colorTheme.surfaceBright,
      shape: CornersBorder.rounded(
        corners: Corners.vertical(
          top: isFirst ? edgeCorner : middleCorner,
          bottom: isLast ? edgeCorner : middleCorner,
        ),
      ),
      child: child,
    );
  }
}
