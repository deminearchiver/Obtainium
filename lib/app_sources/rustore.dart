import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:obtainium/custom_errors.dart';
import 'package:obtainium/providers/source_provider.dart';

class RuStore extends AppSource {
  RuStore() {
    hosts = ['rustore.ru'];
    name = 'RuStore';
    naiveStandardVersionDetection = true;
    showReleaseDateAsVersionToggle = true;
  }

  @override
  String sourceSpecificStandardizeURL(String url, {bool forSelection = false}) {
    RegExp standardUrlRegEx = RegExp(
      '^https?://(www\\.)?${getSourceRegex(hosts)}/catalog/app/+[^/]+',
      caseSensitive: false,
    );
    RegExpMatch? match = standardUrlRegEx.firstMatch(url);
    if (match == null) {
      throw InvalidURLError(name);
    }
    return match.group(0)!;
  }

  @override
  Future<String?> tryInferringAppId(
    String standardUrl, {
    Map<String, dynamic> additionalSettings = const {},
  }) async {
    return Uri.parse(standardUrl).pathSegments.last;
  }

  Future<dynamic> decodeJsonBody(Uint8List bytes) async {
    try {
      return jsonDecode((await CharsetDetector.autoDecode(bytes)).string);
    } catch (e) {
      try {
        return jsonDecode(utf8.decode(bytes));
      } catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<APKDetails> getLatestAPKDetails(
    String standardUrl,
    Map<String, dynamic> additionalSettings,
  ) async {
    String? appId = await tryInferringAppId(standardUrl);
    final res0 = await sourceRequest(
      'https://backapi.rustore.ru/applicationData/overallInfo/$appId',
      additionalSettings,
    );
    if (res0.statusCode != 200) {
      throw getObtainiumHttpError(res0);
    }
    var appDetails = (await decodeJsonBody(res0.bodyBytes))['body'];
    if (appDetails['appId'] == null) {
      throw NoReleasesError();
    }

    String appName = appDetails['appName'] ?? tr('app');
    String author = appDetails['companyName'] ?? name;
    String? dateStr = appDetails['appVerUpdatedAt'];
    String? version = appDetails['versionName'];
    String? changeLog = appDetails['whatsNew'];
    if (version == null) {
      throw NoVersionError();
    }
    DateTime? relDate;
    if (dateStr != null) {
      relDate = DateTime.parse(dateStr);
    }

    final res1 = await sourceRequest(
      'https://backapi.rustore.ru/applicationData/v2/download-link',
      additionalSettings,
      followRedirects: false,
      postBody: {"appId": appDetails['appId'], "firstInstall": true},
    );
    var downloadDetails = (await decodeJsonBody(res1.bodyBytes))['body'];
    if (res1.statusCode != 200 ||
        downloadDetails['downloadUrls'][0]['url'] == null) {
      throw NoAPKError();
    }

    return APKDetails(
      version,
      getApkUrlsFromUrls([
        (downloadDetails['downloadUrls'][0]['url'] as String).replaceAll(
          RegExp('\\.zip\$'),
          '.apk',
        ),
      ]),
      AppNames(author, appName),
      releaseDate: relDate,
      changeLog: changeLog,
    );
  }
}
