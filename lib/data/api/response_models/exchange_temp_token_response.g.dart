// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_temp_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeTempTokenResponse _$ExchangeTempTokenResponseFromJson(
        Map<String, dynamic> json) =>
    ExchangeTempTokenResponse(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExchangeTempTokenResponseToJson(
        ExchangeTempTokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
