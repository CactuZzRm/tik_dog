import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String? avatar;
  @JsonKey(name: 'number_of_media')
  final int numberOfMedia;
  @JsonKey(name: 'number_of_image_media')
  final int numberOfImageMedia;
  @JsonKey(name: 'number_of_video_media')
  final int numberOfVideoMedia;
  @JsonKey(name: 'number_of_followers')
  final int numberOfFollowers;
  @JsonKey(name: 'number_of_media_views')
  final int numberOfMediaViews;
  @JsonKey(name: 'number_of_likes')
  final int numberOfLikes;
  @JsonKey(name: 'number_of_comments')
  final int numberOfComments;
  @JsonKey(name: 'number_of_shares')
  final int numberOfShares;
  @JsonKey(name: 'user_group_id')
  final String? userGroupId;
  final int rank;
  final String provider;
  @JsonKey(name: 'total_sum')
  final int totalSum;
  @JsonKey(name: 'offer_price')
  final int offerPrice;

  UserModel({
    required this.numberOfLikes,
    required this.numberOfComments,
    required this.numberOfShares,
    required this.id,
    required this.name,
    required this.avatar,
    required this.numberOfMedia,
    required this.numberOfImageMedia,
    required this.numberOfVideoMedia,
    required this.numberOfFollowers,
    required this.numberOfMediaViews,
    required this.userGroupId,
    required this.rank,
    required this.provider,
    required this.totalSum,
    required this.offerPrice,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
