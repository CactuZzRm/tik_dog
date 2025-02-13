// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      numberOfMedia: (json['number_of_media'] as num).toInt(),
      numberOfFollowers: (json['number_of_followers'] as num).toInt(),
      numberOfMediaViews: (json['number_of_media_views'] as num).toInt(),
      provider: json['provider'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'number_of_media': instance.numberOfMedia,
      'number_of_followers': instance.numberOfFollowers,
      'number_of_media_views': instance.numberOfMediaViews,
      'provider': instance.provider,
    };
