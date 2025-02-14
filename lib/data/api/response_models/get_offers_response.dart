import 'package:json_annotation/json_annotation.dart';

import '../models/offer_model.dart';

part 'get_offers_response.g.dart';

@JsonSerializable()
class GetOffersResponse {
  List<OfferModel> offers;

  GetOffersResponse({
    required this.offers,
  });

  factory GetOffersResponse.fromJson(List<dynamic> json) {
    return GetOffersResponse(
      offers: json.map((e) => OfferModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
  Map<String, dynamic> toJson() => _$GetOffersResponseToJson(this);
}
