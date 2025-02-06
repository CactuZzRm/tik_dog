

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'response_models/get_redirect_url_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://bigpie.ai')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  
  @GET('/api/login?provider={provider}')
  Future<GetRedirectUrlResponse> getRedirectUrl(@Query('provider') String provider);
}