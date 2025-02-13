import '../../data/api/models/offer_model.dart';

abstract class OffersRepository {
  Future<List<OfferModel>> getOffers({int? limit, required String? status});

  Future<void> acceptOffer({
    required String id,
    required String email,
    required String country,
  });

  Future<void> deniedOffer({
    required String id,
    required String reason,
  });

  Future<List<String>> fetchDeniedOfferReasons();
}
