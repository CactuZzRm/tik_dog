// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      numberOfLikes: (json['number_of_likes'] as num).toInt(),
      numberOfComments: (json['number_of_comments'] as num).toInt(),
      numberOfShares: (json['number_of_shares'] as num).toInt(),
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      numberOfMedia: (json['number_of_media'] as num).toInt(),
      numberOfImageMedia: (json['number_of_image_media'] as num).toInt(),
      numberOfVideoMedia: (json['number_of_video_media'] as num).toInt(),
      numberOfFollowers: (json['number_of_followers'] as num).toInt(),
      numberOfMediaViews: (json['number_of_media_views'] as num).toInt(),
      userGroupId: json['user_group_id'] as String?,
      rank: (json['rank'] as num).toInt(),
      provider: json['provider'] as String,
      totalSum: (json['total_sum'] as num).toInt(),
      offerPrice: (json['offer_price'] as num).toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'number_of_media': instance.numberOfMedia,
      'number_of_image_media': instance.numberOfImageMedia,
      'number_of_video_media': instance.numberOfVideoMedia,
      'number_of_followers': instance.numberOfFollowers,
      'number_of_media_views': instance.numberOfMediaViews,
      'number_of_likes': instance.numberOfLikes,
      'number_of_comments': instance.numberOfComments,
      'number_of_shares': instance.numberOfShares,
      'user_group_id': instance.userGroupId,
      'rank': instance.rank,
      'provider': instance.provider,
      'total_sum': instance.totalSum,
      'offer_price': instance.offerPrice,
    };
