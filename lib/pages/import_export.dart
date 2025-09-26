import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart' show CupertinoScrollBehavior;
import 'package:obtainium/flutter.dart';
import 'package:obtainium/app_sources/fdroidrepo.dart';
import 'package:obtainium/components/custom_app_bar.dart';
import 'package:obtainium/components/generated_form.dart';
import 'package:obtainium/components/generated_form_modal.dart';
import 'package:obtainium/custom_errors.dart';
import 'package:obtainium/providers/apps_provider.dart';
import 'package:obtainium/providers/settings_provider.dart';
import 'package:obtainium/providers/source_provider.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ImportExportPage extends StatefulWidget {
  const ImportExportPage({super.key});

  @override
  State<ImportExportPage> createState() => _ImportExportPageState();
}

class _ImportExportPageState extends State<ImportExportPage> {
  bool importInProgress = false;

  @override
  Widget build(BuildContext context) {
    final sourceProvider = SourceProvider();
    final appsProvider = context.watch<AppsProvider>();
    final settingsProvider = context.watch<SettingsProvider>();

    void urlListImport({String? initValue, bool overrideInitValid = false}) {
      showDialog<Map<String, dynamic>?>(
        context: context,
        builder: (ctx) {
          return GeneratedFormModal(
            initValid: overrideInitValid,
            title: tr('importFromURLList'),
            items: [
              [
                GeneratedFormTextField(
                  'appURLList',
                  defaultValue: initValue ?? '',
                  label: tr('appURLList'),
                  max: 7,
                  additionalValidators: [
                    (dynamic value) {
                      if (value != null && value.isNotEmpty) {
                        var lines = value.trim().split('\n');
                        for (int i = 0; i < lines.length; i++) {
                          try {
                            sourceProvider.getSource(lines[i]);
                          } catch (e) {
                            return '${tr('line')} ${i + 1}: $e';
                          }
                        }
                      }
                      return null;
                    },
                  ],
                ),
              ],
            ],
          );
        },
      ).then((values) {
        if (values != null) {
          var urls = (values['appURLList'] as String).split('\n');
          setState(() {
            importInProgress = true;
          });
          appsProvider
              .addAppsByURL(urls)
              .then((errors) {
                if (errors.isEmpty) {
                  showMessage(
                    tr(
                      'importedX',
                      args: [plural('apps', urls.length).toLowerCase()],
                    ),
                    context,
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return ImportErrorDialog(
                        urlsLength: urls.length,
                        errors: errors,
                      );
                    },
                  );
                }
              })
              .catchError((e) {
                showError(e, context);
              })
              .whenComplete(() {
                setState(() {
                  importInProgress = false;
                });
              });
        }
      });
    }

    Future<void> runObtainiumExport({bool pickOnly = false}) async {
      HapticFeedback.selectionClick();
      appsProvider
          .export(
            pickOnly:
                pickOnly || (await settingsProvider.getExportDir()) == null,
            sp: settingsProvider,
          )
          .then((String? result) {
            if (result != null) {
              showMessage(tr('exportedTo', args: [result]), context);
            }
          })
          .catchError((e) {
            showError(e, context);
          });
    }

    void runObtainiumImport() {
      HapticFeedback.selectionClick();
      FilePicker.platform
          .pickFiles()
          .then((result) {
            setState(() {
              importInProgress = true;
            });
            if (result != null) {
              String data = File(result.files.single.path!).readAsStringSync();
              try {
                jsonDecode(data);
              } catch (e) {
                throw ObtainiumError(tr('invalidInput'));
              }
              appsProvider.import(data).then((value) {
                var cats = settingsProvider.categories;
                appsProvider.apps.forEach((key, value) {
                  for (var c in value.app.categories) {
                    if (!cats.containsKey(c)) {
                      cats[c] = generateRandomLightColor().toARGB32();
                    }
                  }
                });
                appsProvider.addMissingCategories(settingsProvider);
                showMessage(
                  '${tr('importedX', args: [plural('apps', value.key.length).toLowerCase()])}${value.value ? ' + ${tr('settings').toLowerCase()}' : ''}',
                  context,
                );
              });
            } else {
              // User canceled the picker
            }
          })
          .catchError((e) {
            showError(e, context);
          })
          .whenComplete(() {
            setState(() {
              importInProgress = false;
            });
          });
    }

    void runUrlImport() {
      FilePicker.platform.pickFiles().then((result) {
        if (result != null) {
          urlListImport(
            overrideInitValid: true,
            initValue: RegExp('https?://[^"]+')
                .allMatches(File(result.files.single.path!).readAsStringSync())
                .map((e) => e.input.substring(e.start, e.end))
                .toSet()
                .toList()
                .where((url) {
                  try {
                    sourceProvider.getSource(url);
                    return true;
                  } catch (e) {
                    return false;
                  }
                })
                .join('\n'),
          );
        }
      });
    }

    void runSourceSearch(AppSource source) {
      () async {
            var values = await showDialog<Map<String, dynamic>?>(
              context: context,
              builder: (ctx) {
                return GeneratedFormModal(
                  title: tr('searchX', args: [source.name]),
                  items: [
                    [
                      GeneratedFormTextField(
                        'searchQuery',
                        label: tr('searchQuery'),
                        required: source.name != FDroidRepo().name,
                      ),
                    ],
                    ...source.searchQuerySettingFormItems.map((e) => [e]),
                    [
                      GeneratedFormTextField(
                        'url',
                        label: source.hosts.isNotEmpty
                            ? tr('overrideSource')
                            : plural('url', 1).substring(2),
                        defaultValue: source.hosts.isNotEmpty
                            ? source.hosts[0]
                            : '',
                        required: true,
                      ),
                    ],
                  ],
                );
              },
            );
            if (values != null) {
              setState(() {
                importInProgress = true;
              });
              if (source.hosts.isEmpty || values['url'] != source.hosts[0]) {
                source = sourceProvider.getSource(
                  values['url'],
                  overrideSource: source.runtimeType.toString(),
                );
              }
              var urlsWithDescriptions = await source.search(
                values['searchQuery'] as String,
                querySettings: values,
              );
              if (urlsWithDescriptions.isNotEmpty) {
                var selectedUrls = await showDialog<List<String>?>(
                  context: context,
                  builder: (ctx) {
                    return SelectionModal(
                      entries: urlsWithDescriptions,
                      selectedByDefault: false,
                    );
                  },
                );
                if (selectedUrls != null && selectedUrls.isNotEmpty) {
                  var errors = await appsProvider.addAppsByURL(
                    selectedUrls,
                    sourceOverride: source,
                  );
                  if (errors.isEmpty) {
                    showMessage(
                      tr(
                        'importedX',
                        args: [
                          plural('apps', selectedUrls.length).toLowerCase(),
                        ],
                      ),
                      context,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return ImportErrorDialog(
                          urlsLength: selectedUrls.length,
                          errors: errors,
                        );
                      },
                    );
                  }
                }
              } else {
                throw ObtainiumError(tr('noResults'));
              }
            }
          }()
          .catchError((e) {
            showError(e, context);
          })
          .whenComplete(() {
            setState(() {
              importInProgress = false;
            });
          });
    }

    void runMassSourceImport(MassAppUrlSource source) {
      () async {
            var values = await showDialog<Map<String, dynamic>?>(
              context: context,
              builder: (ctx) {
                return GeneratedFormModal(
                  title: tr('importX', args: [source.name]),
                  items: source.requiredArgs
                      .map((e) => [GeneratedFormTextField(e, label: e)])
                      .toList(),
                );
              },
            );
            if (values != null) {
              setState(() {
                importInProgress = true;
              });
              var urlsWithDescriptions = await source.getUrlsWithDescriptions(
                values.values.map((e) => e.toString()).toList(),
              );
              var selectedUrls = await showDialog<List<String>?>(
                context: context,
                builder: (ctx) {
                  return SelectionModal(entries: urlsWithDescriptions);
                },
              );
              if (selectedUrls != null) {
                var errors = await appsProvider.addAppsByURL(selectedUrls);
                if (errors.isEmpty) {
                  showMessage(
                    tr(
                      'importedX',
                      args: [plural('apps', selectedUrls.length).toLowerCase()],
                    ),
                    context,
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return ImportErrorDialog(
                        urlsLength: selectedUrls.length,
                        errors: errors,
                      );
                    },
                  );
                }
              }
            }
          }()
          .catchError((e) {
            showError(e, context);
          })
          .whenComplete(() {
            setState(() {
              importInProgress = false;
            });
          });
    }

    var sourceStrings = <String, List<String>>{};
    sourceProvider.sources.where((e) => e.canSearch).forEach((s) {
      sourceStrings[s.name] = [s.name];
    });

    return Scaffold(
      backgroundColor: ColorTheme.of(context).surfaceContainer,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar.largeFlexible(
            expandedContainerColor: ColorTheme.of(context).surfaceContainer,
            collapsedContainerColor: ColorTheme.of(context).surfaceContainer,
            headline: Text(tr('importExport')),
          ),
          _DecoratedSliver(
            position: DecorationPosition.background,
            decoration: ShapeDecoration(
              shape: CornersBorder.rounded(
                corners: Corners.all(ShapeTheme.of(context).corner.large),
              ),
              color: ColorTheme.of(context).surfaceContainerLow,
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              sliver: SliverList.list(
                children: [
                  FutureBuilder(
                    future: settingsProvider.getExportDir(),
                    builder: (context, snapshot) {
                      final hasExportDir = snapshot.hasData;
                      return Flex.vertical(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton(
                            onPressed: importInProgress
                                ? null
                                : () {
                                    runObtainiumExport(pickOnly: true);
                                  },
                            style: ButtonStyle(
                              animationDuration: Duration.zero,
                              elevation: const WidgetStatePropertyAll(0.0),
                              shadowColor: WidgetStateColor.transparent,
                              minimumSize: const WidgetStatePropertyAll(
                                Size(48.0, 56.0),
                              ),
                              fixedSize: const WidgetStatePropertyAll(null),
                              maximumSize: const WidgetStatePropertyAll(
                                Size.infinite,
                              ),
                              padding: const WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 16.0,
                                ),
                              ),
                              iconSize: const WidgetStatePropertyAll(24.0),
                              shape: WidgetStatePropertyAll(
                                CornersBorder.rounded(
                                  corners: Corners.all(
                                    ShapeTheme.of(context).corner.large,
                                  ),
                                ),
                              ),
                              overlayColor: WidgetStateLayerColor(
                                color: WidgetStatePropertyAll(
                                  hasExportDir
                                      ? ColorTheme.of(context).onSurfaceVariant
                                      : ColorTheme.of(
                                          context,
                                        ).onSecondaryContainer,
                                ),
                                opacity: StateTheme.of(
                                  context,
                                ).stateLayerOpacity,
                              ),
                              backgroundColor: WidgetStateProperty.resolveWith(
                                (states) =>
                                    states.contains(WidgetState.disabled)
                                    ? ColorTheme.of(
                                        context,
                                      ).onSurface.withValues(alpha: 0.1)
                                    : hasExportDir
                                    ? ColorTheme.of(context).surfaceBright
                                    : ColorTheme.of(context).secondaryContainer,
                              ),
                              foregroundColor: WidgetStateProperty.resolveWith(
                                (states) =>
                                    states.contains(WidgetState.disabled)
                                    ? ColorTheme.of(
                                        context,
                                      ).onSurface.withValues(alpha: 0.38)
                                    : hasExportDir
                                    ? ColorTheme.of(context).onSurfaceVariant
                                    : ColorTheme.of(
                                        context,
                                      ).onSecondaryContainer,
                              ),
                              textStyle: WidgetStateProperty.resolveWith(
                                (states) =>
                                    (hasExportDir
                                            ? TypescaleTheme.of(
                                                context,
                                              ).titleMedium
                                            : TypescaleTheme.of(
                                                context,
                                              ).titleMediumEmphasized)
                                        .toTextStyle(),
                              ),
                            ),
                            child: Text(
                              tr('pickExportDir'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          FilledButton(
                            onPressed: importInProgress || snapshot.data == null
                                ? null
                                : runObtainiumExport,
                            style: ButtonStyle(
                              animationDuration: Duration.zero,
                              elevation: const WidgetStatePropertyAll(0.0),
                              shadowColor: WidgetStateColor.transparent,
                              minimumSize: const WidgetStatePropertyAll(
                                Size(48.0, 56.0),
                              ),
                              fixedSize: const WidgetStatePropertyAll(null),
                              maximumSize: const WidgetStatePropertyAll(
                                Size.infinite,
                              ),
                              padding: const WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 16.0,
                                ),
                              ),
                              iconSize: const WidgetStatePropertyAll(24.0),
                              shape: WidgetStatePropertyAll(
                                CornersBorder.rounded(
                                  corners: Corners.all(
                                    ShapeTheme.of(context).corner.large,
                                  ),
                                ),
                              ),
                              overlayColor: WidgetStateLayerColor(
                                color: WidgetStatePropertyAll(
                                  ColorTheme.of(context).onTertiaryContainer,
                                ),
                                opacity: StateTheme.of(
                                  context,
                                ).stateLayerOpacity,
                              ),
                              backgroundColor: WidgetStateProperty.resolveWith(
                                (states) =>
                                    states.contains(WidgetState.disabled)
                                    ? ColorTheme.of(
                                        context,
                                      ).onSurface.withValues(alpha: 0.1)
                                    : ColorTheme.of(context).tertiaryContainer,
                              ),
                              foregroundColor: WidgetStateProperty.resolveWith(
                                (states) =>
                                    states.contains(WidgetState.disabled)
                                    ? ColorTheme.of(
                                        context,
                                      ).onSurface.withValues(alpha: 0.38)
                                    : ColorTheme.of(
                                        context,
                                      ).onTertiaryContainer,
                              ),
                              textStyle: WidgetStateProperty.resolveWith(
                                (states) => TypescaleTheme.of(
                                  context,
                                ).titleMediumEmphasized.toTextStyle(),
                              ),
                            ),
                            child: Text(
                              tr('obtainiumExport'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FilledButton(
                            onPressed: importInProgress
                                ? null
                                : runObtainiumImport,
                            style: ButtonStyle(
                              animationDuration: Duration.zero,
                              elevation: const WidgetStatePropertyAll(0.0),
                              shadowColor: WidgetStateColor.transparent,
                              minimumSize: const WidgetStatePropertyAll(
                                Size(48.0, 56.0),
                              ),
                              fixedSize: const WidgetStatePropertyAll(null),
                              maximumSize: const WidgetStatePropertyAll(
                                Size.infinite,
                              ),
                              padding: const WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 16.0,
                                ),
                              ),
                              iconSize: const WidgetStatePropertyAll(24.0),
                              shape: WidgetStatePropertyAll(
                                CornersBorder.rounded(
                                  corners: Corners.all(
                                    ShapeTheme.of(context).corner.large,
                                  ),
                                ),
                              ),
                              overlayColor: WidgetStateLayerColor(
                                color: WidgetStatePropertyAll(
                                  ColorTheme.of(context).onPrimaryContainer,
                                ),
                                opacity: StateTheme.of(
                                  context,
                                ).stateLayerOpacity,
                              ),
                              backgroundColor: WidgetStateProperty.resolveWith(
                                (states) =>
                                    states.contains(WidgetState.disabled)
                                    ? ColorTheme.of(
                                        context,
                                      ).onSurface.withValues(alpha: 0.1)
                                    : ColorTheme.of(context).primaryContainer,
                              ),
                              foregroundColor: WidgetStateProperty.resolveWith(
                                (states) =>
                                    states.contains(WidgetState.disabled)
                                    ? ColorTheme.of(
                                        context,
                                      ).onSurface.withValues(alpha: 0.38)
                                    : ColorTheme.of(context).onPrimaryContainer,
                              ),
                              textStyle: WidgetStateProperty.resolveWith(
                                (states) => TypescaleTheme.of(
                                  context,
                                ).titleMediumEmphasized.toTextStyle(),
                              ),
                            ),
                            child: Text(
                              tr('obtainiumImport'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          if (snapshot.data != null)
                            Flex.vertical(
                              children: [
                                const SizedBox(height: 16),
                                GeneratedForm(
                                  items: [
                                    [
                                      GeneratedFormSwitch(
                                        'autoExportOnChanges',
                                        label: tr('autoExportOnChanges'),
                                        defaultValue: settingsProvider
                                            .autoExportOnChanges,
                                      ),
                                    ],
                                    [
                                      GeneratedFormDropdown(
                                        'exportSettings',
                                        [
                                          MapEntry('0', tr('none')),
                                          MapEntry('1', tr('excludeSecrets')),
                                          MapEntry('2', tr('all')),
                                        ],
                                        label: tr('includeSettings'),
                                        defaultValue: settingsProvider
                                            .exportSettings
                                            .toString(),
                                      ),
                                    ],
                                  ],
                                  onValueChanges: (value, valid, isBuilding) {
                                    if (valid && !isBuilding) {
                                      if (value['autoExportOnChanges'] !=
                                          null) {
                                        settingsProvider.autoExportOnChanges =
                                            value['autoExportOnChanges'] ==
                                            true;
                                      }
                                      if (value['exportSettings'] != null) {
                                        settingsProvider.exportSettings =
                                            int.parse(value['exportSettings']);
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                  if (importInProgress)
                    const Flex.vertical(
                      children: [
                        SizedBox(height: 14),
                        LinearProgressIndicator(value: null),
                        SizedBox(height: 14),
                      ],
                    )
                  else
                    Flex.vertical(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 32),
                        FilledButton(
                          onPressed: importInProgress
                              ? null
                              : () async {
                                  var searchSourceName =
                                      await showDialog<List<String>?>(
                                        context: context,
                                        builder: (ctx) {
                                          return SelectionModal(
                                            title: tr(
                                              'selectX',
                                              args: [
                                                tr('source').toLowerCase(),
                                              ],
                                            ),
                                            entries: sourceStrings,
                                            selectedByDefault: false,
                                            onlyOneSelectionAllowed: true,
                                            titlesAreLinks: false,
                                          );
                                        },
                                      ) ??
                                      [];
                                  var searchSource = sourceProvider.sources
                                      .where(
                                        (e) =>
                                            searchSourceName.contains(e.name),
                                      )
                                      .toList();
                                  if (searchSource.isNotEmpty) {
                                    runSourceSearch(searchSource[0]);
                                  }
                                },
                          style: ButtonStyle(
                            animationDuration: Duration.zero,
                            elevation: const WidgetStatePropertyAll(0.0),
                            shadowColor: WidgetStateColor.transparent,
                            minimumSize: const WidgetStatePropertyAll(
                              Size(48.0, 56.0),
                            ),
                            fixedSize: const WidgetStatePropertyAll(null),
                            maximumSize: const WidgetStatePropertyAll(
                              Size.infinite,
                            ),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 16.0,
                              ),
                            ),
                            iconSize: const WidgetStatePropertyAll(24.0),
                            shape: WidgetStatePropertyAll(
                              CornersBorder.rounded(
                                corners: Corners.all(
                                  ShapeTheme.of(context).corner.full,
                                ),
                              ),
                            ),
                            overlayColor: WidgetStateLayerColor(
                              color: WidgetStatePropertyAll(
                                ColorTheme.of(context).onSurfaceVariant,
                              ),
                              opacity: StateTheme.of(context).stateLayerOpacity,
                            ),
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.disabled)
                                  ? ColorTheme.of(
                                      context,
                                    ).onSurface.withValues(alpha: 0.1)
                                  : ColorTheme.of(context).surfaceBright,
                            ),
                            foregroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.disabled)
                                  ? ColorTheme.of(
                                      context,
                                    ).onSurface.withValues(alpha: 0.38)
                                  : ColorTheme.of(context).onSurfaceVariant,
                            ),
                            textStyle: WidgetStateProperty.resolveWith(
                              (states) => TypescaleTheme.of(
                                context,
                              ).titleMedium.toTextStyle(),
                            ),
                          ),
                          child: Text(
                            tr(
                              'searchX',
                              args: [lowerCaseIfEnglish(tr('source'))],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: importInProgress ? null : urlListImport,
                          style: ButtonStyle(
                            animationDuration: Duration.zero,
                            elevation: const WidgetStatePropertyAll(0.0),
                            shadowColor: WidgetStateColor.transparent,
                            minimumSize: const WidgetStatePropertyAll(
                              Size(48.0, 56.0),
                            ),
                            fixedSize: const WidgetStatePropertyAll(null),
                            maximumSize: const WidgetStatePropertyAll(
                              Size.infinite,
                            ),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 16.0,
                              ),
                            ),
                            iconSize: const WidgetStatePropertyAll(24.0),
                            shape: WidgetStatePropertyAll(
                              CornersBorder.rounded(
                                corners: Corners.all(
                                  ShapeTheme.of(context).corner.full,
                                ),
                              ),
                            ),
                            overlayColor: WidgetStateLayerColor(
                              color: WidgetStatePropertyAll(
                                ColorTheme.of(context).onSurfaceVariant,
                              ),
                              opacity: StateTheme.of(context).stateLayerOpacity,
                            ),
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.disabled)
                                  ? ColorTheme.of(
                                      context,
                                    ).onSurface.withValues(alpha: 0.1)
                                  : ColorTheme.of(context).surfaceBright,
                            ),
                            foregroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.disabled)
                                  ? ColorTheme.of(
                                      context,
                                    ).onSurface.withValues(alpha: 0.38)
                                  : ColorTheme.of(context).onSurfaceVariant,
                            ),
                            textStyle: WidgetStateProperty.resolveWith(
                              (states) => TypescaleTheme.of(
                                context,
                              ).titleMedium.toTextStyle(),
                            ),
                          ),
                          child: Text(
                            tr('importFromURLList'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: importInProgress ? null : runUrlImport,
                          style: ButtonStyle(
                            animationDuration: Duration.zero,
                            elevation: const WidgetStatePropertyAll(0.0),
                            shadowColor: WidgetStateColor.transparent,
                            minimumSize: const WidgetStatePropertyAll(
                              Size(48.0, 56.0),
                            ),
                            fixedSize: const WidgetStatePropertyAll(null),
                            maximumSize: const WidgetStatePropertyAll(
                              Size.infinite,
                            ),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 16.0,
                              ),
                            ),
                            iconSize: const WidgetStatePropertyAll(24.0),
                            shape: WidgetStatePropertyAll(
                              CornersBorder.rounded(
                                corners: Corners.all(
                                  ShapeTheme.of(context).corner.full,
                                ),
                              ),
                            ),
                            overlayColor: WidgetStateLayerColor(
                              color: WidgetStatePropertyAll(
                                ColorTheme.of(context).onSurfaceVariant,
                              ),
                              opacity: StateTheme.of(context).stateLayerOpacity,
                            ),
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.disabled)
                                  ? ColorTheme.of(
                                      context,
                                    ).onSurface.withValues(alpha: 0.1)
                                  : ColorTheme.of(context).surfaceBright,
                            ),
                            foregroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.disabled)
                                  ? ColorTheme.of(
                                      context,
                                    ).onSurface.withValues(alpha: 0.38)
                                  : ColorTheme.of(context).onSurfaceVariant,
                            ),
                            textStyle: WidgetStateProperty.resolveWith(
                              (states) => TypescaleTheme.of(
                                context,
                              ).titleMedium.toTextStyle(),
                            ),
                          ),
                          child: Text(
                            tr('importFromURLsInFile'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ...sourceProvider.massUrlSources.map(
                    (source) => Flex.vertical(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: importInProgress
                              ? null
                              : () {
                                  runMassSourceImport(source);
                                },
                          style: ButtonStyle(
                            animationDuration: Duration.zero,
                            elevation: const WidgetStatePropertyAll(0.0),
                            shadowColor: WidgetStateColor.transparent,
                            minimumSize: const WidgetStatePropertyAll(
                              Size(48.0, 56.0),
                            ),
                            fixedSize: const WidgetStatePropertyAll(null),
                            maximumSize: const WidgetStatePropertyAll(
                              Size.infinite,
                            ),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 16.0,
                              ),
                            ),
                            iconSize: const WidgetStatePropertyAll(24.0),
                            shape: WidgetStatePropertyAll(
                              CornersBorder.rounded(
                                corners: Corners.all(
                                  ShapeTheme.of(context).corner.full,
                                ),
                              ),
                            ),
                            overlayColor: WidgetStateLayerColor(
                              color: WidgetStatePropertyAll(
                                ColorTheme.of(context).onSurfaceVariant,
                              ),
                              opacity: StateTheme.of(context).stateLayerOpacity,
                            ),
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.disabled)
                                  ? ColorTheme.of(
                                      context,
                                    ).onSurface.withValues(alpha: 0.1)
                                  : ColorTheme.of(context).surfaceBright,
                            ),
                            foregroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.disabled)
                                  ? ColorTheme.of(
                                      context,
                                    ).onSurface.withValues(alpha: 0.38)
                                  : ColorTheme.of(context).onSurfaceVariant,
                            ),
                            textStyle: WidgetStateProperty.resolveWith(
                              (states) => TypescaleTheme.of(
                                context,
                              ).titleMedium.toTextStyle(),
                            ),
                          ),
                          child: Text(
                            tr('importX', args: [source.name]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 32),
                  Text(
                    tr('importedAppsIdDisclaimer'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImportErrorDialog extends StatefulWidget {
  const ImportErrorDialog({
    super.key,
    required this.urlsLength,
    required this.errors,
  });

  final int urlsLength;
  final List<List<String>> errors;

  @override
  State<ImportErrorDialog> createState() => _ImportErrorDialogState();
}

class _ImportErrorDialogState extends State<ImportErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(tr('importErrors')),
      content: Flex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            tr(
              'importedXOfYApps',
              args: [
                (widget.urlsLength - widget.errors.length).toString(),
                widget.urlsLength.toString(),
              ],
            ),
            style: TypescaleTheme.of(context).bodyLarge.toTextStyle(),
          ),
          const SizedBox(height: 16),
          Text(
            tr('followingURLsHadErrors'),
            style: TypescaleTheme.of(context).bodyLarge.toTextStyle(),
          ),
          ...widget.errors.map((e) {
            return Flex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(e[0]),
                Text(e[1], style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(tr('ok')),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class SelectionModal extends StatefulWidget {
  SelectionModal({
    super.key,
    required this.entries,
    this.selectedByDefault = true,
    this.onlyOneSelectionAllowed = false,
    this.titlesAreLinks = true,
    this.title,
    this.deselectThese = const [],
  });

  String? title;
  Map<String, List<String>> entries;
  bool selectedByDefault;
  List<String> deselectThese;
  bool onlyOneSelectionAllowed;
  bool titlesAreLinks;

  @override
  State<SelectionModal> createState() => _SelectionModalState();
}

class _SelectionModalState extends State<SelectionModal> {
  Map<MapEntry<String, List<String>>, bool> entrySelections = {};
  String filterRegex = '';
  @override
  void initState() {
    super.initState();
    for (var entry in widget.entries.entries) {
      entrySelections.putIfAbsent(
        entry,
        () =>
            widget.selectedByDefault &&
            !widget.onlyOneSelectionAllowed &&
            !widget.deselectThese.contains(entry.key),
      );
    }
    if (widget.selectedByDefault && widget.onlyOneSelectionAllowed) {
      selectOnlyOne(widget.entries.entries.first.key);
    }
  }

  void selectOnlyOne(String url) {
    for (var e in entrySelections.keys) {
      entrySelections[e] = e.key == url;
    }
  }

  void selectAll({bool deselect = false}) {
    for (var e in entrySelections.keys) {
      entrySelections[e] = !deselect;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<MapEntry<String, List<String>>, bool> filteredEntrySelections = {};
    entrySelections.forEach((key, value) {
      var searchableText = key.value.isEmpty ? key.key : key.value[0];
      if (filterRegex.isEmpty || RegExp(filterRegex).hasMatch(searchableText)) {
        filteredEntrySelections.putIfAbsent(key, () => value);
      }
    });
    if (filterRegex.isNotEmpty && filteredEntrySelections.isEmpty) {
      entrySelections.forEach((key, value) {
        var searchableText = key.value.isEmpty ? key.key : key.value[0];
        if (filterRegex.isEmpty ||
            RegExp(
              filterRegex,
              caseSensitive: false,
            ).hasMatch(searchableText)) {
          filteredEntrySelections.putIfAbsent(key, () => value);
        }
      });
    }
    Widget getSelectAllButton() {
      if (widget.onlyOneSelectionAllowed) {
        return const SizedBox.shrink();
      }
      var noneSelected = entrySelections.values.where((v) => v == true).isEmpty;
      return noneSelected
          ? TextButton(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {
                setState(() {
                  selectAll();
                });
              },
              child: Text(tr('selectAll')),
            )
          : TextButton(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {
                setState(() {
                  selectAll(deselect: true);
                });
              },
              child: Text(tr('deselectX', args: [''])),
            );
    }

    return AlertDialog(
      scrollable: true,
      title: Text(widget.title ?? tr('pick')),
      content: Flex.vertical(
        children: [
          GeneratedForm(
            items: [
              [
                GeneratedFormTextField(
                  'filter',
                  label: tr('filter'),
                  required: false,
                  additionalValidators: [
                    (value) {
                      return regExValidator(value);
                    },
                  ],
                ),
              ],
            ],
            onValueChanges: (value, valid, isBuilding) {
              if (valid && !isBuilding) {
                if (value['filter'] != null) {
                  setState(() {
                    filterRegex = value['filter'];
                  });
                }
              }
            },
          ),
          ...filteredEntrySelections.keys.map((entry) {
            void selectThis(bool? value) {
              setState(() {
                value ??= false;
                if (value! && widget.onlyOneSelectionAllowed) {
                  selectOnlyOne(entry.key);
                } else {
                  entrySelections[entry] = value!;
                }
              });
            }

            var urlLink = GestureDetector(
              onTap: !widget.titlesAreLinks
                  ? null
                  : () {
                      launchUrlString(
                        entry.key,
                        mode: LaunchMode.externalApplication,
                      );
                    },
              child: Flex.vertical(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.value.isEmpty ? entry.key : entry.value[0],
                    style: TextStyle(
                      decoration: widget.titlesAreLinks
                          ? TextDecoration.underline
                          : null,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  if (widget.titlesAreLinks)
                    Text(
                      Uri.parse(entry.key).host,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            );

            var descriptionText = entry.value.length <= 1
                ? const SizedBox.shrink()
                : Text(
                    entry.value[1].length > 128
                        ? '${entry.value[1].substring(0, 128)}...'
                        : entry.value[1],
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  );

            var selectedEntries = entrySelections.entries
                .where((e) => e.value)
                .toList();

            var singleSelectTile = ListTile(
              title: GestureDetector(
                onTap: widget.titlesAreLinks
                    ? null
                    : () {
                        selectThis(!(entrySelections[entry] ?? false));
                      },
                child: urlLink,
              ),
              subtitle: entry.value.length <= 1
                  ? null
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          selectOnlyOne(entry.key);
                        });
                      },
                      child: descriptionText,
                    ),
              leading: Radio<String>(
                value: entry.key,
                groupValue: selectedEntries.isEmpty
                    ? null
                    : selectedEntries.first.key.key,
                onChanged: (value) {
                  setState(() {
                    selectOnlyOne(entry.key);
                  });
                },
              ),
            );

            var multiSelectTile = Flex.horizontal(
              children: [
                Checkbox(
                  value: entrySelections[entry],
                  onChanged: (value) {
                    selectThis(value);
                  },
                ),
                const SizedBox(width: 8),
                Flexible.tight(
                  child: Flex.vertical(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: widget.titlesAreLinks
                            ? null
                            : () {
                                selectThis(!(entrySelections[entry] ?? false));
                              },
                        child: urlLink,
                      ),
                      entry.value.length <= 1
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                selectThis(!(entrySelections[entry] ?? false));
                              },
                              child: descriptionText,
                            ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            );

            return widget.onlyOneSelectionAllowed
                ? singleSelectTile
                : multiSelectTile;
          }),
        ],
      ),
      actions: [
        getSelectAllButton(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(tr('cancel')),
        ),
        TextButton(
          onPressed: entrySelections.values.where((b) => b).isEmpty
              ? null
              : () {
                  Navigator.of(context).pop(
                    entrySelections.entries
                        .where((entry) => entry.value)
                        .map((e) => e.key.key)
                        .toList(),
                  );
                },
          child: Text(
            widget.onlyOneSelectionAllowed
                ? tr('pick')
                : tr(
                    'selectX',
                    args: [
                      entrySelections.values.where((b) => b).length.toString(),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

/// A sliver widget that paints a [Decoration] either before or after its child
/// paints.
///
/// Unlike [DecoratedBox], this widget expects its child to be a sliver, and
/// must be placed in a widget that expects a sliver.
///
/// If the child sliver has infinite [SliverGeometry.scrollExtent], then we only
/// draw the decoration down to the bottom [SliverGeometry.cacheExtent], and
/// it is necessary to ensure that the bottom border does not creep
/// above the top of the bottom cache. This can happen if the bottom has a
/// border radius larger than the extent of the cache area.
///
/// Commonly used with [BoxDecoration].
///
///
/// {@tool dartpad}
/// This sample shows a radial gradient that draws a moon on a night sky:
///
/// ** See code in examples/api/lib/widgets/sliver/decorated_sliver.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example demonstrates how the [CustomScrollView.clipBehavior]
/// impacts a decorated sliver's appearance.
///
/// The [Switch] determines whether clipping is enabled, and
/// the [Slider] adjusts the height of window.
///
/// ** See code in examples/api/lib/widgets/sliver/decorated_sliver.1.dart **
/// {@end-tool}
///
/// This widget does not apply any additional clipping to its [child].
/// To clip a child based on the [Decoration]'s shape, consider using
/// a [ClipPath] widget.
///
/// See also:
///
///  * [DecoratedBox], the version of this class that works with RenderBox widgets.
///  * [Decoration], which you can extend to provide other effects with
///    [_DecoratedSliver].
///  * [CustomPaint], another way to draw custom effects from the widget layer.
class _DecoratedSliver extends SingleChildRenderObjectWidget {
  /// Creates a widget that paints a [Decoration].
  ///
  /// By default the decoration paints behind the child.
  const _DecoratedSliver({
    super.key,
    required this.decoration,
    this.position = DecorationPosition.background,
    Widget? sliver,
  }) : super(child: sliver);

  /// What decoration to paint.
  ///
  /// Commonly a [BoxDecoration].
  final Decoration decoration;

  /// Whether to paint the box decoration behind or in front of the child.
  final DecorationPosition position;

  @override
  _RenderDecoratedSliver createRenderObject(BuildContext context) {
    return _RenderDecoratedSliver(
      decoration: decoration,
      position: position,
      configuration: createLocalImageConfiguration(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderDecoratedSliver renderObject,
  ) {
    renderObject
      ..decoration = decoration
      ..position = position
      ..configuration = createLocalImageConfiguration(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final String label = switch (position) {
      DecorationPosition.background => "bg",
      DecorationPosition.foreground => "fg",
    };
    properties.add(
      EnumProperty<DecorationPosition>(
        "position",
        position,
        level: DiagnosticLevel.hidden,
      ),
    );
    properties.add(DiagnosticsProperty<Decoration>(label, decoration));
  }
}

/// Paints a [Decoration] either before or after its child paints.
///
/// If the child has infinite scroll extent, then the [Decoration] paints itself up to the
/// bottom cache extent.
class _RenderDecoratedSliver extends RenderProxySliver {
  /// Creates a decorated sliver.
  ///
  /// The [decoration], [position], and [configuration] arguments must not be
  /// null. By default the decoration paints behind the child.
  ///
  /// The [ImageConfiguration] will be passed to the decoration (with the size
  /// filled in) to let it resolve images.
  _RenderDecoratedSliver({
    required Decoration decoration,
    DecorationPosition position = DecorationPosition.background,
    ImageConfiguration configuration = ImageConfiguration.empty,
  }) : _decoration = decoration,
       _position = position,
       _configuration = configuration;

  /// What decoration to paint.
  ///
  /// Commonly a [BoxDecoration].
  Decoration get decoration => _decoration;
  Decoration _decoration;
  set decoration(Decoration value) {
    if (value == decoration) {
      return;
    }
    _decoration = value;
    _painter?.dispose();
    _painter = decoration.createBoxPainter(markNeedsPaint);
    markNeedsPaint();
  }

  /// Whether to paint the box decoration behind or in front of the child.
  DecorationPosition get position => _position;
  DecorationPosition _position;
  set position(DecorationPosition value) {
    if (value == position) {
      return;
    }
    _position = value;
    markNeedsPaint();
  }

  /// The settings to pass to the decoration when painting, so that it can
  /// resolve images appropriately. See [ImageProvider.resolve] and
  /// [BoxPainter.paint].
  ///
  /// The [ImageConfiguration.textDirection] field is also used by
  /// direction-sensitive [Decoration]s for painting and hit-testing.
  ImageConfiguration get configuration => _configuration;
  ImageConfiguration _configuration;
  set configuration(ImageConfiguration value) {
    if (value == configuration) {
      return;
    }
    _configuration = value;
    markNeedsPaint();
  }

  BoxPainter? _painter;

  @override
  void attach(covariant PipelineOwner owner) {
    _painter = decoration.createBoxPainter(markNeedsPaint);
    super.attach(owner);
  }

  @override
  void detach() {
    _painter?.dispose();
    _painter = null;
    super.detach();
  }

  @override
  void dispose() {
    _painter?.dispose();
    _painter = null;
    super.dispose();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null || !child!.geometry!.visible) {
      return;
    }
    // In the case where the child sliver has infinite scroll extent, the decoration
    // should only extend down to the bottom cache extent.

    // Original implementation:
    // final double cappedMainAxisExtent = child!.geometry!.scrollExtent.isInfinite
    //     ? constraints.scrollOffset +
    //           child!.geometry!.cacheExtent +
    //           constraints.cacheOrigin
    //     : child!.geometry!.scrollExtent;
    // final (Size childSize, Offset scrollOffset) = switch (constraints.axis) {
    //   Axis.horizontal => (
    //     Size(cappedMainAxisExtent, constraints.crossAxisExtent),
    //     Offset(-constraints.scrollOffset, 0.0),
    //   ),
    //   Axis.vertical => (
    //     Size(constraints.crossAxisExtent, cappedMainAxisExtent),
    //     Offset(0.0, -constraints.scrollOffset),
    //   ),
    // };

    final double cappedMainAxisExtent =
        child!.geometry!.paintExtent - constraints.overlap;
    final (Size childSize, Offset scrollOffset) = switch (constraints.axis) {
      Axis.horizontal => (
        Size(cappedMainAxisExtent, constraints.crossAxisExtent),
        Offset(constraints.overlap, 0.0),
      ),
      Axis.vertical => (
        Size(constraints.crossAxisExtent, cappedMainAxisExtent),
        Offset(0.0, constraints.overlap),
      ),
    };
    offset += (child!.parentData! as SliverPhysicalParentData).paintOffset;
    void paintDecoration() => _painter!.paint(
      context.canvas,
      offset + scrollOffset,
      configuration.copyWith(size: childSize),
    );
    switch (position) {
      case DecorationPosition.background:
        paintDecoration();
        context.paintChild(child!, offset);
      case DecorationPosition.foreground:
        context.paintChild(child!, offset);
        paintDecoration();
    }
  }
}
