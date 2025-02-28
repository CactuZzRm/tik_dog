// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_offers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOffersResponse _$GetOffersResponseFromJson(Map<String, dynamic> json) =>
    GetOffersResponse(
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetOffersResponseToJson(GetOffersResponse instance) =>
    <String, dynamic>{
      'offers': instance.offers,
    };
