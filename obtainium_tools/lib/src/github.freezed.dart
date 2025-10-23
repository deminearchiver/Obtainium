// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Contributor {

 String? get login; int? get id; String? get nodeId; Uri? get avatarUrl; String? get gravatarId; Uri? get url; Uri? get htmlUrl; Uri? get followersUrl; String? get followingUrl; String? get gistsUrl; String? get starredUrl; Uri? get subscriptionsUrl; Uri? get organizationsUrl; Uri? get reposUrl; String? get eventsUrl; Uri? get receivedEventsUrl; String get type; bool get siteAdmin; int get contributions; String? get email; String? get name; String? get userViewType;
/// Create a copy of Contributor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContributorCopyWith<Contributor> get copyWith => _$ContributorCopyWithImpl<Contributor>(this as Contributor, _$identity);

  /// Serializes this Contributor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Contributor&&(identical(other.login, login) || other.login == login)&&(identical(other.id, id) || other.id == id)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gravatarId, gravatarId) || other.gravatarId == gravatarId)&&(identical(other.url, url) || other.url == url)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.followersUrl, followersUrl) || other.followersUrl == followersUrl)&&(identical(other.followingUrl, followingUrl) || other.followingUrl == followingUrl)&&(identical(other.gistsUrl, gistsUrl) || other.gistsUrl == gistsUrl)&&(identical(other.starredUrl, starredUrl) || other.starredUrl == starredUrl)&&(identical(other.subscriptionsUrl, subscriptionsUrl) || other.subscriptionsUrl == subscriptionsUrl)&&(identical(other.organizationsUrl, organizationsUrl) || other.organizationsUrl == organizationsUrl)&&(identical(other.reposUrl, reposUrl) || other.reposUrl == reposUrl)&&(identical(other.eventsUrl, eventsUrl) || other.eventsUrl == eventsUrl)&&(identical(other.receivedEventsUrl, receivedEventsUrl) || other.receivedEventsUrl == receivedEventsUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.siteAdmin, siteAdmin) || other.siteAdmin == siteAdmin)&&(identical(other.contributions, contributions) || other.contributions == contributions)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.userViewType, userViewType) || other.userViewType == userViewType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,login,id,nodeId,avatarUrl,gravatarId,url,htmlUrl,followersUrl,followingUrl,gistsUrl,starredUrl,subscriptionsUrl,organizationsUrl,reposUrl,eventsUrl,receivedEventsUrl,type,siteAdmin,contributions,email,name,userViewType]);

@override
String toString() {
  return 'Contributor(login: $login, id: $id, nodeId: $nodeId, avatarUrl: $avatarUrl, gravatarId: $gravatarId, url: $url, htmlUrl: $htmlUrl, followersUrl: $followersUrl, followingUrl: $followingUrl, gistsUrl: $gistsUrl, starredUrl: $starredUrl, subscriptionsUrl: $subscriptionsUrl, organizationsUrl: $organizationsUrl, reposUrl: $reposUrl, eventsUrl: $eventsUrl, receivedEventsUrl: $receivedEventsUrl, type: $type, siteAdmin: $siteAdmin, contributions: $contributions, email: $email, name: $name, userViewType: $userViewType)';
}


}

/// @nodoc
abstract mixin class $ContributorCopyWith<$Res>  {
  factory $ContributorCopyWith(Contributor value, $Res Function(Contributor) _then) = _$ContributorCopyWithImpl;
@useResult
$Res call({
 String? login, int? id, String? nodeId, Uri? avatarUrl, String? gravatarId, Uri? url, Uri? htmlUrl, Uri? followersUrl, String? followingUrl, String? gistsUrl, String? starredUrl, Uri? subscriptionsUrl, Uri? organizationsUrl, Uri? reposUrl, String? eventsUrl, Uri? receivedEventsUrl, String type, bool siteAdmin, int contributions, String? email, String? name, String? userViewType
});




}
/// @nodoc
class _$ContributorCopyWithImpl<$Res>
    implements $ContributorCopyWith<$Res> {
  _$ContributorCopyWithImpl(this._self, this._then);

  final Contributor _self;
  final $Res Function(Contributor) _then;

/// Create a copy of Contributor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? login = freezed,Object? id = freezed,Object? nodeId = freezed,Object? avatarUrl = freezed,Object? gravatarId = freezed,Object? url = freezed,Object? htmlUrl = freezed,Object? followersUrl = freezed,Object? followingUrl = freezed,Object? gistsUrl = freezed,Object? starredUrl = freezed,Object? subscriptionsUrl = freezed,Object? organizationsUrl = freezed,Object? reposUrl = freezed,Object? eventsUrl = freezed,Object? receivedEventsUrl = freezed,Object? type = null,Object? siteAdmin = null,Object? contributions = null,Object? email = freezed,Object? name = freezed,Object? userViewType = freezed,}) {
  return _then(_self.copyWith(
login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,nodeId: freezed == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as Uri?,gravatarId: freezed == gravatarId ? _self.gravatarId : gravatarId // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,htmlUrl: freezed == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as Uri?,followersUrl: freezed == followersUrl ? _self.followersUrl : followersUrl // ignore: cast_nullable_to_non_nullable
as Uri?,followingUrl: freezed == followingUrl ? _self.followingUrl : followingUrl // ignore: cast_nullable_to_non_nullable
as String?,gistsUrl: freezed == gistsUrl ? _self.gistsUrl : gistsUrl // ignore: cast_nullable_to_non_nullable
as String?,starredUrl: freezed == starredUrl ? _self.starredUrl : starredUrl // ignore: cast_nullable_to_non_nullable
as String?,subscriptionsUrl: freezed == subscriptionsUrl ? _self.subscriptionsUrl : subscriptionsUrl // ignore: cast_nullable_to_non_nullable
as Uri?,organizationsUrl: freezed == organizationsUrl ? _self.organizationsUrl : organizationsUrl // ignore: cast_nullable_to_non_nullable
as Uri?,reposUrl: freezed == reposUrl ? _self.reposUrl : reposUrl // ignore: cast_nullable_to_non_nullable
as Uri?,eventsUrl: freezed == eventsUrl ? _self.eventsUrl : eventsUrl // ignore: cast_nullable_to_non_nullable
as String?,receivedEventsUrl: freezed == receivedEventsUrl ? _self.receivedEventsUrl : receivedEventsUrl // ignore: cast_nullable_to_non_nullable
as Uri?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,siteAdmin: null == siteAdmin ? _self.siteAdmin : siteAdmin // ignore: cast_nullable_to_non_nullable
as bool,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as int,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,userViewType: freezed == userViewType ? _self.userViewType : userViewType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Contributor implements Contributor {
  const _Contributor({this.login, this.id, this.nodeId, this.avatarUrl, this.gravatarId, this.url, this.htmlUrl, this.followersUrl, this.followingUrl, this.gistsUrl, this.starredUrl, this.subscriptionsUrl, this.organizationsUrl, this.reposUrl, this.eventsUrl, this.receivedEventsUrl, required this.type, this.siteAdmin = false, required this.contributions, this.email, this.name, this.userViewType});
  factory _Contributor.fromJson(Map<String, dynamic> json) => _$ContributorFromJson(json);

@override final  String? login;
@override final  int? id;
@override final  String? nodeId;
@override final  Uri? avatarUrl;
@override final  String? gravatarId;
@override final  Uri? url;
@override final  Uri? htmlUrl;
@override final  Uri? followersUrl;
@override final  String? followingUrl;
@override final  String? gistsUrl;
@override final  String? starredUrl;
@override final  Uri? subscriptionsUrl;
@override final  Uri? organizationsUrl;
@override final  Uri? reposUrl;
@override final  String? eventsUrl;
@override final  Uri? receivedEventsUrl;
@override final  String type;
@override@JsonKey() final  bool siteAdmin;
@override final  int contributions;
@override final  String? email;
@override final  String? name;
@override final  String? userViewType;

/// Create a copy of Contributor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContributorCopyWith<_Contributor> get copyWith => __$ContributorCopyWithImpl<_Contributor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContributorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contributor&&(identical(other.login, login) || other.login == login)&&(identical(other.id, id) || other.id == id)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gravatarId, gravatarId) || other.gravatarId == gravatarId)&&(identical(other.url, url) || other.url == url)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.followersUrl, followersUrl) || other.followersUrl == followersUrl)&&(identical(other.followingUrl, followingUrl) || other.followingUrl == followingUrl)&&(identical(other.gistsUrl, gistsUrl) || other.gistsUrl == gistsUrl)&&(identical(other.starredUrl, starredUrl) || other.starredUrl == starredUrl)&&(identical(other.subscriptionsUrl, subscriptionsUrl) || other.subscriptionsUrl == subscriptionsUrl)&&(identical(other.organizationsUrl, organizationsUrl) || other.organizationsUrl == organizationsUrl)&&(identical(other.reposUrl, reposUrl) || other.reposUrl == reposUrl)&&(identical(other.eventsUrl, eventsUrl) || other.eventsUrl == eventsUrl)&&(identical(other.receivedEventsUrl, receivedEventsUrl) || other.receivedEventsUrl == receivedEventsUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.siteAdmin, siteAdmin) || other.siteAdmin == siteAdmin)&&(identical(other.contributions, contributions) || other.contributions == contributions)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.userViewType, userViewType) || other.userViewType == userViewType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,login,id,nodeId,avatarUrl,gravatarId,url,htmlUrl,followersUrl,followingUrl,gistsUrl,starredUrl,subscriptionsUrl,organizationsUrl,reposUrl,eventsUrl,receivedEventsUrl,type,siteAdmin,contributions,email,name,userViewType]);

@override
String toString() {
  return 'Contributor(login: $login, id: $id, nodeId: $nodeId, avatarUrl: $avatarUrl, gravatarId: $gravatarId, url: $url, htmlUrl: $htmlUrl, followersUrl: $followersUrl, followingUrl: $followingUrl, gistsUrl: $gistsUrl, starredUrl: $starredUrl, subscriptionsUrl: $subscriptionsUrl, organizationsUrl: $organizationsUrl, reposUrl: $reposUrl, eventsUrl: $eventsUrl, receivedEventsUrl: $receivedEventsUrl, type: $type, siteAdmin: $siteAdmin, contributions: $contributions, email: $email, name: $name, userViewType: $userViewType)';
}


}

/// @nodoc
abstract mixin class _$ContributorCopyWith<$Res> implements $ContributorCopyWith<$Res> {
  factory _$ContributorCopyWith(_Contributor value, $Res Function(_Contributor) _then) = __$ContributorCopyWithImpl;
@override @useResult
$Res call({
 String? login, int? id, String? nodeId, Uri? avatarUrl, String? gravatarId, Uri? url, Uri? htmlUrl, Uri? followersUrl, String? followingUrl, String? gistsUrl, String? starredUrl, Uri? subscriptionsUrl, Uri? organizationsUrl, Uri? reposUrl, String? eventsUrl, Uri? receivedEventsUrl, String type, bool siteAdmin, int contributions, String? email, String? name, String? userViewType
});




}
/// @nodoc
class __$ContributorCopyWithImpl<$Res>
    implements _$ContributorCopyWith<$Res> {
  __$ContributorCopyWithImpl(this._self, this._then);

  final _Contributor _self;
  final $Res Function(_Contributor) _then;

/// Create a copy of Contributor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? login = freezed,Object? id = freezed,Object? nodeId = freezed,Object? avatarUrl = freezed,Object? gravatarId = freezed,Object? url = freezed,Object? htmlUrl = freezed,Object? followersUrl = freezed,Object? followingUrl = freezed,Object? gistsUrl = freezed,Object? starredUrl = freezed,Object? subscriptionsUrl = freezed,Object? organizationsUrl = freezed,Object? reposUrl = freezed,Object? eventsUrl = freezed,Object? receivedEventsUrl = freezed,Object? type = null,Object? siteAdmin = null,Object? contributions = null,Object? email = freezed,Object? name = freezed,Object? userViewType = freezed,}) {
  return _then(_Contributor(
login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,nodeId: freezed == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as Uri?,gravatarId: freezed == gravatarId ? _self.gravatarId : gravatarId // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,htmlUrl: freezed == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as Uri?,followersUrl: freezed == followersUrl ? _self.followersUrl : followersUrl // ignore: cast_nullable_to_non_nullable
as Uri?,followingUrl: freezed == followingUrl ? _self.followingUrl : followingUrl // ignore: cast_nullable_to_non_nullable
as String?,gistsUrl: freezed == gistsUrl ? _self.gistsUrl : gistsUrl // ignore: cast_nullable_to_non_nullable
as String?,starredUrl: freezed == starredUrl ? _self.starredUrl : starredUrl // ignore: cast_nullable_to_non_nullable
as String?,subscriptionsUrl: freezed == subscriptionsUrl ? _self.subscriptionsUrl : subscriptionsUrl // ignore: cast_nullable_to_non_nullable
as Uri?,organizationsUrl: freezed == organizationsUrl ? _self.organizationsUrl : organizationsUrl // ignore: cast_nullable_to_non_nullable
as Uri?,reposUrl: freezed == reposUrl ? _self.reposUrl : reposUrl // ignore: cast_nullable_to_non_nullable
as Uri?,eventsUrl: freezed == eventsUrl ? _self.eventsUrl : eventsUrl // ignore: cast_nullable_to_non_nullable
as String?,receivedEventsUrl: freezed == receivedEventsUrl ? _self.receivedEventsUrl : receivedEventsUrl // ignore: cast_nullable_to_non_nullable
as Uri?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,siteAdmin: null == siteAdmin ? _self.siteAdmin : siteAdmin // ignore: cast_nullable_to_non_nullable
as bool,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as int,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,userViewType: freezed == userViewType ? _self.userViewType : userViewType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
