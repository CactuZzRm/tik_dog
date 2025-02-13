import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String? avatar;
  @JsonKey(name: 'number_of_media')
  final int numberOfMedia;
  @JsonKey(name: 'number_of_followers')
  final int numberOfFollowers;
  @JsonKey(name: 'number_of_media_views')
  final int numberOfMediaViews;
  final String provider;

  UserModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.numberOfMedia,
    required this.numberOfFollowers,
    required this.numberOfMediaViews,
    required this.provider,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
