import 'package:tik_dog/data/api/api_service.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/data/api/response_models/change_social_network_response.dart';
import 'package:tik_dog/data/api/response_models/exchange_temp_token_response.dart';
import 'package:tik_dog/data/api/response_models/generate_key_response.dart';
import 'package:tik_dog/data/api/response_models/get_redirect_url_response.dart';
import 'package:tik_dog/domain/repositories/auth_repository.dart';

import '../../injection_container.dart';
import '../api/models/set_key_model.dart';
import '../api/models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<GetRedirectUrlResponse> getUrl(String provider) async {
    final apiService = getIt<ApiService>();
    final request = await apiService.getRedirectUrl(provider);

    return request;
  }

  @override
  Future<ExchangeTempTokenResponse> exhangeTempToken(ExchangeTempTokenModel body) async {
    final apiService = getIt<ApiService>();
    final request = await apiService.exchangeTempToken(body);

    return request;
  }

  @override
  Future<UserModel> changeSocialNetwork() async {
    final apiService = getIt<ApiService>();
    final request = await apiService.changeSocialNetwork();

    return request;
  }

  @override
  Future<GenerateKeyResponse> generateKey() async {
    final apiService = getIt<ApiService>();
    final request = await apiService.generateKey();

    return request;
  }

  @override
  Future<void> setKey(String key) async {
    final apiService = getIt<ApiService>();

    final body = SetKeyModel(key: key);
    final request = await apiService.setKey(body);

    return request;
  }
}
