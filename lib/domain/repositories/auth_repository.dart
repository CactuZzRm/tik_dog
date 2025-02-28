import 'package:dio/dio.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/data/api/response_models/exchange_temp_token_response.dart';
import 'package:tik_dog/data/api/response_models/generate_key_response.dart';

import '../../data/api/models/user_model.dart';
import '../../data/api/response_models/get_redirect_url_response.dart';

abstract class AuthRepository {
  Future<GetRedirectUrlResponse> getUrl(String provider, String? inviteKey);
  Future<ExchangeTempTokenResponse> exhangeTempToken(ExchangeTempTokenModel body, CancelToken? cancelToken);
  Future<UserModel> getUserData(); //TODO: Перенести на wallet_repository
  Future<GenerateKeyResponse> generateKey();
  Future<void> setKey(String key);
}
