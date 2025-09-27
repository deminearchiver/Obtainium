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
