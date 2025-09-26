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

  /// en: 'Not a valid $sourceName app URL'
  String invalidURLForSource({required Object sourceName}) =>
      'Not a valid ${sourceName} app URL';

  /// en: 'Could not find a suitable release'
  String get noReleaseFound => 'Could not find a suitable release';

  /// en: 'Could not determine release version'
  String get noVersionFound => 'Could not determine release version';

  /// en: 'URL does not match a known source'
  String get urlMatchesNoSource => 'URL does not match a known source';

  /// en: 'Cannot install an older version of an app'
  String get cantInstallOlderVersion =>
      'Cannot install an older version of an app';

  /// en: 'Downloaded package ID does not match existing app ID'
  String get appIdMismatch =>
      'Downloaded package ID does not match existing app ID';

  /// en: 'This class has not implemented this function'
  String get functionNotImplemented =>
      'This class has not implemented this function';

  /// en: 'Placeholder'
  String get placeholder => 'Placeholder';

  /// en: 'Some errors occurred'
  String get someErrors => 'Some errors occurred';

  /// en: 'Unexpected error'
  String get unexpectedError => 'Unexpected error';

  /// en: 'Okay'
  String get ok => 'Okay';

  /// en: 'and'
  String get and => 'and';

  /// en: 'GitHub personal access token (increases rate limit)'
  String get githubPATLabel =>
      'GitHub personal access token (increases rate limit)';

  /// en: 'Include prereleases'
  String get includePrereleases => 'Include prereleases';

  /// en: 'Fallback to older releases'
  String get fallbackToOlderReleases => 'Fallback to older releases';

  /// en: 'Filter release titles by regular expression'
  String get filterReleaseTitlesByRegEx =>
      'Filter release titles by regular expression';

  /// en: 'Invalid regular expression'
  String get invalidRegEx => 'Invalid regular expression';

  /// en: 'No description'
  String get noDescription => 'No description';

  /// en: 'Cancel'
  String get cancel => 'Cancel';

  /// en: 'Continue'
  String get kContinue => 'Continue';

  /// en: '(required)'
  String get requiredInBrackets => '(required)';

  /// en: 'ERROR: DROPDOWN MUST HAVE AT LEAST ONE OPT'
  String get dropdownNoOptsError =>
      'ERROR: DROPDOWN MUST HAVE AT LEAST ONE OPT';

  /// en: 'Colour'
  String get colour => 'Colour';

  /// en: 'Standard'
  String get standard => 'Standard';

  /// en: 'Custom'
  String get custom => 'Custom';

  /// en: 'Use Material You'
  String get useMaterialYou => 'Use Material You';

  /// en: 'GitHub starred repositories'
  String get githubStarredRepos => 'GitHub starred repositories';

  /// en: 'Username'
  String get uname => 'Username';

  /// en: 'Wrong number of arguments provided'
  String get wrongArgNum => 'Wrong number of arguments provided';

  /// en: '$x is track-only'
  String xIsTrackOnly({required Object x}) => '${x} is track-only';

  /// en: 'Source'
  String get source => 'Source';

  /// en: 'App'
  String get app => 'App';

  /// en: 'Apps from this source are 'track-only'.'
  String get appsFromSourceAreTrackOnly =>
      'Apps from this source are \'track-only\'.';

  /// en: 'You have selected the 'track-only' option.'
  String get youPickedTrackOnly =>
      'You have selected the \'track-only\' option.';

  /// en: 'The app will be tracked for updates, but Obtainium will not be able to download or install it.'
  String get trackOnlyAppDescription =>
      'The app will be tracked for updates, but Obtainium will not be able to download or install it.';

  /// en: 'Cancelled'
  String get cancelled => 'Cancelled';

  /// en: 'App already added'
  String get appAlreadyAdded => 'App already added';

  /// en: 'App already up to date?'
  String get alreadyUpToDateQuestion => 'App already up to date?';

  /// en: 'Add app'
  String get addApp => 'Add app';

  /// en: 'App source URL'
  String get appSourceURL => 'App source URL';

  /// en: 'Error'
  String get error => 'Error';

  /// en: 'Add'
  String get add => 'Add';

  /// en: 'Search (some sources only)'
  String get searchSomeSourcesLabel => 'Search (some sources only)';

  /// en: 'Search'
  String get search => 'Search';

  /// en: 'Additional options for $x'
  String additionalOptsFor({required Object x}) =>
      'Additional options for ${x}';

  /// en: 'Supported sources'
  String get supportedSources => 'Supported sources';

  /// en: '(track-only)'
  String get trackOnlyInBrackets => '(track-only)';

  /// en: '(searchable)'
  String get searchableInBrackets => '(searchable)';

  /// en: 'Apps'
  String get appsString => 'Apps';

  /// en: 'No apps'
  String get noApps => 'No apps';

  /// en: 'No apps for filter'
  String get noAppsForFilter => 'No apps for filter';

  /// en: 'By $x'
  String byX({required Object x}) => 'By ${x}';

  /// en: 'Progress: $percentage%'
  String percentProgress({required Object percentage}) =>
      'Progress: ${percentage}%';

  /// en: 'Please wait'
  String get pleaseWait => 'Please wait';

  /// en: 'Update available'
  String get updateAvailable => 'Update available';

  /// en: 'Not installed'
  String get notInstalled => 'Not installed';

  /// en: 'pseudo-version'
  String get pseudoVersion => 'pseudo-version';

  /// en: 'Select all'
  String get selectAll => 'Select all';

  /// en: 'Deselect $x'
  String deselectX({required Object x}) => 'Deselect ${x}';

  /// en: '$x will be removed from Obtainium but remain installed on device.'
  String xWillBeRemovedButRemainInstalled({required Object x}) =>
      '${x} will be removed from Obtainium but remain installed on device.';

  /// en: 'Remove selected apps?'
  String get removeSelectedAppsQuestion => 'Remove selected apps?';

  /// en: 'Remove selected apps'
  String get removeSelectedApps => 'Remove selected apps';

  /// en: 'Update $x'
  String updateX({required Object x}) => 'Update ${x}';

  /// en: 'Install $x'
  String installX({required Object x}) => 'Install ${x}';

  /// en: 'Mark $x (track-only) as updated'
  String markXTrackOnlyAsUpdated({required Object x}) =>
      'Mark ${x}\n(track-only)\nas updated';

  /// en: 'Change $x'
  String changeX({required Object x}) => 'Change ${x}';

  /// en: 'Install/update apps'
  String get installUpdateApps => 'Install/update apps';

  /// en: 'Install/update selected apps'
  String get installUpdateSelectedApps => 'Install/update selected apps';

  /// en: 'Mark $x selected apps as updated?'
  String markXSelectedAppsAsUpdated({required Object x}) =>
      'Mark ${x} selected apps as updated?';

  /// en: 'No'
  String get no => 'No';

  /// en: 'Yes'
  String get yes => 'Yes';

  /// en: 'Mark selected apps as updated'
  String get markSelectedAppsUpdated => 'Mark selected apps as updated';

  /// en: 'Pin to top'
  String get pinToTop => 'Pin to top';

  /// en: 'Unpin from top'
  String get unpinFromTop => 'Unpin from top';

  /// en: 'Reset install status for selected apps?'
  String get resetInstallStatusForSelectedAppsQuestion =>
      'Reset install status for selected apps?';

  /// en: 'The install status of any selected apps will be reset. This can help when the app version shown in Obtainium is incorrect due to failed updates or other issues.'
  String get installStatusOfXWillBeResetExplanation =>
      'The install status of any selected apps will be reset.\n\nThis can help when the app version shown in Obtainium is incorrect due to failed updates or other issues.';

  /// en: 'These links work on devices with Obtainium installed'
  String get customLinkMessage =>
      'These links work on devices with Obtainium installed';

  /// en: 'Share app configuration as HTML link'
  String get shareAppConfigLinks => 'Share app configuration as HTML link';

  /// en: 'Share selected app URLs'
  String get shareSelectedAppURLs => 'Share selected app URLs';

  /// en: 'Reset install status'
  String get resetInstallStatus => 'Reset install status';

  /// en: 'More'
  String get more => 'More';

  /// en: 'Remove out-of-date app filter'
  String get removeOutdatedFilter => 'Remove out-of-date app filter';

  /// en: 'Show out-of-date apps only'
  String get showOutdatedOnly => 'Show out-of-date apps only';

  /// en: 'Filter'
  String get filter => 'Filter';

  /// en: 'Filter apps'
  String get filterApps => 'Filter apps';

  /// en: 'App name'
  String get appName => 'App name';

  /// en: 'Author'
  String get author => 'Author';

  /// en: 'Up to date apps'
  String get upToDateApps => 'Up to date apps';

  /// en: 'Non-installed apps'
  String get nonInstalledApps => 'Non-installed apps';

  /// en: 'Import/export'
  String get importExport => 'Import/export';

  /// en: 'Settings'
  String get settings => 'Settings';

  /// en: 'Exported to $x'
  String exportedTo({required Object x}) => 'Exported to ${x}';

  /// en: 'Obtainium export'
  String get obtainiumExport => 'Obtainium export';

  /// en: 'Invalid input'
  String get invalidInput => 'Invalid input';

  /// en: 'Imported $x'
  String importedX({required Object x}) => 'Imported ${x}';

  /// en: 'Obtainium import'
  String get obtainiumImport => 'Obtainium import';

  /// en: 'Import from URL list'
  String get importFromURLList => 'Import from URL list';

  /// en: 'Search query'
  String get searchQuery => 'Search query';

  /// en: 'App URL list'
  String get appURLList => 'App URL list';

  /// en: 'Line'
  String get line => 'Line';

  /// en: 'Search $x'
  String searchX({required Object x}) => 'Search ${x}';

  /// en: 'No results found'
  String get noResults => 'No results found';

  /// en: 'Import $x'
  String importX({required Object x}) => 'Import ${x}';

  /// en: 'Imported apps may incorrectly show as "not installed". To fix this, re-install them through Obtainium. This should not affect app data. Only affects URL and third-party import methods.'
  String get importedAppsIdDisclaimer =>
      'Imported apps may incorrectly show as "not installed".\nTo fix this, re-install them through Obtainium.\nThis should not affect app data.\n\nOnly affects URL and third-party import methods.';

  /// en: 'Import errors'
  String get importErrors => 'Import errors';

  /// en: '$x of $y apps imported.'
  String importedXOfYApps({required Object x, required Object y}) =>
      '${x} of ${y} apps imported.';

  /// en: 'The following URLs had errors:'
  String get followingURLsHadErrors => 'The following URLs had errors:';

  /// en: 'Select URL'
  String get selectURL => 'Select URL';

  /// en: 'Select URLs'
  String get selectURLs => 'Select URLs';

  /// en: 'Pick'
  String get pick => 'Pick';

  /// en: 'Theme'
  String get theme => 'Theme';

  /// en: 'Dark'
  String get dark => 'Dark';

  /// en: 'Light'
  String get light => 'Light';

  /// en: 'Follow system'
  String get followSystem => 'Follow system';

  /// en: 'Following system theme is possible only by using third-party applications'
  String get followSystemThemeExplanation =>
      'Following system theme is possible only by using third-party applications';

  /// en: 'Use pure black dark theme'
  String get useBlackTheme => 'Use pure black dark theme';

  /// en: 'App sort by'
  String get appSortBy => 'App sort by';

  /// en: 'Author/name'
  String get authorName => 'Author/name';

  /// en: 'Name/author'
  String get nameAuthor => 'Name/author';

  /// en: 'As added'
  String get asAdded => 'As added';

  /// en: 'App sort order'
  String get appSortOrder => 'App sort order';

  /// en: 'Ascending'
  String get ascending => 'Ascending';

  /// en: 'Descending'
  String get descending => 'Descending';

  /// en: 'Background update checking interval'
  String get bgUpdateCheckInterval => 'Background update checking interval';

  /// en: 'Never - manual only'
  String get neverManualOnly => 'Never - manual only';

  /// en: 'Appearance'
  String get appearance => 'Appearance';

  /// en: 'Show source webpage in app view'
  String get showWebInAppView => 'Show source webpage in app view';

  /// en: 'Pin updates to top of apps view'
  String get pinUpdates => 'Pin updates to top of apps view';

  /// en: 'Updates'
  String get updates => 'Updates';

  /// en: 'Source-specific'
  String get sourceSpecific => 'Source-specific';

  /// en: 'App source'
  String get appSource => 'App source';

  /// en: 'No logs'
  String get noLogs => 'No logs';

  /// en: 'App logs'
  String get appLogs => 'App logs';

  /// en: 'Close'
  String get close => 'Close';

  /// en: 'Share'
  String get share => 'Share';

  /// en: 'App not found'
  String get appNotFound => 'App not found';

  /// en: 'obtainium-export'
  String get obtainiumExportHyphenatedLowercase => 'obtainium-export';

  /// en: 'Pick an APK'
  String get pickAnAPK => 'Pick an APK';

  /// en: '$x has more than one package:'
  String appHasMoreThanOnePackage({required Object x}) =>
      '${x} has more than one package:';

  /// en: 'Your device supports the $x CPU architecture.'
  String deviceSupportsXArch({required Object x}) =>
      'Your device supports the ${x} CPU architecture.';

  /// en: 'Your device supports the following CPU architectures:'
  String get deviceSupportsFollowingArchs =>
      'Your device supports the following CPU architectures:';

  /// en: 'Warning'
  String get warning => 'Warning';

  /// en: 'The app source is '$x' but the release package comes from '$y'. Continue?'
  String sourceIsXButPackageFromYPrompt({
    required Object x,
    required Object y,
  }) =>
      'The app source is \'${x}\' but the release package comes from \'${y}\'. Continue?';

  /// en: 'Updates available'
  String get updatesAvailable => 'Updates available';

  /// en: 'Notifies the user that updates are available for one or more apps tracked by Obtainium'
  String get updatesAvailableNotifDescription =>
      'Notifies the user that updates are available for one or more apps tracked by Obtainium';

  /// en: 'No new updates.'
  String get noNewUpdates => 'No new updates.';

  /// en: '{} has an update.'
  String get xHasAnUpdate => '{} has an update.';

  /// en: 'Apps updated'
  String get appsUpdated => 'Apps updated';

  /// en: 'Failed to update applications'
  String get appsNotUpdated => 'Failed to update applications';

  /// en: 'Notifies the user that updates to one or more apps were applied in the background'
  String get appsUpdatedNotifDescription =>
      'Notifies the user that updates to one or more apps were applied in the background';

  /// en: '{} was updated to {}.'
  String get xWasUpdatedToY => '{} was updated to {}.';

  /// en: 'Failed to update {} to {}.'
  String get xWasNotUpdatedToY => 'Failed to update {} to {}.';

  /// en: 'Error checking for updates'
  String get errorCheckingUpdates => 'Error checking for updates';

  /// en: 'A notification that shows when background update checking fails'
  String get errorCheckingUpdatesNotifDescription =>
      'A notification that shows when background update checking fails';

  /// en: 'Apps removed'
  String get appsRemoved => 'Apps removed';

  /// en: 'Notifies the user that one or more apps were removed due to errors while loading them'
  String get appsRemovedNotifDescription =>
      'Notifies the user that one or more apps were removed due to errors while loading them';

  /// en: '{} was removed due to this error: {}'
  String get xWasRemovedDueToErrorY => '{} was removed due to this error: {}';

  /// en: 'Complete app installation'
  String get completeAppInstallation => 'Complete app installation';

  /// en: 'Obtainium must be open to install apps'
  String get obtainiumMustBeOpenToInstallApps =>
      'Obtainium must be open to install apps';

  /// en: 'Asks the user to return to Obtainium to finish installing an app'
  String get completeAppInstallationNotifDescription =>
      'Asks the user to return to Obtainium to finish installing an app';

  /// en: 'Checking for updates'
  String get checkingForUpdates => 'Checking for updates';

  /// en: 'Transient notification that appears when checking for updates'
  String get checkingForUpdatesNotifDescription =>
      'Transient notification that appears when checking for updates';

  /// en: 'Please allow Obtainium to install apps'
  String get pleaseAllowInstallPerm => 'Please allow Obtainium to install apps';

  /// en: 'Track-only'
  String get trackOnly => 'Track-only';

  /// en: 'Error {}'
  String get errorWithHttpStatusCode => 'Error {}';

  /// en: 'Version correction disabled (plugin doesn't seem to work)'
  String get versionCorrectionDisabled =>
      'Version correction disabled (plugin doesn\'t seem to work)';

  /// en: 'Unknown'
  String get unknown => 'Unknown';

  /// en: 'None'
  String get none => 'None';

  /// en: 'All'
  String get all => 'All';

  /// en: 'Never'
  String get never => 'Never';

  /// en: 'Latest: {}'
  String get latestVersionX => 'Latest: {}';

  /// en: 'Installed: {}'
  String get installedVersionX => 'Installed: {}';

  /// en: 'Last update check: {}'
  String get lastUpdateCheckX => 'Last update check: {}';

  /// en: 'Remove'
  String get remove => 'Remove';

  /// en: 'Yes, mark as updated'
  String get yesMarkUpdated => 'Yes, mark as updated';

  /// en: 'F-Droid official'
  String get fdroid => 'F-Droid official';

  /// en: 'App ID or name'
  String get appIdOrName => 'App ID or name';

  /// en: 'App ID'
  String get appId => 'App ID';

  /// en: 'No app was found with that ID or name'
  String get appWithIdOrNameNotFound => 'No app was found with that ID or name';

  /// en: 'Repos may contain multiple apps'
  String get reposHaveMultipleApps => 'Repos may contain multiple apps';

  /// en: 'F-Droid third-party repo'
  String get fdroidThirdPartyRepo => 'F-Droid third-party repo';

  /// en: 'Install'
  String get install => 'Install';

  /// en: 'Mark installed'
  String get markInstalled => 'Mark installed';

  /// en: 'Update'
  String get update => 'Update';

  /// en: 'Mark updated'
  String get markUpdated => 'Mark updated';

  /// en: 'Additional options'
  String get additionalOptions => 'Additional options';

  /// en: 'Disable version detection'
  String get disableVersionDetection => 'Disable version detection';

  /// en: 'This option should only be used for apps where version detection does not work correctly.'
  String get noVersionDetectionExplanation =>
      'This option should only be used for apps where version detection does not work correctly.';

  /// en: 'Downloading {}'
  String get downloadingX => 'Downloading {}';

  /// en: 'Download {}'
  String get downloadX => 'Download {}';

  /// en: 'Downloaded {}'
  String get downloadedX => 'Downloaded {}';

  /// en: 'Release asset'
  String get releaseAsset => 'Release asset';

  /// en: 'Notifies the user of the progress in downloading an app'
  String get downloadNotifDescription =>
      'Notifies the user of the progress in downloading an app';

  /// en: 'No APK found'
  String get noAPKFound => 'No APK found';

  /// en: 'No version detection'
  String get noVersionDetection => 'No version detection';

  /// en: 'Categorize'
  String get categorize => 'Categorize';

  /// en: 'Categories'
  String get categories => 'Categories';

  /// en: 'Category'
  String get category => 'Category';

  /// en: 'No category'
  String get noCategory => 'No category';

  /// en: 'No categories'
  String get noCategories => 'No categories';

  /// en: 'Delete categories?'
  String get deleteCategoriesQuestion => 'Delete categories?';

  /// en: 'All apps in deleted categories will be set to uncategorized.'
  String get categoryDeleteWarning =>
      'All apps in deleted categories will be set to uncategorized.';

  /// en: 'Add category'
  String get addCategory => 'Add category';

  /// en: 'Label'
  String get label => 'Label';

  /// en: 'Language'
  String get language => 'Language';

  /// en: 'Copied to clipboard'
  String get copiedToClipboard => 'Copied to clipboard';

  /// en: 'Storage permission denied'
  String get storagePermissionDenied => 'Storage permission denied';

  /// en: 'This will replace any existing category settings for the selected apps.'
  String get selectedCategorizeWarning =>
      'This will replace any existing category settings for the selected apps.';

  /// en: 'Filter APKs by regular expression'
  String get filterAPKsByRegEx => 'Filter APKs by regular expression';

  /// en: 'Remove from Obtainium'
  String get removeFromObtainium => 'Remove from Obtainium';

  /// en: 'Uninstall from device'
  String get uninstallFromDevice => 'Uninstall from device';

  /// en: 'Only works for apps with version detection disabled.'
  String get onlyWorksWithNonVersionDetectApps =>
      'Only works for apps with version detection disabled.';

  /// en: 'Use release date as version string'
  String get releaseDateAsVersion => 'Use release date as version string';

  /// en: 'Use release title as version string'
  String get releaseTitleAsVersion => 'Use release title as version string';

  /// en: 'This option should only be used for apps where version detection does not work correctly, but a release date is available.'
  String get releaseDateAsVersionExplanation =>
      'This option should only be used for apps where version detection does not work correctly, but a release date is available.';

  /// en: 'Changes'
  String get changes => 'Changes';

  /// en: 'Release date'
  String get releaseDate => 'Release date';

  /// en: 'Import from URLs in file (like OPML)'
  String get importFromURLsInFile => 'Import from URLs in file (like OPML)';

  /// en: 'Reconcile version string with version detected from OS'
  String get versionDetectionExplanation =>
      'Reconcile version string with version detected from OS';

  /// en: 'Version detection'
  String get versionDetection => 'Version detection';

  /// en: 'Standard version detection'
  String get standardVersionDetection => 'Standard version detection';

  /// en: 'Group by category'
  String get groupByCategory => 'Group by category';

  /// en: 'Attempt to filter APKs by CPU architecture if possible'
  String get autoApkFilterByArch =>
      'Attempt to filter APKs by CPU architecture if possible';

  /// en: 'Attempt to filter links by CPU architecture if possible'
  String get autoLinkFilterByArch =>
      'Attempt to filter links by CPU architecture if possible';

  /// en: 'Override source'
  String get overrideSource => 'Override source';

  /// en: 'Don't show this again'
  String get dontShowAgain => 'Don\'t show this again';

  /// en: 'Don't show 'track-only' warnings'
  String get dontShowTrackOnlyWarnings => 'Don\'t show \'track-only\' warnings';

  /// en: 'Don't show APK origin warnings'
  String get dontShowAPKOriginWarnings => 'Don\'t show APK origin warnings';

  /// en: 'Move non-installed apps to bottom of apps view'
  String get moveNonInstalledAppsToBottom =>
      'Move non-installed apps to bottom of apps view';

  /// en: 'GitLab personal access token'
  String get gitlabPATLabel => 'GitLab personal access token';

  /// en: 'About'
  String get about => 'About';

  /// en: '{} needs additional credentials (in Settings)'
  String get requiresCredentialsInSettings =>
      '{} needs additional credentials (in Settings)';

  /// en: 'Check for updates on startup'
  String get checkOnStart => 'Check for updates on startup';

  /// en: 'Try inferring app ID from source code'
  String get tryInferAppIdFromCode => 'Try inferring app ID from source code';

  /// en: 'Automatically remove externally uninstalled apps'
  String get removeOnExternalUninstall =>
      'Automatically remove externally uninstalled apps';

  /// en: 'Auto-select highest version code APK'
  String get pickHighestVersionCode => 'Auto-select highest version code APK';

  /// en: 'Check for updates on opening an app detail page'
  String get checkUpdateOnDetailPage =>
      'Check for updates on opening an app detail page';

  /// en: 'Disable page transition animations'
  String get disablePageTransitions => 'Disable page transition animations';

  /// en: 'Reverse page transition animations'
  String get reversePageTransitions => 'Reverse page transition animations';

  /// en: 'Minimum star count'
  String get minStarCount => 'Minimum star count';

  /// en: 'Add this info below.'
  String get addInfoBelow => 'Add this info below.';

  /// en: 'Add this info in the Settings.'
  String get addInfoInSettings => 'Add this info in the Settings.';

  /// en: 'GitHub rate limiting can be avoided using an API key.'
  String get githubSourceNote =>
      'GitHub rate limiting can be avoided using an API key.';

  /// en: 'Sort by only the last segment of the link'
  String get sortByLastLinkSegment =>
      'Sort by only the last segment of the link';

  /// en: 'Filter release notes by regular expression'
  String get filterReleaseNotesByRegEx =>
      'Filter release notes by regular expression';

  /// en: 'Custom APK link filter by regular expression (default '.apk\$')'
  String get customLinkFilterRegex =>
      'Custom APK link filter by regular expression (default \'.apk\$\')';

  /// en: 'App updates attempted'
  String get appsPossiblyUpdated => 'App updates attempted';

  /// en: 'Notifies the user that updates to one or more apps were potentially applied in the background'
  String get appsPossiblyUpdatedNotifDescription =>
      'Notifies the user that updates to one or more apps were potentially applied in the background';

  /// en: '{} may have been updated to {}.'
  String get xWasPossiblyUpdatedToY => '{} may have been updated to {}.';

  /// en: 'Enable background updates'
  String get enableBackgroundUpdates => 'Enable background updates';

  /// en: 'Background updates may not be possible for all apps.'
  String get backgroundUpdateReqsExplanation =>
      'Background updates may not be possible for all apps.';

  /// en: 'The success of a background install can only be determined when Obtainium is opened.'
  String get backgroundUpdateLimitsExplanation =>
      'The success of a background install can only be determined when Obtainium is opened.';

  /// en: 'Verify the 'latest' tag'
  String get verifyLatestTag => 'Verify the \'latest\' tag';

  /// en: 'Filter for an 'intermediate' link to visit'
  String get intermediateLinkRegex =>
      'Filter for an \'intermediate\' link to visit';

  /// en: 'Filter links by link text'
  String get filterByLinkText => 'Filter links by link text';

  /// en: 'Match links outside <a> tags'
  String get matchLinksOutsideATags => 'Match links outside <a> tags';

  /// en: 'Intermediate link not found'
  String get intermediateLinkNotFound => 'Intermediate link not found';

  /// en: 'Intermediate link'
  String get intermediateLink => 'Intermediate link';

  /// en: 'Exempt from background updates (if enabled)'
  String get exemptFromBackgroundUpdates =>
      'Exempt from background updates (if enabled)';

  /// en: 'Disable background updates when not on Wi-Fi'
  String get bgUpdatesOnWiFiOnly =>
      'Disable background updates when not on Wi-Fi';

  /// en: 'Disable background updates when not charging'
  String get bgUpdatesWhileChargingOnly =>
      'Disable background updates when not charging';

  /// en: 'Auto-select highest versionCode APK'
  String get autoSelectHighestVersionCode =>
      'Auto-select highest versionCode APK';

  /// en: 'Version string extraction RegEx'
  String get versionExtractionRegEx => 'Version string extraction RegEx';

  /// en: 'Trim version string with RegEx'
  String get trimVersionString => 'Trim version string with RegEx';

  /// en: 'Match group to use for "{}"'
  String get matchGroupToUseForX => 'Match group to use for "{}"';

  /// en: 'Match group to use for version string extraction RegEx'
  String get matchGroupToUse =>
      'Match group to use for version string extraction RegEx';

  /// en: 'Highlight less obvious touch targets'
  String get highlightTouchTargets => 'Highlight less obvious touch targets';

  /// en: 'Pick export directory'
  String get pickExportDir => 'Pick export directory';

  /// en: 'Automatically export on changes'
  String get autoExportOnChanges => 'Automatically export on changes';

  /// en: 'Include settings'
  String get includeSettings => 'Include settings';

  /// en: 'Filter versions by regular expression'
  String get filterVersionsByRegEx => 'Filter versions by regular expression';

  /// en: 'Try selecting suggested versionCode APK'
  String get trySelectingSuggestedVersionCode =>
      'Try selecting suggested versionCode APK';

  /// en: 'Retain release order from API'
  String get dontSortReleasesList => 'Retain release order from API';

  /// en: 'Reverse sorting'
  String get reverseSort => 'Reverse sorting';

  /// en: 'Take first link'
  String get takeFirstLink => 'Take first link';

  /// en: 'Skip sorting'
  String get skipSort => 'Skip sorting';

  /// en: 'Debug menu'
  String get debugMenu => 'Debug menu';

  /// en: 'Background task started - check logs.'
  String get bgTaskStarted => 'Background task started - check logs.';

  /// en: 'Run background update check now'
  String get runBgCheckNow => 'Run background update check now';

  /// en: 'Apply version string extraction Regex to entire page'
  String get versionExtractWholePage =>
      'Apply version string extraction Regex to entire page';

  /// en: 'Installing'
  String get installing => 'Installing';

  /// en: 'Skip update notifications'
  String get skipUpdateNotifications => 'Skip update notifications';

  /// en: 'Updates available'
  String get updatesAvailableNotifChannel => 'Updates available';

  /// en: 'Apps updated'
  String get appsUpdatedNotifChannel => 'Apps updated';

  /// en: 'App updates attempted'
  String get appsPossiblyUpdatedNotifChannel => 'App updates attempted';

  /// en: 'Error checking for updates'
  String get errorCheckingUpdatesNotifChannel => 'Error checking for updates';

  /// en: 'Apps removed'
  String get appsRemovedNotifChannel => 'Apps removed';

  /// en: 'Downloading {}'
  String get downloadingXNotifChannel => 'Downloading {}';

  /// en: 'Complete app installation'
  String get completeAppInstallationNotifChannel => 'Complete app installation';

  /// en: 'Checking for updates'
  String get checkingForUpdatesNotifChannel => 'Checking for updates';

  /// en: 'Only check installed and track-only apps for updates'
  String get onlyCheckInstalledOrTrackOnlyApps =>
      'Only check installed and track-only apps for updates';

  /// en: 'Support fixed APK URLs'
  String get supportFixedAPKURL => 'Support fixed APK URLs';

  /// en: 'Select {}'
  String get selectX => 'Select {}';

  /// en: 'Allow parallel downloads'
  String get parallelDownloads => 'Allow parallel downloads';

  /// en: 'Use Shizuku or Sui to install'
  String get useShizuku => 'Use Shizuku or Sui to install';

  /// en: 'Shizuku service not running'
  String get shizukuBinderNotFound => 'Shizuku service not running';

  /// en: 'Old Shizuku version (<11) - update it'
  String get shizukuOld => 'Old Shizuku version (<11) - update it';

  /// en: 'Shizuku running on Android < 8.1 with ADB - update Android or use Sui instead'
  String get shizukuOldAndroidWithADB =>
      'Shizuku running on Android < 8.1 with ADB - update Android or use Sui instead';

  /// en: 'Set Google Play as the installation source (if Shizuku is used)'
  String get shizukuPretendToBeGooglePlay =>
      'Set Google Play as the installation source (if Shizuku is used)';

  /// en: 'Use the system font'
  String get useSystemFont => 'Use the system font';

  /// en: 'Use app versionCode as OS-detected version'
  String get useVersionCodeAsOSVersion =>
      'Use app versionCode as OS-detected version';

  /// en: 'Request header'
  String get requestHeader => 'Request header';

  /// en: 'Use latest asset upload as release date'
  String get useLatestAssetDateAsReleaseDate =>
      'Use latest asset upload as release date';

  /// en: 'Default pseudo-versioning method'
  String get defaultPseudoVersioningMethod =>
      'Default pseudo-versioning method';

  /// en: 'Partial APK hash'
  String get partialAPKHash => 'Partial APK hash';

  /// en: 'APK link hash'
  String get APKLinkHash => 'APK link hash';

  /// en: 'Direct APK link'
  String get directAPKLink => 'Direct APK link';

  /// en: 'A pseudo-version is in use'
  String get pseudoVersionInUse => 'A pseudo-version is in use';

  /// en: 'Installed'
  String get installed => 'Installed';

  /// en: 'Latest'
  String get latest => 'Latest';

  /// en: 'Invert regular expression'
  String get invertRegEx => 'Invert regular expression';

  /// en: 'Note'
  String get note => 'Note';

  /// en: 'The "{}" dropdown can be used to reach self-hosted/custom instances of any source.'
  String get selfHostedNote =>
      'The "{}" dropdown can be used to reach self-hosted/custom instances of any source.';

  /// en: 'The APK could not be parsed (incompatible or partial download)'
  String get badDownload =>
      'The APK could not be parsed (incompatible or partial download)';

  /// en: 'Share new apps with AppVerifier (if available)'
  String get beforeNewInstallsShareToAppVerifier =>
      'Share new apps with AppVerifier (if available)';

  /// en: 'Share to AppVerifier, then return here when ready.'
  String get appVerifierInstructionToast =>
      'Share to AppVerifier, then return here when ready.';

  /// en: 'Help/wiki'
  String get wiki => 'Help/wiki';

  /// en: 'Crowdsourced app configurations (use at your own risk)'
  String get crowdsourcedConfigsLabel =>
      'Crowdsourced app configurations (use at your own risk)';

  /// en: 'Crowdsourced app configurations'
  String get crowdsourcedConfigsShort => 'Crowdsourced app configurations';

  /// en: 'Allow insecure HTTP requests'
  String get allowInsecure => 'Allow insecure HTTP requests';

  /// en: 'Stay one version behind latest'
  String get stayOneVersionBehind => 'Stay one version behind latest';

  /// en: 'Auto-select first of multiple APKs'
  String get useFirstApkOfVersion => 'Auto-select first of multiple APKs';

  /// en: 'Refresh app details before download'
  String get refreshBeforeDownload => 'Refresh app details before download';

  /// en: 'Tencent App Store'
  String get tencentAppStore => 'Tencent App Store';

  /// en: 'CoolApk'
  String get coolApk => 'CoolApk';

  /// en: 'vivo App Store (CN)'
  String get vivoAppStore => 'vivo App Store (CN)';

  /// en: 'Name'
  String get name => 'Name';

  /// en: 'Name (smart)'
  String get smartname => 'Name (smart)';

  /// en: 'Sort method'
  String get sortMethod => 'Sort method';

  /// en: 'Welcome'
  String get welcome => 'Welcome';

  /// en: 'The Obtainium GitHub page linked below contains links to videos, articles, discussions, and other resources that will help you understand how to use the app.'
  String get documentationLinksNote =>
      'The Obtainium GitHub page linked below contains links to videos, articles, discussions, and other resources that will help you understand how to use the app.';

  /// en: 'Note that background downloads may work more reliably if you switch to the "foreground service" in the Obtainium settings and/or disable battery optimization for Obtainium in your OS settings.'
  String get batteryOptimizationNote =>
      'Note that background downloads may work more reliably if you switch to the "foreground service" in the Obtainium settings and/or disable battery optimization for Obtainium in your OS settings.';

  /// en: 'Failed to delete file (try deleting it manually then try again): "{}"'
  String get fileDeletionError =>
      'Failed to delete file (try deleting it manually then try again): "{}"';

  /// en: 'Obtainium foreground service'
  String get foregroundService => 'Obtainium foreground service';

  /// en: 'Use a foreground service for update checking (more reliable, consumes more power)'
  String get foregroundServiceExplanation =>
      'Use a foreground service for update checking (more reliable, consumes more power)';

  /// en: 'This notification is required for background update checking (it can be hidden in the OS settings)'
  String get fgServiceNotice =>
      'This notification is required for background update checking (it can be hidden in the OS settings)';

  /// en: 'Exclude secrets'
  String get excludeSecrets => 'Exclude secrets';

  /// en: ''sky22333/hubproxy' instance for GitHub requests'
  String get GHReqPrefix =>
      '\'sky22333/hubproxy\' instance for GitHub requests';

  /// en: '(one) {Remove app?} (other) {Remove apps?}'
  String removeAppQuestion({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Remove app?',
        other: 'Remove apps?',
      );

  /// en: '(one) {Too many requests (rate limited) - try again in $n minute} (other) {Too many requests (rate limited) - try again in $n minutes}'
  String tooManyRequestsTryAgainInMinutes({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Too many requests (rate limited) - try again in ${n} minute',
        other: 'Too many requests (rate limited) - try again in ${n} minutes',
      );

  /// en: '(one) {BG update checking encountered a {}, will schedule a retry check in {} minute} (other) {BG update checking encountered a {}, will schedule a retry check in {} minutes}'
  String bgUpdateGotErrorRetryInMinutes({
    required num n,
  }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
    n,
    one:
        'BG update checking encountered a {}, will schedule a retry check in {} minute',
    other:
        'BG update checking encountered a {}, will schedule a retry check in {} minutes',
  );

  /// en: '(one) {BG update checking found {} update - will notify user if needed} (other) {BG update checking found {} updates - will notify user if needed}'
  String bgCheckFoundUpdatesWillNotifyIfNeeded({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'BG update checking found {} update - will notify user if needed',
        other:
            'BG update checking found {} updates - will notify user if needed',
      );

  /// en: '(one) {$n App} (other) {$n Apps}'
  String apps({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} App',
        other: '${n} Apps',
      );

  /// en: '(one) {$n URL} (other) {$n URLs}'
  String url({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} URL',
        other: '${n} URLs',
      );

  /// en: '(one) {$n minute} (other) {$n minutes}'
  String minute({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} minute',
        other: '${n} minutes',
      );

  /// en: '(one) {$n hour} (other) {$n hours}'
  String hour({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} hour',
        other: '${n} hours',
      );

  /// en: '(one) {$n day} (other) {$n days}'
  String day({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} day',
        other: '${n} days',
      );

  /// en: '(one) {Cleared $n log (before = $before, after = $after)} (other) {Cleared $n logs (before = $before, after = $after)}'
  String clearedNLogsBeforeXAfterY({
    required num n,
    required Object before,
    required Object after,
  }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
    n,
    one: 'Cleared ${n} log (before = ${before}, after = ${after})',
    other: 'Cleared ${n} logs (before = ${before}, after = ${after})',
  );

  /// en: '(one) {{} and 1 more app have updates.} (other) {{} and {} more apps have updates.}'
  String xAndNMoreUpdatesAvailable({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '{} and 1 more app have updates.',
        other: '{} and {} more apps have updates.',
      );

  /// en: '(one) {{} and 1 more app was updated.} (other) {{} and {} more apps were updated.}'
  String xAndNMoreUpdatesInstalled({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '{} and 1 more app was updated.',
        other: '{} and {} more apps were updated.',
      );

  /// en: '(one) {Failed to update {} and 1 more app.} (other) {Failed to update {} and {} more apps.}'
  String xAndNMoreUpdatesFailed({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Failed to update {} and 1 more app.',
        other: 'Failed to update {} and {} more apps.',
      );

  /// en: '(one) {{} and 1 more app may have been updated.} (other) {{} and {} more apps may have been updated.}'
  String xAndNMoreUpdatesPossiblyInstalled({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '{} and 1 more app may have been updated.',
        other: '{} and {} more apps may have been updated.',
      );

  /// en: '(one) {{} APK} (other) {{} APKs}'
  String apk({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '{} APK',
        other: '{} APKs',
      );
}
