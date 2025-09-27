import 'dart:convert';

import 'package:http/http.dart';
import 'package:obtainium/custom_errors.dart';
import 'package:obtainium/providers/source_provider.dart';

class LiteApks extends AppSource {
  LiteApks() {
    hosts = ['liteapks.com'];
    name = 'LiteAPKs';
  }

  @override
  String sourceSpecificStandardizeURL(String url, {bool forSelection = false}) {
    RegExp standardUrlRegEx = RegExp(
      '^https?://(www\\.)?${getSourceRegex(hosts)}/+[^/]+',
      caseSensitive: false,
    );
    RegExpMatch? match = standardUrlRegEx.firstMatch(url);
    if (match == null) {
      throw InvalidURLError(name);
    }
    return match.group(0)!;
  }

  @override
  Future<APKDetails> getLatestAPKDetails(
    String standardUrl,
    Map<String, dynamic> additionalSettings,
  ) async {
    var standardUri = Uri.parse(standardUrl);
    var slug = standardUri.path
        .split('.')
        .reversed
        .toList()
        .sublist(1)
        .reversed
        .join('.');
    Response res1 = await sourceRequest(
      '${standardUri.origin}/wp-json/wp/v2/posts?slug=$slug',
      additionalSettings,
    );
    if (res1.statusCode != 200) {
      throw getObtainiumHttpError(res1);
    }

    var liteAppId = jsonDecode(res1.body)[0]['id'];
    if (liteAppId == null) {
      throw NoReleasesError();
    }

    Response res2 = await sourceRequest(
      '${standardUri.origin}/wp-json/v2/posts/$liteAppId',
      additionalSettings,
    );
    if (res2.statusCode != 200) {
      throw getObtainiumHttpError(res2);
    }
    var json = jsonDecode(res2.body);

    var appName = json['data']?['title'] as String?;
    var author = json['data']?['publisher'] as String?;
    var version = json['data']?['versions']?[0]?['version'] as String?;
    if (version == null) {
      throw NoVersionError();
    }
    var apkUrls =
        ((json['data']?['versions']?[0]?['version_downloads'] as List<dynamic>?)
                    ?.map((l) => l['version_download_link']) ??
                [])
            .map(
              (l) => MapEntry<String, String>(
                Uri.decodeComponent(Uri.parse(l).pathSegments.last),
                l,
              ),
            )
            .toList();
    return APKDetails(
      version,
      apkUrls,
      AppNames(
        author ?? Uri.parse(standardUrl).host,
        appName ?? standardUrl.split('/').last,
      ),
    );
  }
}
