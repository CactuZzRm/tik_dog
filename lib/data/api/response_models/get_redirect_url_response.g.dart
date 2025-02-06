// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_redirect_url_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRedirectUrlResponse _$GetRedirectUrlResponseFromJson(
        Map<String, dynamic> json) =>
    GetRedirectUrlResponse(
      url: json['url'] as String,
      tempToken: json['temp_token'] as String,
    );

Map<String, dynamic> _$GetRedirectUrlResponseToJson(
        GetRedirectUrlResponse instance) =>
    <String, dynamic>{
      'url': instance.url,
      'temp_token': instance.tempToken,
    };
