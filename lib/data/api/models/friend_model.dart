import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

@JsonSerializable()
class FriendModel {
  final String id;
  final String name;
  final String avatar;
  @JsonKey(name: 'number_of_media')
  final int numberOfMedia;
  @JsonKey(name: 'number_of_followers')
  final int numberOfFollowers;
  @JsonKey(name: 'number_of_media_views')
  final int numberOfMediaViews;
  final String provider;

  FriendModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.numberOfMedia,
    required this.numberOfFollowers,
    required this.numberOfMediaViews,
    required this.provider,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);
  Map<String, dynamic> toJson() => _$FriendModelToJson(this);
}
