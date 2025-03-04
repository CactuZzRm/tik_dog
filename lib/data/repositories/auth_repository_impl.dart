import 'package:dio/dio.dart';
import 'package:tik_dog/data/api/api_service.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/data/api/response_models/exchange_temp_token_response.dart';
import 'package:tik_dog/data/api/response_models/get_redirect_url_response.dart';
import 'package:tik_dog/domain/repositories/auth_repository.dart';

import '../../injection_container.dart';
import '../api/models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<GetRedirectUrlResponse> getUrl(String provider, String? inviteKey) async {
    final apiService = getIt<ApiService>();
    final request = await apiService.getRedirectUrl(provider, inviteKey);

    return request;
  }

  @override
  Future<ExchangeTempTokenResponse> exhangeTempToken(ExchangeTempTokenModel body, CancelToken? cancelToken) async {
    final apiService = getIt<ApiService>();
    final request = await apiService.exchangeTempToken(body, cancelToken);

    return request;
  }

  @override
  Future<UserModel> getUserData({CancelToken? cancelToken}) async {
    final apiService = getIt<ApiService>();
    final request = await apiService.getUserData(cancelToken);

    return request;
  }
}
