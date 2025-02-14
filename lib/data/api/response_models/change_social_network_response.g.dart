// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_social_network_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeSocialNetworkResponse _$ChangeSocialNetworkResponseFromJson(
        Map<String, dynamic> json) =>
    ChangeSocialNetworkResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChangeSocialNetworkResponseToJson(
        ChangeSocialNetworkResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
