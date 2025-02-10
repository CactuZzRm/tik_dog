import 'package:json_annotation/json_annotation.dart';

part 'accept_offer_model.g.dart';

@JsonSerializable()
class AcceptOfferModel {
  final String email;
  final String country;

  AcceptOfferModel({
    required this.email,
    required this.country,
  });

  factory AcceptOfferModel.fromJson(Map<String, dynamic> json) =>
      _$AcceptOfferModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcceptOfferModelToJson(this);
}
