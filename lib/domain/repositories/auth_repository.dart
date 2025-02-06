import '../../data/api/response_models/get_redirect_url_response.dart';

abstract class AuthRepository {
  Future<GetRedirectUrlResponse> getUrl(String provider);
}
