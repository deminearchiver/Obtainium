import 'package:freezed_annotation/freezed_annotation.dart';

part 'github.g.dart';
part 'github.freezed.dart';

@freezed
abstract class Contributor with _$Contributor {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Contributor({
    String? login,
    int? id,
    String? nodeId,
    Uri? avatarUrl,
    String? gravatarId,
    Uri? url,
    Uri? htmlUrl,
    Uri? followersUrl,
    String? followingUrl,
    String? gistsUrl,
    String? starredUrl,
    Uri? subscriptionsUrl,
    Uri? organizationsUrl,
    Uri? reposUrl,
    String? eventsUrl,
    Uri? receivedEventsUrl,
    required String type,
    @Default(false) bool siteAdmin,
    required int contributions,
    String? email,
    String? name,
    String? userViewType,
  }) = _Contributor;

  factory Contributor.fromJson(Map<String, Object?> json) =>
      _$ContributorFromJson(json);
}
