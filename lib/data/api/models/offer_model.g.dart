// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      source: json['source'] as String,
      status: json['offer_status'] as String,
      price: (json['price'] as num).toInt(),
      formattedPrice: json['formatted_price'] as String,
      priority: (json['priority'] as num).toInt(),
      companyName: json['company_name'] as String,
      createdAt: json['created_at'] as String,
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'source': instance.source,
      'offer_status': instance.status,
      'price': instance.price,
      'formatted_price': instance.formattedPrice,
      'priority': instance.priority,
      'company_name': instance.companyName,
      'created_at': instance.createdAt,
      'picture': instance.picture,
    };
