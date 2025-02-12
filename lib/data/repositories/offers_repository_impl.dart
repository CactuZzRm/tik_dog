import 'package:tik_dog/data/api/models/accept_offer_model.dart';
import 'package:tik_dog/domain/repositories/offers_repository.dart';

import '../../injection_container.dart';
import '../api/api_service.dart';
import '../api/models/denied_offer_model.dart';
import '../api/models/offer_model.dart';

class OffersRepositoryImpl extends OffersRepository {
  @override
  Future<List<OfferModel>> getOffers() async {
    final apiService = getIt<ApiService>();
    final request = await apiService.getOffers();

    return request;
  }

  @override
  Future<void> acceptOffer({
    required String id,
    required String email,
    required String country,
  }) async {
    final apiService = getIt<ApiService>();
    final body = AcceptOfferModel(email: email, country: country);

    await apiService.acceptOffer(id, body);
  }

  @override
  Future<void> deniedOffer({
    required String id,
    required String reason,
  }) async {
    final apiService = getIt<ApiService>();
    final body = DeniedOfferModel(reason: reason);

    await apiService.deniedOffer(id, body);
  }

  @override
  Future<List<String>> fetchDeniedOfferReasons() async {
    final apiService = getIt<ApiService>();
    final response = await apiService.fetchDeniedOfferReasons();

    return response;
  }
}
