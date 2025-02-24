import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  final String id;
  final String title;
  final String description;
  final String source;
  @JsonKey(name: 'offer_status')
  final String status;
  final int price;
  @JsonKey(name: 'formatted_price')
  final String formattedPrice;
  final int priority;
  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String picture;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.source,
    required this.status,
    required this.price,
    required this.formattedPrice,
    required this.priority,
    required this.companyName,
    required this.createdAt,
    required this.picture,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => _$OfferModelFromJson(json);
  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
