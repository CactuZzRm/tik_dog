import 'package:json_annotation/json_annotation.dart';

part 'share_friend_link_response.g.dart';

@JsonSerializable()
class ShareFriendLinkResponse {
  @JsonKey(name: 'invite_url')
  final String inviteUrl;

  ShareFriendLinkResponse({required this.inviteUrl});

  factory ShareFriendLinkResponse.fromJson(Map<String, dynamic> json) => _$ShareFriendLinkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShareFriendLinkResponseToJson(this);
}
