import 'package:tik_dog/data/api/response_models/accept_denied_offer_response.dart';
import 'package:tik_dog/data/api/response_models/get_offers_response.dart';

import '../../data/api/models/offer_model.dart';

abstract class OffersRepository {
  Future<List<OfferModel>> getOffers();
  Future<AcceptDeniedOfferResponse> acceptOffer({
    required String id,
    required String email,
    required String country,
  });

  
  Future<AcceptDeniedOfferResponse> deniedOffer({
    required String id,
    required String reason,
  });
}
