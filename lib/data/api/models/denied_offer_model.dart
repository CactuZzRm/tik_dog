import 'package:json_annotation/json_annotation.dart';

part 'denied_offer_model.g.dart';

@JsonSerializable()
class DeniedOfferModel {
  final String reason;

  DeniedOfferModel({required this.reason});

  factory DeniedOfferModel.fromJson(Map<String, dynamic> json) => _$DeniedOfferModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeniedOfferModelToJson(this);
}