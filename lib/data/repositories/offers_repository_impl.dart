import 'package:tik_dog/data/api/models/accept_offer_model.dart';
import 'package:tik_dog/data/api/response_models/accept_denied_offer_response.dart';
import 'package:tik_dog/data/api/response_models/get_offers_response.dart';
import 'package:tik_dog/domain/repositories/offers_repository.dart';

import '../api/api_service.dart';
import '../api/models/denied_offer_model.dart';
import '../api/models/offer_model.dart';

class OffersRepositoryImpl extends OffersRepository {
  final ApiService apiService;

  OffersRepositoryImpl({required this.apiService});

  @override
  Future<List<OfferModel>> getOffers() async {
    final request = await apiService.getOffers();

    return request;
  }

  @override
  Future<AcceptDeniedOfferResponse> acceptOffer({
    required String id,
    required String email,
    required String country,
  }) async {
    final body = AcceptOfferModel(email: email, country: country);

    final request = await apiService.acceptOffer(id, body);

    return request;
  }

  @override
  Future<AcceptDeniedOfferResponse> deniedOffer({
    required String id,
    required String reason,
  }) async {
    final body = DeniedOfferModel(reason: reason);

    final request = await apiService.deniedOffer(id, body);

    return request;
  }
}
