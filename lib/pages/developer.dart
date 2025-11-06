import 'dart:math' as math;

import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:material/material_shapes.dart';

import 'package:obtainium/components/custom_app_bar.dart';
import 'package:obtainium/components/custom_list.dart';
import 'package:obtainium/components/custom_loading_indicator.dart';
import 'package:obtainium/components/custom_markdown.dart';
import 'package:obtainium/flutter.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:obtainium/theme/theme.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_markdown/super_editor_markdown.dart';

// ignore: implementation_imports
import 'package:obtainium_fonts/src/assets/fonts.gen.dart';

// ignore: implementation_imports
import 'package:material/src/material_shapes.dart'
    show
        // ignore: invalid_use_of_internal_member
        RoundedPolygonInternalExtension;

class DeveloperPageBackButton extends StatelessWidget {
  const DeveloperPageBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final route = ModalRoute.of(context);
    final colorTheme = ColorTheme.of(context);
    final shapeTheme = ShapeTheme.of(context);
    final stateTheme = StateTheme.of(context);
    return IconButton(
      onPressed: () => navigator.pop(),
      style: ButtonStyle(
        animationDuration: Duration.zero,
        elevation: const WidgetStatePropertyAll(0.0),
        shadowColor: WidgetStateColor.transparent,
        minimumSize: const WidgetStatePropertyAll(Size.zero),
        fixedSize: const WidgetStatePropertyAll(Size(40.0, 40.0)),
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
              : colorTheme.surfaceContainerHighest,
        ),
        iconColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? colorTheme.onSurface.withValues(alpha: 0.38)
              : colorTheme.onSurfaceVariant,
        ),
      ),
      icon: const IconLegacy(Symbols.arrow_back_rounded),
    );
  }
}

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({super.key});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);

    final staticColors = StaticColorsData.fallback(
      variant: DynamicSchemeVariant.tonalSpot,
      brightness: Brightness.light,
      specVersion: DynamicSchemeSpecVersion.spec2025,
    ).harmonizeWithPrimary(colorTheme);

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: 8.0 - 4.0),
              child: DeveloperPageBackButton(),
            ),
            type: CustomAppBarType.largeFlexible,
            behavior: CustomAppBarBehavior.duplicate,
            expandedContainerColor: colorTheme.surfaceContainer,
            collapsedContainerColor: colorTheme.surfaceContainer,
            collapsedPadding: const EdgeInsets.fromLTRB(
              8.0 + 40.0 + 8.0,
              0.0,
              16.0,
              0.0,
            ),
            title: const Text("Developer Options"),
          ),
          SliverList.list(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Flex.vertical(
              //     children: [
              //       ListItemContainer(
              //         isFirst: true,
              //         child: ConstrainedBox(
              //           constraints: BoxConstraints(minHeight: 56.0),
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //             child: Align.center(
              //               child: CustomLinearProgressIndicator(
              //                 progress: _progress,
              //                 // minHeight: 16.0,
              //                 // trackGap: 4.0,
              //                 // borderRadius: BorderRadius.circular(8.0),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(height: 2.0),
              //       ListItemContainer(
              //         isLast: true,
              //         child: ConstrainedBox(
              //           constraints: BoxConstraints(minHeight: 56.0),
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //             child: Align.center(
              //               child: Slider(
              //                 onChanged: (value) =>
              //                     setState(() => _progress = value),
              //                 value: _progress,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Flex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 2.0,
                  children: [
                    ListItemContainer(
                      isFirst: true,
                      containerColor: colorTheme.surfaceBright,
                      child: MergeSemantics(
                        child: ListItemInteraction(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DeveloperMarkdown1Page(),
                            ),
                          ),
                          child: ListItemLayout(
                            isMultiline: true,
                            leading: SizedBox.square(
                              dimension: 40.0,
                              child: Material(
                                animationDuration: Duration.zero,
                                type: MaterialType.card,
                                clipBehavior: Clip.antiAlias,
                                color: staticColors.green.colorFixedDim,
                                shape: const StadiumBorder(),
                                child: Align.center(
                                  child: Icon(
                                    Symbols.markdown_rounded,
                                    fill: 1.0,
                                    color:
                                        staticColors.green.onColorFixedVariant,
                                  ),
                                ),
                              ),
                            ),
                            headline: const Text("Markdown Demo 1"),
                            supportingText: const Text(
                              "Uses flutter_markdown_plus",
                            ),
                            trailing: const Icon(
                              Symbols.keyboard_arrow_right_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListItemContainer(
                      containerColor: colorTheme.surfaceBright,
                      child: MergeSemantics(
                        child: ListItemInteraction(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DeveloperMarkdown2Page(),
                            ),
                          ),
                          child: ListItemLayout(
                            isMultiline: true,
                            leading: SizedBox.square(
                              dimension: 40.0,
                              child: Material(
                                animationDuration: Duration.zero,
                                type: MaterialType.card,
                                clipBehavior: Clip.antiAlias,
                                color: staticColors.green.colorFixedDim,
                                shape: const StadiumBorder(),
                                child: Align.center(
                                  child: Icon(
                                    Symbols.markdown_rounded,
                                    fill: 1.0,
                                    color:
                                        staticColors.green.onColorFixedVariant,
                                  ),
                                ),
                              ),
                            ),
                            headline: const Text("Markdown Demo 2"),
                            supportingText: const Text("Uses super_editor"),
                            trailing: const Icon(
                              Symbols.keyboard_arrow_right_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListItemContainer(
                      containerColor: colorTheme.surfaceBright,
                      child: MergeSemantics(
                        child: ListItemInteraction(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const _MaterialDemoView(),
                            ),
                          ),
                          child: ListItemLayout(
                            isMultiline: true,
                            leading: SizedBox.square(
                              dimension: 40.0,
                              child: Material(
                                animationDuration: Duration.zero,
                                type: MaterialType.card,
                                clipBehavior: Clip.antiAlias,
                                color: staticColors.blue.colorFixedDim,
                                shape: const StadiumBorder(),
                                child: Align.center(
                                  child: Icon(
                                    Symbols.magic_button_rounded,
                                    fill: 1.0,
                                    color:
                                        staticColors.blue.onColorFixedVariant,
                                  ),
                                ),
                              ),
                            ),
                            headline: const Text("Material 3 Expressive"),
                            supportingText: const Text(
                              "Demo of the new design system",
                            ),
                            trailing: const Icon(
                              Symbols.keyboard_arrow_right_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListItemContainer(
                      isLast: true,
                      containerColor: colorTheme.surfaceBright,
                      child: MergeSemantics(
                        child: ListItemInteraction(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Settings2View(),
                            ),
                          ),
                          child: ListItemLayout(
                            isMultiline: true,
                            leading: SizedBox.square(
                              dimension: 40.0,
                              child: Material(
                                animationDuration: Duration.zero,
                                type: MaterialType.card,
                                clipBehavior: Clip.antiAlias,
                                color: staticColors.cyan.colorFixedDim,
                                shape: const StadiumBorder(),
                                child: Align.center(
                                  child: Icon(
                                    Symbols.settings_rounded,
                                    fill: 1.0,
                                    color:
                                        staticColors.cyan.onColorFixedVariant,
                                  ),
                                ),
                              ),
                            ),
                            headline: const Text("New settings experience"),
                            supportingText: const Text(
                              "Try out new design for settings",
                            ),
                            trailing: const Icon(
                              Symbols.keyboard_arrow_right_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height),
            ],
          ),
        ],
      ),
    );
  }
}

class DeveloperMarkdown1Page extends StatefulWidget {
  const DeveloperMarkdown1Page({super.key});

  @override
  State<DeveloperMarkdown1Page> createState() => _DeveloperMarkdown1PageState();
}

class _DeveloperMarkdown1PageState extends State<DeveloperMarkdown1Page> {
  static final md.ExtensionSet _extensionSet = md.ExtensionSet(
    [...md.ExtensionSet.gitHubWeb.blockSyntaxes],
    [...md.ExtensionSet.gitHubWeb.inlineSyntaxes],
  );
  static final List<md.Node> _nodes = CustomMarkdownWidget.parseFromString(
    data: _custom,
    extensionSet: _extensionSet,
  );

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: 8.0 - 4.0),
              child: DeveloperPageBackButton(),
            ),
            type: CustomAppBarType.largeFlexible,
            behavior: CustomAppBarBehavior.duplicate,
            expandedContainerColor: colorTheme.surfaceContainer,
            collapsedContainerColor: colorTheme.surfaceContainer,
            collapsedPadding: const EdgeInsets.fromLTRB(
              8.0 + 40.0 + 8.0,
              0.0,
              16.0,
              0.0,
            ),
            title: Text("Markdown"),
            subtitle: Text("flutter_markdown_plus"),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            sliver: CustomMarkdownWidget.builder(
              nodes: _nodes,
              selectable: true,
              checkboxBuilder: (value) => Icon(
                value
                    ? Symbols.check_box_rounded
                    : Symbols.check_box_outline_blank_rounded,
                fill: value ? 1.0 : 0.0,
                color: value ? colorTheme.primary : colorTheme.onSurfaceVariant,
              ),
              extensionSet: _extensionSet,
              styleSheet: MarkdownStyleSheet(
                p: typescaleTheme.bodyMedium.toTextStyle(
                  color: colorTheme.onSurface,
                ),
                a: TextStyle(
                  color: colorTheme.tertiary,
                  decoration: TextDecoration.underline,
                  decorationColor: colorTheme.tertiary,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
                h1: typescaleTheme.displayMediumEmphasized.toTextStyle(),
                h1Padding: EdgeInsets.zero,
                h2: typescaleTheme.displaySmallEmphasized.toTextStyle(),
                h2Padding: EdgeInsets.zero,
                h3: typescaleTheme.headlineSmallEmphasized.toTextStyle(),
                h3Padding: EdgeInsets.zero,
                code: typescaleTheme.bodyMedium.toTextStyle().copyWith(
                  fontFamily: Fonts.firaCode,
                  color: colorTheme.onSurface,
                ),
                codeblockDecoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12.0),
                    side: BorderSide(color: colorTheme.outlineVariant),
                  ),
                  color: colorTheme.surface,
                ),
                codeblockPadding: EdgeInsets.all(16.0),
              ),
              builder: (context, children) =>
                  SliverList.list(children: children ?? const []),
            ),
          ),
        ],
      ),
    );
  }
}

class DeveloperMarkdown2Page extends StatefulWidget {
  const DeveloperMarkdown2Page({super.key});

  @override
  State<DeveloperMarkdown2Page> createState() => _DeveloperMarkdown2PageState();
}

class _DeveloperMarkdown2PageState extends State<DeveloperMarkdown2Page> {
  late Editor _editor;

  @override
  void initState() {
    super.initState();
    _editor = createDefaultDocumentEditor(
      document: deserializeMarkdownToDocument(_custom),
      composer: MutableDocumentComposer(),
    );
  }

  @override
  void dispose() {
    _editor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);
    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: 8.0 - 4.0),
              child: DeveloperPageBackButton(),
            ),
            type: CustomAppBarType.largeFlexible,
            behavior: CustomAppBarBehavior.duplicate,
            expandedContainerColor: colorTheme.surfaceContainer,
            collapsedContainerColor: colorTheme.surfaceContainer,
            collapsedPadding: const EdgeInsets.fromLTRB(
              8.0 + 40.0 + 8.0,
              0.0,
              16.0,
              0.0,
            ),
            title: Text("Markdown"),
            subtitle: Text("super_editor"),
          ),
          SuperReader(
            editor: _editor,
            androidHandleColor: colorTheme.primary,
            selectionStyle: SelectionStyles(
              selectionColor: colorTheme.primary.withValues(alpha: 0.3),
            ),
            componentBuilders: [
              const BlockquoteComponentBuilder(),
              const ParagraphComponentBuilder(),
              const ListItemComponentBuilder(),
              const ImageComponentBuilder(),
              const HorizontalRuleComponentBuilder(),
              const ReadOnlyCheckboxComponentBuilder(),
              const MarkdownTableComponentBuilder(),
            ],
            stylesheet: readOnlyDefaultStylesheet.copyWith(
              addRulesAfter: [
                StyleRule(BlockSelector.all, (doc, docNode) {
                  return {
                    Styles.maxWidth: 760.0,
                    Styles.padding: const CascadingPadding.symmetric(
                      horizontal: 16.0,
                    ),
                    Styles.textStyle: typescaleTheme.bodyMedium.toTextStyle(
                      color: colorTheme.onSurface,
                    ),
                  };
                }),
                StyleRule(const BlockSelector("header1"), (doc, docNode) {
                  return {
                    Styles.padding: const CascadingPadding.only(top: 40),
                    Styles.textStyle: typescaleTheme.displayMediumEmphasized
                        .toTextStyle(),
                  };
                }),
                StyleRule(const BlockSelector("header2"), (doc, docNode) {
                  return {
                    Styles.padding: const CascadingPadding.only(top: 80),
                    Styles.textStyle: typescaleTheme.displaySmallEmphasized
                        .toTextStyle(),
                  };
                }),
                StyleRule(const BlockSelector("header3"), (doc, docNode) {
                  return {
                    Styles.padding: const CascadingPadding.only(
                      top: 56.0,
                      bottom: 16.0,
                    ),
                    Styles.textStyle: typescaleTheme.headlineSmallEmphasized
                        .toTextStyle(),
                  };
                }),
                StyleRule(const BlockSelector("paragraph"), (doc, docNode) {
                  return {
                    Styles.padding: CascadingPadding.only(
                      top: typescaleTheme.bodyMedium.size,
                      bottom: typescaleTheme.bodyMedium.size,
                    ),
                  };
                }),
                StyleRule(const BlockSelector("paragraph").after("header2"), (
                  doc,
                  docNode,
                ) {
                  return {Styles.padding: CascadingPadding.only(top: 24.0)};
                }),
                StyleRule(const BlockSelector("code"), (doc, docNode) {
                  return {
                    Styles.borderRadius: BorderRadius.circular(28),
                    Styles.textStyle: typescaleTheme.bodyMedium
                        .toTextStyle()
                        .copyWith(
                          color: colorTheme.onSurface,
                          fontFamily: Fonts.firaCode,
                        ),
                  };
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliverMarkdown extends MarkdownWidget {
  /// Creates a scrolling widget that parses and displays Markdown.
  const SliverMarkdown({
    super.key,
    required super.data,
    super.selectable,
    super.styleSheet,
    super.styleSheetTheme = null,
    super.syntaxHighlighter,
    super.onSelectionChanged,
    super.onTapLink,
    super.onTapText,
    super.imageDirectory,
    super.blockSyntaxes,
    super.inlineSyntaxes,
    super.extensionSet,
    super.imageBuilder,
    super.checkboxBuilder,
    super.bulletBuilder,
    super.builders,
    super.paddingBuilders,
    super.listItemCrossAxisAlignment,
    super.softLineBreak,
  });

  @override
  Widget build(BuildContext context, List<Widget>? children) {
    return SliverList.list(children: children ?? const []);
  }
}

const String _custom = r"""
- [ ] A
- [ ] B
- [x] C
- [ ] D
- [ ] E

# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6

The app uses Markdown to display certain rich text messages, namely changelogs for tracked apps.

While not a part of the Material Design spec, a refresh of the default Markdown styles is urgently needed.

The priority of this change is low, because Markdown is rarely encountered throughout the app normally.

No significant changes were made to Markdown stylesheets yet, because the update is at the design stage.

## Roadmap

This section contains the list of projects that are planned to be implemented.

### Material 3 Expressive

Many Material widgets used still come from Flutter's Material library. The long-standing goal of this project is to get rid of the dependency on Flutter's Material library. It is considered "legacy" in the scope of this repository (it's not actually deprecated).

Here's a list of widgets that are planned to have a custom implementation:
- [ ] Switch (`Switch`)
  - [x] Support default style
  - [ ] Support theming

- [ ] Checkbox (`Checkbox`)
  - [x] Support default style
  - [ ] Support theming

- [ ] Radio button (`RadioButton`)
  - [x] Support default style
  - [ ] Support theming

- [ ] Common buttons (`Button` and `ToggleButton`)
  - [x] Support default style
  - [ ] Support theming

- [ ] Icon buttons (`IconButton` and `IconToggleButton`)
  - [x] Support default style
  - [ ] Support theming

- [ ] Standard button group (`StandardButtonGroup`)
  - One of the most complex widgets to implement, will probably require a custom render object. In that case children will be required to support dry layout.

- [ ] Connected button group (`ConnectedButtonGroup`)

- [ ] FAB

- [ ] FAB menu

- [ ] App bar
  - [x] Implement using existing `SliverAppBar`
  - [ ] Improve title layout to account for actions
  - [ ] Fully custom implementation (must use `SliverPersistentHeader` under the hood)


| a | b | c |
| - | - | - |
| 1 | 2 | 3 |

```dart
class SliverMarkdown extends MarkdownWidget {
  /// Creates a scrolling widget that parses and displays Markdown.
  const SliverMarkdown({
    super.key,
    required super.data,
    super.selectable,
    super.styleSheet,
    super.styleSheetTheme = null,
    super.syntaxHighlighter,
    super.onSelectionChanged,
    super.onTapLink,
    super.onTapText,
    super.imageDirectory,
    super.blockSyntaxes,
    super.inlineSyntaxes,
    super.extensionSet,
    super.imageBuilder,
    super.checkboxBuilder,
    super.bulletBuilder,
    super.builders,
    super.paddingBuilders,
    super.listItemCrossAxisAlignment,
    super.softLineBreak,
  });

  @override
  Widget build(BuildContext context, List<Widget>? children) {
    return SliverList.list(children: children!);
  }
}
```
""";

const String _readme = r"""
> [!IMPORTANT]
> You are viewing a fork of the original **Obtainium** project.
>
> If you are looking for the original, proceed to [**ImranR98/Obtainium**](https://github.com/ImranR98/Obtainium).
>
> To view details about this fork, go to the [**Fork**](#fork) section.

<div align="center">
  <img width="96" height="96" src="./assets/graphics/icon_small.png" alt="Obtainium Icon">
  <h3>Obtainium</h3>
  <p>Get Android app updates straight from the source.</p>
  <h6>
    Original by
    <a href="https://github.com/ImranR98"><b>ImranR98</b></a>
    · Modified by
    <a href="https://github.com/deminearchiver"><b>deminearchiver</b></a>
  </h6>
  <p>
    <a href="https://github.com/deminearchiver/Obtainium/issues/new?template=bug_report.md">Report a bug</a>
    ·
    <a href="https://github.com/deminearchiver/Obtainium/issues/new?template=feature_request.md">Request a feature</a>
  </p>
</div>

<details>
  <summary>
    <h3>Table of contents</h3>
  </summary>

- [Fork](#fork)
  - [Self-built only](#self-built-only)
    - [What about codesigning?](#what-about-codesigning)
  - [Redesign](#redesign)
    - [Material 3 Expressive](#material-3-expressive)
    - [Markdown styles update](#markdown-styles-update)
  - [Internal changes](#internal-changes)
  - [Other](#other)
- [Roadmap](#roadmap)
  - [Material 3 Expressive](#material-3-expressive-1)
- [About](#about)
  - [Useful links](#useful-links)
  - [Supported app sources](#supported-app-sources)
    - [Open Source (general)](#open-source-general)
    - [Other (general)](#other-general)
    - [Other (app-specific)](#other-app-specific)
    - [Direct APK Link](#direct-apk-link)
    - [HTML](#html)
- [Finding app configurations](#finding-app-configurations)
- [Limitations](#limitations)
</details>

## Fork

The repository you are currenly viewing [**deminearchiver/Obtainium**](https://github.com/deminearchiver/Obtainium) is a **fork** of [**ImranR98/Obtainium**](https://github.com/ImranR98/Obtainium).

In this section the primary differences and deviations compared to the original project are described.

### Self-built only

Unfortunately, this fork does not provide any builds. If you want to use this version the app, you'll have to build it from source.

#### What about codesigning?

For the time being, it's recommended to use the default "debug" keystore for release builds, as redistribution of builds is not provided.

### Redesign

The redesign of the app is introduced through incremental adoption, which involves introducing changes gradually.

#### Material 3 Expressive

This version of the app features the all-new fresh and shiny [**Material 3 Expressive**](https://m3.material.io) open-source design system created at **Google**.

The [**2025 "Expressive" update**](https://m3.material.io/blog/building-with-m3-expressive) the Material You design system received a big update, which made it look more polished and finished.

Currently, implementation of **Material 3 Expressive** design across the app is considered incomplete, but over time the support for the new design language will improve.

The design changes begin with refactoring the code for a certain UI element, then using legacy styling methods to achieve wanted looks. In order to fully embrace the new design language, it's needed to create new implementations for certain UI elements. This process is slow and tedious, hence the adoption of the new design language will be split a number of migration steps depending on the specific component's complexity. In the process of the redesign, the UI may looks incomplete, but it's the only way to properly apply design changes currently.

#### Markdown styles update

The app uses Markdown to display certain rich text messages, namely changelogs for tracked apps.

While not a part of the Material Design spec, a refresh of the default Markdown styles is urgently needed.

The priority of this change is low, because Markdown is rarely encountered throughout the app normally.

No significant changes were made to Markdown stylesheets yet, because the update is at the design stage.


### Internal changes

This fork features important developer-facing changes, such as:

- Differences in the process of building the app.

- Updated tooling configurations:
  - Removal of Docked support.
  - Framework and SDK updates.

- Code style updates:
  - General improvement of code quality.
  - Application of widely known best practices.
  - Added support for EditorConfig.

- Resolving feature deprecations *(and introducing new ones)*.

- Source code splitting via [internal unpublished packages](https://docs.flutter.dev/packages-and-plugins/using-packages#dependencies-on-unpublished-packages), such as custom implementations of layout, UI, platform interfaces, internationalization, assets.

### Other

Currently, there are a lot of changes not yet covered in this section, which means that this section is incomplete. The changelist will be updated and more changes will be described.

## Roadmap

This section contains the list of projects that are planned to be implemented.

### Material 3 Expressive

Many Material widgets used still come from Flutter's Material library. The long-standing goal of this project is to get rid of the dependency on Flutter's Material library. It is considered "legacy" in the scope of this repository (it's not actually deprecated).

Here's a list of widgets that are planned to have a custom implementation:
- [ ] Switch (`Switch`)
  - [x] Support default style
  - [ ] Support theming
- [ ] Checkbox (`Checkbox`)
  - [x] Support default style
  - [ ] Support theming
- [ ] Radio button (`RadioButton`)
  - [x] Support default style
  - [ ] Support theming
- [ ] Common buttons (`Button` and `ToggleButton`)
  - [x] Support default style
  - [ ] Support theming
- [ ] Icon buttons (`IconButton` and `IconToggleButton`)
  - [x] Support default style
  - [ ] Support theming
- [ ] Standard button group (`StandardButtonGroup`)
  - One of the most complex widgets to implement, will probably require a custom render object. In that case children will be required to support dry layout.
- [ ] Connected button group (`ConnectedButtonGroup`)
- [ ] FAB
- [ ] FAB menu
- [ ] App bar
  - [x] Implement using existing `SliverAppBar`
  - [ ] Improve title layout to account for actions
  - [ ] Fully custom implementation (must use `SliverPersistentHeader` under the hood)

<!-- ### Organization

This list contains changes regarding the project's repository. -->

## About

Obtainium allows you to install and update apps directly from their releases pages, and receive notifications when new releases are made available.

### Useful links

- [Obtainium Wiki](https://wiki.obtainium.imranr.dev/) ([repository](https://github.com/ImranR98/Obtainium-Wiki))
- [Obtainium 101](https://www.youtube.com/watch?v=0MF_v2OBncw) - Tutorial video
- [AppVerifier](https://github.com/soupslurpr/AppVerifier) - App verification tool (recommended, integrates with Obtainium)
- [apps.obtainium.imranr.dev](https://apps.obtainium.imranr.dev/) - Crowdsourced app configurations ([repository](https://github.com/ImranR98/apps.obtainium.imranr.dev))
- [Side Of Burritos - You should use this instead of F-Droid | How to use app RSS feed](https://youtu.be/FFz57zNR_M0) - Original motivation for this app
- [Website](https://obtainium.imranr.dev) ([repository](https://github.com/ImranR98/obtainium.imranr.dev))
- [Source code](https://github.com/ImranR98/Obtainium)

### Supported app sources

#### Open Source (general)

- [GitHub](https://github.com/)
- [GitLab](https://gitlab.com/)
- [Forgejo](https://forgejo.org/) ([Codeberg](https://codeberg.org/))
- [F-Droid](https://f-droid.org/) and third-party repos
- [IzzyOnDroid](https://android.izzysoft.de/)
- [SourceHut](https://git.sr.ht/)

#### Other (general)

- [APKPure](https://apkpure.net/)
- [Aptoide](https://aptoide.com/)
- [Uptodown](https://uptodown.com/)
- [Huawei AppGallery](https://appgallery.huawei.com/)
- [Tencent App Store](https://sj.qq.com/)
- [CoolApk](https://coolapk.com/)
- [vivo App Store (CN)](https://h5.appstore.vivo.com.cn/)
- [RuStore](https://rustore.ru/)
- [Farsroid](https://www.farsroid.com)
- Jenkins Jobs
- [APKMirror](https://apkmirror.com/) (Track-Only)

#### Other (app-specific)

- [Telegram App](https://telegram.org/)
- [Neutron Code](https://neutroncode.com/)

#### Direct APK Link

#### HTML

Any other URL that returns an HTML page with links to APK files

## Finding app configurations

You can find crowdsourced app configurations at [**apps.obtainium.imranr.dev**](https://apps.obtainium.imranr.dev).

If you can't find the configuration for an app you want, feel free to leave a request on the [**Discussions page**](https://github.com/ImranR98/apps.obtainium.imranr.dev/discussions/new?category=app-requests).

Or, contribute some configurations to the website by creating a PR at [**ImranR98/apps.obtainium.imranr.dev**](https://github.com/ImranR98/apps.obtainium.imranr.dev).

<!-- ## Installation

[<img src="https://raw.githubusercontent.com/NeoApplications/Neo-Backup/034b226cea5c1b30eb4f6a6f313e4dadcbb0ece4/badge_github.png"
    alt="Get it on GitHub"
    height="80">](https://github.com/ImranR98/Obtainium/releases)
[<img src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png"
     alt="Get it on IzzyOnDroid"
     height="80">](https://apt.izzysoft.de/fdroid/index/apk/dev.imranr.obtainium)
[<img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png"
    alt="Get it on F-Droid"
    height="80">](https://f-droid.org/packages/dev.imranr.obtainium.fdroid/)

Verification info:
- Package ID: `dev.imranr.obtainium`
- SHA-256 hash of signing certificate: `B3:53:60:1F:6A:1D:5F:D6:60:3A:E2:F5:0B:E8:0C:F3:01:36:7B:86:B6:AB:8B:1F:66:24:3D:A9:6C:D5:73:62`
  - Note: The above signature is also valid for the F-Droid flavour of Obtainium, thanks to [reproducible builds](https://f-droid.org/docs/Reproducible_Builds/).
- [PGP Public Key](https://keyserver.ubuntu.com/pks/lookup?search=contact%40imranr.dev&fingerprint=on&op=index) (to verify APK hashes) -->

## Limitations

For some sources, data is gathered using Web scraping and can easily break due to changes in website design. In such cases, more reliable methods may be unavailable.

<!-- ## Screenshots

| <img src="./assets/screenshots/1.apps.png" alt="Apps Page" /> | <img src="./assets/screenshots/2.dark_theme.png" alt="Dark Theme" />           | <img src="./assets/screenshots/3.material_you.png" alt="Material You" />    |
| ------------------------------------------------------ | ----------------------------------------------------------------------- | -------------------------------------------------------------------- |
| <img src="./assets/screenshots/4.app.png" alt="App Page" />   | <img src="./assets/screenshots/5.app_opts.png" alt="App Options" /> | <img src="./assets/screenshots/6.app_webview.png" alt="App Web View" /> | -->

""";

const String _markdownIt = r"""---
__Advertisement :)__

- __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image
  resize in browser.
- __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly
  i18n with plurals support and easy syntax.

You will like those projects!

---

# h1 Heading 8-)
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading


## Horizontal Rules

___

---

***


## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,  -- ---

"Smartypants, double quotes" and 'single quotes'


## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.


## Lists

Unordered

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

Ordered

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa


1. You can use sequential numbers...
1. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar


## Code

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code


Block code "fences"

```
Sample text here...
```

Syntax highlighting

``` js
var foo = function (bar) {
  return bar++;
};

console.log(foo(5));
```

## Tables

| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |

Right aligned columns

| Option | Description |
| ------:| -----------:|
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |


## Links

[link text](http://dev.nodeca.com)

[link with title](http://nodeca.github.io/pica/demo/ "title text!")

Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, Images also have a footnote style syntax

![Alt text][id]

With a reference later in the document defining the URL location:

[id]: https://octodex.github.com/images/dojocat.jpg  "The Dojocat"


## Plugins

The killer feature of `markdown-it` is very effective support of
[syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

> Classic markup: :wink: :cry: :laughing: :yum:
>
> Shortcuts (emoticons): :-) :-( 8-) ;)

see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

- 19^th^
- H~2~O


### [\<ins>](https://github.com/markdown-it/markdown-it-ins)

++Inserted text++


### [\<mark>](https://github.com/markdown-it/markdown-it-mark)

==Marked text==


### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

Footnote 1 link[^first].

Footnote 2 link[^second].

Inline footnote^[Text of inline footnote] definition.

Duplicated footnote reference[^second].

[^first]: Footnote **can have markup**

    and multiple paragraphs.

[^second]: Footnote text.


### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

Term 1

:   Definition 1
with lazy continuation.

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

_Compact style:_

Term 1
  ~ Definition 1

Term 2
  ~ Definition 2a
  ~ Definition 2b


### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

This is HTML abbreviation example.

It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

*[HTML]: Hyper Text Markup Language

### [Custom containers](https://github.com/markdown-it/markdown-it-container)

::: warning
*here be dragons*
:::""";

class ReadOnlyCheckboxComponentBuilder implements ComponentBuilder {
  const ReadOnlyCheckboxComponentBuilder();

  @override
  TaskComponentViewModel? createViewModel(
    Document document,
    DocumentNode node,
  ) {
    if (node is! TaskNode) {
      return null;
    }

    final textDirection = getParagraphDirection(node.text.toPlainText());

    return TaskComponentViewModel(
      nodeId: node.id,
      createdAt: node.metadata[NodeMetadata.createdAt],
      padding: EdgeInsets.zero,
      indent: node.indent,
      isComplete: node.isComplete,
      setComplete: null,
      text: node.text,
      textDirection: textDirection,
      textAlignment: textDirection == TextDirection.ltr
          ? TextAlign.left
          : TextAlign.right,
      textStyleBuilder: noStyleBuilder,
      selectionColor: const Color(0x00000000),
    );
  }

  @override
  Widget? createComponent(
    SingleColumnDocumentComponentContext componentContext,
    SingleColumnLayoutComponentViewModel componentViewModel,
  ) {
    if (componentViewModel is! TaskComponentViewModel) {
      return null;
    }
    return CheckboxComponent(
      key: componentContext.componentKey,
      viewModel: componentViewModel,
    );
  }
}

class CheckboxComponent extends StatefulWidget {
  const CheckboxComponent({
    super.key,
    required this.viewModel,
    this.showDebugPaint = false,
  });

  final TaskComponentViewModel viewModel;
  final bool showDebugPaint;

  @override
  State<CheckboxComponent> createState() => _CheckboxComponentState();
}

class _CheckboxComponentState extends State<CheckboxComponent>
    with ProxyDocumentComponent<CheckboxComponent>, ProxyTextComposable {
  final _textKey = GlobalKey();

  @override
  GlobalKey<State<StatefulWidget>> get childDocumentComponentKey => _textKey;

  @override
  TextComposable get childTextComposable =>
      childDocumentComponentKey.currentState as TextComposable;

  /// Computes the [TextStyle] for this task's inner [TextComponent].
  TextStyle _computeStyles(Set<Attribution> attributions) {
    // Show a strikethrough across the entire task if it's complete.
    final style = widget.viewModel.textStyleBuilder(attributions);
    return widget.viewModel.isComplete
        ? style.copyWith(
            decoration: style.decoration == null
                ? TextDecoration.lineThrough
                : TextDecoration.combine([
                    TextDecoration.lineThrough,
                    style.decoration!,
                  ]),
          )
        : style;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.viewModel.textDirection,
      child: Flex.horizontal(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: widget.viewModel.indentCalculator(
              widget.viewModel.textStyleBuilder({}),
              widget.viewModel.indent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 4),
            child: IgnorePointer(
              ignoring: widget.viewModel.setComplete == null,
              child: Checkbox.biState(
                checked: widget.viewModel.isComplete,
                onCheckedChanged: (value) {
                  widget.viewModel.setComplete?.call(value);
                },
              ),
            ),
          ),
          Flexible.tight(
            child: TextComponent(
              key: _textKey,
              text: widget.viewModel.text,
              textDirection: widget.viewModel.textDirection,
              textAlign: widget.viewModel.textAlignment,
              textStyleBuilder: _computeStyles,
              inlineWidgetBuilders: widget.viewModel.inlineWidgetBuilders,
              textSelection: widget.viewModel.selection,
              selectionColor: widget.viewModel.selectionColor,
              highlightWhenEmpty: widget.viewModel.highlightWhenEmpty,
              underlines: widget.viewModel.createUnderlines(),
              showDebugPaint: widget.showDebugPaint,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsAppBar extends StatefulWidget {
  const SettingsAppBar({super.key});

  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();
}

class _SettingsAppBarState extends State<SettingsAppBar> {
  final GlobalKey _containerKey = GlobalKey();

  Future<void> _openView() async {
    final navigator = Navigator.of(context);
    final route = _SettingsAppBarRoute(containerKey: _containerKey);
    navigator.push(route);
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final colorTheme = ColorTheme.of(context);
    final shapeTheme = ShapeTheme.of(context);
    final stateTheme = StateTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);
    final height = 64.0;
    final extent = padding.top + height;

    return SliverHeader(
      minExtent: extent,
      maxExtent: extent,
      pinned: true,
      builder: (context, shrinkOffset, overlapsContent) => SizedBox(
        width: double.infinity,
        height: extent,
        child: Material(
          color: colorTheme.surfaceContainer,
          child: Padding(
            padding: EdgeInsets.only(top: padding.top),
            child: Flex.horizontal(
              children: [
                const SizedBox(width: 8.0 - 4.0),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                    animationDuration: Duration.zero,
                    elevation: const WidgetStatePropertyAll(0.0),
                    shadowColor: WidgetStateColor.transparent,
                    minimumSize: const WidgetStatePropertyAll(Size.zero),
                    fixedSize: const WidgetStatePropertyAll(Size(40.0, 40.0)),
                    maximumSize: const WidgetStatePropertyAll(Size.infinite),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    iconSize: const WidgetStatePropertyAll(24.0),
                    shape: WidgetStatePropertyAll(
                      CornersBorder.rounded(
                        corners: Corners.all(shapeTheme.corner.full),
                      ),
                    ),
                    overlayColor: WidgetStateLayerColor(
                      color: WidgetStatePropertyAll(
                        colorTheme.onSurfaceVariant,
                      ),
                      opacity: stateTheme.stateLayerOpacity,
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => states.contains(WidgetState.disabled)
                          ? colorTheme.onSurface.withValues(alpha: 0.1)
                          : Colors.transparent,
                    ),
                    iconColor: WidgetStateProperty.resolveWith(
                      (states) => states.contains(WidgetState.disabled)
                          ? colorTheme.onSurface.withValues(alpha: 0.38)
                          : colorTheme.onSurface,
                    ),
                  ),
                  icon: const IconLegacy(Symbols.arrow_back_rounded),
                ),
                const SizedBox(width: 8.0 - 4.0),
                Flexible.tight(
                  child: KeyedSubtree(
                    key: _containerKey,
                    child: SizedBox(
                      height: 56.0,
                      child: Material(
                        animationDuration: Duration.zero,
                        type: MaterialType.card,
                        clipBehavior: Clip.antiAlias,
                        color: colorTheme.surfaceBright,
                        shape: CornersBorder.rounded(
                          corners: Corners.all(shapeTheme.corner.full),
                        ),
                        child: InkWell(
                          overlayColor: WidgetStateLayerColor(
                            color: WidgetStatePropertyAll(colorTheme.onSurface),
                            opacity: stateTheme.stateLayerOpacity,
                          ),
                          onTap: _openView,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              24.0,
                              0.0,
                              24.0,
                              0.0,
                            ),
                            child: Flex.horizontal(
                              children: [
                                Flexible.tight(
                                  child: Text(
                                    "Search Settings",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: typescaleTheme.bodyLarge.toTextStyle(
                                      color: colorTheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0 - 4.0),

                MenuButtonTheme(
                  data: MenuButtonThemeData(
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      minimumSize: WidgetStatePropertyAll(
                        Size(double.infinity, 48.0),
                      ),
                      maximumSize: WidgetStatePropertyAll(
                        Size(double.infinity, 48.0),
                      ),
                      textStyle: WidgetStatePropertyAll(
                        typescaleTheme.titleSmall.toTextStyle(),
                      ),
                    ),
                  ),
                  child: MenuAnchor(
                    consumeOutsideTap: true,
                    crossAxisUnconstrained: false,
                    style: MenuStyle(
                      minimumSize: const WidgetStatePropertyAll(
                        Size(208.0, 0.0),
                      ),
                      maximumSize: const WidgetStatePropertyAll(
                        Size(280.0, double.infinity),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        colorTheme.surface,
                      ),
                      shape: WidgetStatePropertyAll(
                        CornersBorder.rounded(
                          corners: Corners.all(Corner.circular(24.0)),
                        ),
                      ),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 12.0),
                      ),
                    ),
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon: Icon(
                          Symbols.reset_settings_rounded,
                          color: colorTheme.onSurfaceVariant,
                          size: 20.0,
                          opticalSize: 20.0,
                        ),
                        child: Text("Reset settings"),
                      ),
                    ],
                    builder: (context, controller, child) => IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      style: ButtonStyle(
                        animationDuration: Duration.zero,
                        elevation: const WidgetStatePropertyAll(0.0),
                        shadowColor: WidgetStateColor.transparent,
                        minimumSize: const WidgetStatePropertyAll(Size.zero),
                        fixedSize: const WidgetStatePropertyAll(
                          Size(40.0, 40.0),
                        ),
                        maximumSize: const WidgetStatePropertyAll(
                          Size.infinite,
                        ),
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                        iconSize: const WidgetStatePropertyAll(24.0),
                        shape: WidgetStatePropertyAll(
                          CornersBorder.rounded(
                            corners: Corners.all(shapeTheme.corner.full),
                          ),
                        ),
                        overlayColor: WidgetStateLayerColor(
                          color: WidgetStatePropertyAll(
                            colorTheme.onSurfaceVariant,
                          ),
                          opacity: stateTheme.stateLayerOpacity,
                        ),
                        backgroundColor: WidgetStateProperty.resolveWith(
                          (states) => states.contains(WidgetState.disabled)
                              ? colorTheme.onSurface.withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        iconColor: WidgetStateProperty.resolveWith(
                          (states) => states.contains(WidgetState.disabled)
                              ? colorTheme.onSurface.withValues(alpha: 0.38)
                              : colorTheme.onSurfaceVariant,
                        ),
                      ),
                      icon: const IconLegacy(Symbols.more_vert_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0 - 4.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsAppBarRoute<T extends Object?> extends PopupRoute<T> {
  _SettingsAppBarRoute({
    required this.containerKey,
    super.directionalTraversalEdgeBehavior,
    super.filter,
    super.requestFocus,
    super.settings,
    super.traversalEdgeBehavior,
  });

  final GlobalKey containerKey;

  CurvedAnimation _curvedAnimation = CurvedAnimation(
    parent: kAlwaysDismissedAnimation,
    curve: Curves.linear,
  );

  void _didChangeState({required Animation<double> animation}) {
    if (_curvedAnimation.parent != animation) {
      _curvedAnimation.dispose();
      _curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubicEmphasized,
        reverseCurve: Curves.easeInOutCubicEmphasized.flipped,
      );
    }
  }

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Durations.extralong4;

  @override
  Duration get reverseTransitionDuration => Durations.extralong4;

  @override
  void install() {
    // TODO: implement install
    super.install();
  }

  @override
  void dispose() {
    _curvedAnimation.dispose();
    super.dispose();
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    _didChangeState(animation: animation);

    final containerBox =
        containerKey.currentContext?.findRenderObject()! as RenderBox;
    final containerRect =
        containerBox.localToGlobal(Offset.zero) & containerBox.size;

    final Tween<Rect?> rectTween = RectTween(begin: containerRect);

    final colorTheme = ColorTheme.of(context);
    final shapeTheme = ShapeTheme.of(context);
    final stateTheme = StateTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);

    final colorTween = ColorTween(
      begin: colorTheme.surfaceBright,
      end: colorTheme.surfaceContainerHigh,
    );
    final shapeTween = ShapeBorderTween(
      begin: CornersBorder.rounded(
        corners: Corners.all(Corner.circular(containerRect.shortestSide / 2.0)),
      ),
      end: CornersBorder.rounded(corners: Corners.all(shapeTheme.corner.none)),
    );

    final padding = MediaQuery.paddingOf(context);

    final extent = padding.top + 72.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final viewRect = Offset.zero & constraints.biggest;
        assert(viewRect.isFinite);
        rectTween.end = viewRect;
        final rect = rectTween.evaluate(_curvedAnimation)!;
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: Color.lerp(
                  colorTheme.surfaceContainerHigh.withValues(alpha: 0.0),
                  colorTheme.surfaceContainerHigh,
                  _curvedAnimation.value,
                )!,
              ),
            ),
            Align.topLeft(
              child: Transform.translate(
                offset: rect.topLeft,
                child: SizedBox(
                  width: rect.width,
                  height: rect.height,
                  child: Material(
                    animationDuration: Duration.zero,
                    clipBehavior: Clip.antiAlias,
                    color: colorTween.evaluate(_curvedAnimation)!,
                    shape: shapeTween.evaluate(_curvedAnimation),
                    child: OverflowBox(
                      alignment: Alignment.topLeft,
                      minWidth: viewRect.width,
                      maxWidth: viewRect.width,
                      minHeight: viewRect.height,
                      maxHeight: viewRect.height,
                      child: Transform.translate(
                        offset: Offset.lerp(
                          Offset(
                            viewRect.left - containerRect.left,
                            viewRect.top - containerRect.top,
                          ),
                          Offset.zero,
                          _curvedAnimation.value,
                        )!,
                        child: CustomScrollView(
                          slivers: [
                            SliverHeader(
                              minExtent: extent,
                              maxExtent: extent,
                              builder: (context, shrinkOffset, overlapsContent) => SizedBox(
                                width: double.infinity,
                                height: extent,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    0.0,
                                    padding.top,
                                    0.0,
                                    0.0,
                                  ),
                                  child: KeyedSubtree(
                                    child: Flex.horizontal(
                                      children: [
                                        const SizedBox(width: 8.0 - 4.0),
                                        IconButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          style: ButtonStyle(
                                            animationDuration: Duration.zero,
                                            elevation:
                                                const WidgetStatePropertyAll(
                                                  0.0,
                                                ),
                                            shadowColor:
                                                WidgetStateColor.transparent,
                                            minimumSize:
                                                const WidgetStatePropertyAll(
                                                  Size.zero,
                                                ),
                                            fixedSize:
                                                const WidgetStatePropertyAll(
                                                  Size(40.0, 40.0),
                                                ),
                                            maximumSize:
                                                const WidgetStatePropertyAll(
                                                  Size.infinite,
                                                ),
                                            padding:
                                                const WidgetStatePropertyAll(
                                                  EdgeInsets.zero,
                                                ),
                                            iconSize:
                                                const WidgetStatePropertyAll(
                                                  24.0,
                                                ),
                                            shape: WidgetStatePropertyAll(
                                              CornersBorder.rounded(
                                                corners: Corners.all(
                                                  shapeTheme.corner.full,
                                                ),
                                              ),
                                            ),
                                            overlayColor: WidgetStateLayerColor(
                                              color: WidgetStatePropertyAll(
                                                colorTheme.onSurfaceVariant,
                                              ),
                                              opacity:
                                                  stateTheme.stateLayerOpacity,
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.resolveWith(
                                                  (states) =>
                                                      states.contains(
                                                        WidgetState.disabled,
                                                      )
                                                      ? colorTheme.onSurface
                                                            .withValues(
                                                              alpha: 0.1,
                                                            )
                                                      : Colors.transparent,
                                                ),
                                            iconColor:
                                                WidgetStateProperty.resolveWith(
                                                  (states) =>
                                                      states.contains(
                                                        WidgetState.disabled,
                                                      )
                                                      ? colorTheme.onSurface
                                                            .withValues(
                                                              alpha: 0.38,
                                                            )
                                                      : colorTheme.onSurface,
                                                ),
                                          ),
                                          icon: const IconLegacy(
                                            Symbols.arrow_back_rounded,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0 - 4.0),
                                        Flexible.tight(
                                          child: TextField(
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Search Settings",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0 - 4.0),
                                        const SizedBox(width: 8.0 - 4.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return const Placeholder();
  }
}

class Settings2View extends StatefulWidget {
  const Settings2View({super.key});

  @override
  State<Settings2View> createState() => _Settings2ViewState();
}

class _Settings2ViewState extends State<Settings2View> {
  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final shapeTheme = ShapeTheme.of(context);
    final stateTheme = StateTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);
    final staticColors = StaticColorsData.fallback(
      variant: DynamicSchemeVariant.tonalSpot,
      brightness: Brightness.light,
      specVersion: DynamicSchemeSpecVersion.spec2025,
    ).harmonizeWithPrimary(colorTheme);

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      body: CustomScrollView(
        slivers: [
          // CustomAppBar(
          //   leading: const Padding(
          //     padding: EdgeInsets.only(left: 8.0 - 4.0),
          //     child: DeveloperPageBackButton(),
          //   ),
          //   type: CustomAppBarType.largeFlexible,
          //   behavior: CustomAppBarBehavior.duplicate,
          //   expandedContainerColor: colorTheme.surfaceContainer,
          //   collapsedContainerColor: colorTheme.surfaceContainer,
          //   collapsedPadding: const EdgeInsets.fromLTRB(
          //     8.0 + 40.0 + 8.0,
          //     0.0,
          //     16.0,
          //     0.0,
          //   ),
          //   title: Text("Settings"),
          // ),
          SettingsAppBar(),
          SliverList.list(
            children: [
              const SizedBox(height: 16 - 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListItemContainer(
                  isFirst: true,
                  containerColor: colorTheme.surfaceBright,
                  child: ListItemInteraction(
                    onTap: () {},
                    child: ListItemLayout(
                      isMultiline: true,
                      leading: SizedBox.square(
                        dimension: 40.0,
                        child: Material(
                          animationDuration: Duration.zero,
                          type: MaterialType.card,
                          clipBehavior: Clip.antiAlias,
                          color: staticColors.blue.colorFixedDim,
                          shape: CornersBorder.rounded(
                            corners: Corners.all(shapeTheme.corner.full),
                          ),
                          child: Align.center(
                            child: Icon(
                              Symbols.tune_rounded,
                              fill: 1.0,
                              color: staticColors.blue.onColorFixedVariant,
                            ),
                          ),
                        ),
                      ),
                      headline: Text("General"),
                      supportingText: Text("Behavioral options"),
                      trailing: const Icon(
                        Symbols.keyboard_arrow_right_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListItemContainer(
                  containerColor: colorTheme.surfaceBright,
                  child: ListItemInteraction(
                    onTap: () {},
                    child: ListItemLayout(
                      isMultiline: true,
                      leading: SizedBox.square(
                        dimension: 40.0,
                        child: Material(
                          animationDuration: Duration.zero,
                          type: MaterialType.card,
                          clipBehavior: Clip.antiAlias,
                          color: staticColors.yellow.colorFixedDim,
                          shape: CornersBorder.rounded(
                            corners: Corners.all(shapeTheme.corner.full),
                          ),
                          child: Align.center(
                            child: Icon(
                              Symbols.palette_rounded,
                              fill: 1.0,
                              color: staticColors.yellow.onColorFixedVariant,
                            ),
                          ),
                        ),
                      ),
                      headline: Text("Appearance"),
                      supportingText: Text("App theme and language"),
                      trailing: const Icon(
                        Symbols.keyboard_arrow_right_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListItemContainer(
                  isLast: true,
                  containerColor: colorTheme.surfaceBright,
                  child: MergeSemantics(
                    child: ListItemInteraction(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const _Settings2AboutView(),
                        ),
                      ),
                      child: ListItemLayout(
                        isMultiline: true,
                        leading: SizedBox.square(
                          dimension: 40.0,
                          child: Material(
                            animationDuration: Duration.zero,
                            type: MaterialType.card,
                            clipBehavior: Clip.antiAlias,
                            color: staticColors.pink.colorFixedDim,
                            shape: const StadiumBorder(),
                            child: Align.center(
                              child: Icon(
                                Symbols.info_rounded,
                                fill: 1.0,
                                color: staticColors.pink.onColorFixedVariant,
                              ),
                            ),
                          ),
                        ),
                        headline: const Text("About"),
                        supportingText: const Text("App version and info"),
                        trailing: const Icon(
                          Symbols.keyboard_arrow_right_rounded,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.heightOf(context)),
          ),
        ],
      ),
    );
  }
}

class _Settings2AboutView extends StatefulWidget {
  const _Settings2AboutView({super.key});

  @override
  State<_Settings2AboutView> createState() => _Settings2AboutViewState();
}

class _Settings2AboutViewState extends State<_Settings2AboutView> {
  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: 8.0 - 4.0),
              child: DeveloperPageBackButton(),
            ),
            type: CustomAppBarType.largeFlexible,
            behavior: CustomAppBarBehavior.duplicate,
            expandedContainerColor: colorTheme.surfaceContainer,
            collapsedContainerColor: colorTheme.surfaceContainer,
            collapsedPadding: const EdgeInsets.fromLTRB(
              8.0 + 40.0 + 8.0,
              0.0,
              16.0,
              0.0,
            ),
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}

class _MaterialDemoView extends StatefulWidget {
  const _MaterialDemoView({super.key});

  @override
  State<_MaterialDemoView> createState() => _MaterialDemoViewState();
}

class _MaterialDemoViewState extends State<_MaterialDemoView> {
  bool _enabled = true;
  bool _selected = false;
  double _progress = 0.0;

  final List<RoundedPolygon> _indeterminateIndicatorPolygons1 = [
    MaterialShapes.flower,
    MaterialShapes.clover8Leaf,
    MaterialShapes.clover4Leaf,
  ];
  final List<RoundedPolygon> _indeterminateIndicatorPolygons2 = [
    MaterialShapes.gem,
    MaterialShapes.verySunny,
    MaterialShapes.pentagon,
    MaterialShapes.puffyDiamond,
    MaterialShapes.softBoom,
    MaterialShapes.sunny,
  ];

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final shapeTheme = ShapeTheme.of(context);
    final stateTheme = StateTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);
    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            CustomAppBar(
              leading: const Padding(
                padding: EdgeInsets.only(left: 8.0 - 4.0),
                child: DeveloperPageBackButton(),
              ),
              type: CustomAppBarType.largeFlexible,
              behavior: CustomAppBarBehavior.duplicate,
              expandedContainerColor: colorTheme.surfaceContainer,
              collapsedContainerColor: colorTheme.surfaceContainer,
              collapsedPadding: const EdgeInsets.fromLTRB(
                8.0 + 40.0 + 8.0,
                0.0,
                16.0,
                0.0,
              ),
              title: Text("Material 3 Expressive"),
              subtitle: Text("Design system"),
            ),
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListItemContainer(
                    isFirst: true,
                    isLast: true,
                    containerShape: const StadiumBorder(),
                    containerColor: colorTheme.primaryContainer,
                    child: MergeSemantics(
                      child: ListItemInteraction(
                        onTap: () => setState(() => _selected = !_selected),
                        stateLayerColor: WidgetStatePropertyAll(
                          colorTheme.onPrimaryContainer,
                        ),
                        child: ListItemLayout(
                          isMultiline: true,
                          minHeight: 72.0,
                          maxHeight: 72.0,
                          padding: const EdgeInsets.fromLTRB(
                            32.0,
                            0.0,
                            20.0 - 8.0,
                            0.0,
                          ),
                          headline: Text(
                            "Android 16 Switch",
                            style: typescaleTheme.titleMediumEmphasized
                                .toTextStyle(
                                  color: colorTheme.onPrimaryContainer,
                                ),
                          ),
                          trailing: ExcludeFocus(
                            child: Switch(
                              onCheckedChanged: (value) =>
                                  setState(() => _selected = value),
                              checked: _selected,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListItemContainer(
                    isFirst: true,
                    child: MergeSemantics(
                      child: ListItemInteraction(
                        onTap: () => setState(() => _enabled = !_enabled),
                        child: ListItemLayout(
                          isMultiline: true,
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            12.0,
                            16.0 - 8.0,
                            12.0,
                          ),
                          leading: const Icon(Symbols.ads_click, fill: 1.0),
                          headline: const Text(
                            "Enable basic input",
                            maxLines: 2,
                          ),
                          trailing: ExcludeFocus(
                            child: Switch(
                              onCheckedChanged: (value) =>
                                  setState(() => _enabled = value),
                              checked: _enabled,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListItemContainer(
                    isLast: true,
                    child: Flex.vertical(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListItemLayout(
                          isMultiline: true,
                          leading: const Icon(
                            Symbols.check_box_rounded,
                            fill: 1.0,
                          ),
                          headline: Text(
                            "Basic input",
                            style: TextStyle(
                              color: _enabled
                                  ? null
                                  : colorTheme.onSurface.withValues(
                                      alpha: 0.38,
                                    ),
                            ),
                          ),
                          supportingText: Text(
                            "Switch · Checkbox · Radio button",
                            style: TextStyle(
                              color: _enabled
                                  ? null
                                  : colorTheme.onSurface.withValues(
                                      alpha: 0.38,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            0.0,
                            16.0,
                            16.0,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 160.0),
                            child: Flex.horizontal(
                              spacing: 16.0,
                              children: [
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Switch(
                                      onCheckedChanged: _enabled
                                          ? (value) => setState(
                                              () => _selected = value,
                                            )
                                          : null,
                                      checked: _selected,
                                    ),
                                  ),
                                ),
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Checkbox.biState(
                                      onCheckedChanged: _enabled
                                          ? (value) => setState(
                                              () => _selected = value,
                                            )
                                          : null,
                                      checked: _selected,
                                    ),
                                  ),
                                ),
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: RadioButton(
                                      onTap: _enabled
                                          ? () => setState(
                                              () => _selected = !_selected,
                                            )
                                          : null,
                                      selected: _selected,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 8.0),
                  child: Text(
                    "Loading indicator",
                    style: typescaleTheme.labelLarge.toTextStyle(
                      color: colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListItemContainer(
                    isFirst: true,
                    child: Flex.vertical(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const ListItemLayout(
                          isMultiline: true,
                          leading: Icon(Symbols.refresh_rounded),
                          headline: Text("Loading indicator"),
                          supportingText: Text("Indeterminate · Uncontained"),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            0.0,
                            16.0,
                            16.0,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 160.0),
                            child: Flex.horizontal(
                              spacing: 16.0,
                              children: [
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: LoadingIndicator(),
                                  ),
                                ),
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: LoadingIndicator(
                                      indicatorPolygons:
                                          _indeterminateIndicatorPolygons1,
                                    ),
                                  ),
                                ),
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: LoadingIndicator(
                                      indicatorPolygons:
                                          _indeterminateIndicatorPolygons2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListItemContainer(
                    child: Flex.vertical(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const ListItemLayout(
                          isMultiline: true,
                          leading: Icon(Symbols.refresh_rounded),
                          headline: Text("Loading indicator"),
                          supportingText: Text("Indeterminate · Contained"),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            0.0,
                            16.0,
                            16.0,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 160.0),
                            child: Flex.horizontal(
                              spacing: 16.0,
                              children: [
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: LoadingIndicator.contained(),
                                  ),
                                ),
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: LoadingIndicator.contained(
                                      indicatorPolygons:
                                          _indeterminateIndicatorPolygons1,
                                    ),
                                  ),
                                ),
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: LoadingIndicator.contained(
                                      indicatorPolygons:
                                          _indeterminateIndicatorPolygons2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListItemContainer(
                    isLast: true,
                    child: Flex.vertical(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListItemLayout(
                          isMultiline: true,
                          leading: const Icon(Symbols.sync_arrow_down_rounded),
                          headline: const Text("Loading indicator"),
                          supportingText: const Text("Determinate · Contained"),
                          trailing: Text("${(_progress * 100.0).round()}%"),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0.0,
                            0.0,
                            0.0,
                            16.0,
                          ),
                          child: Slider(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            value: _progress,
                            onChanged: (value) =>
                                setState(() => _progress = value),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            0.0,
                            16.0,
                            16.0,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 160.0),
                            child: Flex.horizontal(
                              spacing: 16.0,
                              children: [
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: DeterminateLoadingIndicator(
                                      progress: _progress,
                                    ),
                                  ),
                                ),
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: DeterminateLoadingIndicator(
                                      progress: _progress,
                                      indicatorPolygons: [
                                        ..._indeterminateIndicatorPolygons1,
                                        _indeterminateIndicatorPolygons1.first,
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible.tight(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: DeterminateLoadingIndicator(
                                      progress: _progress,
                                      indicatorPolygons: [
                                        ..._indeterminateIndicatorPolygons2,
                                        _indeterminateIndicatorPolygons2.first,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
            // SliverToBoxAdapter(
            //   child: SizedBox(height: MediaQuery.heightOf(context)),
            // ),
          ],
        ),
      ),
    );
  }
}
