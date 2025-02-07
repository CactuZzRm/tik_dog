import 'package:tik_dog/data/api/api_service.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/data/api/response_models/exchange_temp_token_response.dart';
import 'package:tik_dog/data/api/response_models/get_redirect_url_response.dart';
import 'package:tik_dog/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl({required this.apiService});

  @override
  Future<GetRedirectUrlResponse> getUrl(String provider) async {
    final request = await apiService.getRedirectUrl(provider);

    return request;
  }

  @override
  Future<ExchangeTempTokenResponse> exhangeTempToken(
      ExchangeTempTokenModel body) async {
    final request = await apiService.exchangeTempToken(body);

    return request;
  }
}
