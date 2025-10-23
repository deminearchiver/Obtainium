// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Contributor _$ContributorFromJson(Map<String, dynamic> json) => _Contributor(
  login: json['login'] as String?,
  id: (json['id'] as num?)?.toInt(),
  nodeId: json['node_id'] as String?,
  avatarUrl: json['avatar_url'] == null
      ? null
      : Uri.parse(json['avatar_url'] as String),
  gravatarId: json['gravatar_id'] as String?,
  url: json['url'] == null ? null : Uri.parse(json['url'] as String),
  htmlUrl: json['html_url'] == null
      ? null
      : Uri.parse(json['html_url'] as String),
  followersUrl: json['followers_url'] == null
      ? null
      : Uri.parse(json['followers_url'] as String),
  followingUrl: json['following_url'] as String?,
  gistsUrl: json['gists_url'] as String?,
  starredUrl: json['starred_url'] as String?,
  subscriptionsUrl: json['subscriptions_url'] == null
      ? null
      : Uri.parse(json['subscriptions_url'] as String),
  organizationsUrl: json['organizations_url'] == null
      ? null
      : Uri.parse(json['organizations_url'] as String),
  reposUrl: json['repos_url'] == null
      ? null
      : Uri.parse(json['repos_url'] as String),
  eventsUrl: json['events_url'] as String?,
  receivedEventsUrl: json['received_events_url'] == null
      ? null
      : Uri.parse(json['received_events_url'] as String),
  type: json['type'] as String,
  siteAdmin: json['site_admin'] as bool? ?? false,
  contributions: (json['contributions'] as num).toInt(),
  email: json['email'] as String?,
  name: json['name'] as String?,
  userViewType: json['user_view_type'] as String?,
);

Map<String, dynamic> _$ContributorToJson(_Contributor instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'avatar_url': instance.avatarUrl?.toString(),
      'gravatar_id': instance.gravatarId,
      'url': instance.url?.toString(),
      'html_url': instance.htmlUrl?.toString(),
      'followers_url': instance.followersUrl?.toString(),
      'following_url': instance.followingUrl,
      'gists_url': instance.gistsUrl,
      'starred_url': instance.starredUrl,
      'subscriptions_url': instance.subscriptionsUrl?.toString(),
      'organizations_url': instance.organizationsUrl?.toString(),
      'repos_url': instance.reposUrl?.toString(),
      'events_url': instance.eventsUrl,
      'received_events_url': instance.receivedEventsUrl?.toString(),
      'type': instance.type,
      'site_admin': instance.siteAdmin,
      'contributions': instance.contributions,
      'email': instance.email,
      'name': instance.name,
      'user_view_type': instance.userViewType,
    };
