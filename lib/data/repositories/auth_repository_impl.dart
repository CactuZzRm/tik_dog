import 'package:tik_dog/data/api/api_service.dart';
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
}
