// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRatingModel _$UserRatingModelFromJson(Map<String, dynamic> json) =>
    UserRatingModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      rank: (json['rank'] as num).toInt(),
      top: (json['top'] as num).toInt(),
      provider: json['provider'] as String,
    );

Map<String, dynamic> _$UserRatingModelToJson(UserRatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'rank': instance.rank,
      'top': instance.top,
      'provider': instance.provider,
    };
