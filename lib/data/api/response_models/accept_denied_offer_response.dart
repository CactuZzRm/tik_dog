import 'package:json_annotation/json_annotation.dart';

part 'accept_denied_offer_response.g.dart';

@JsonSerializable()
class AcceptDeniedOfferResponse {
  final String? message;

  AcceptDeniedOfferResponse({this.message});

  factory AcceptDeniedOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptDeniedOfferResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AcceptDeniedOfferResponseToJson(this);
}
