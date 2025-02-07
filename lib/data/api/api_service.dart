import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';

import 'response_models/exchange_temp_token_response.dart';
import 'response_models/get_redirect_url_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://app.bigpie.ai')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/api/login')
  Future<GetRedirectUrlResponse> getRedirectUrl(
      @Query('provider') String provider);

  @POST('/api/exchange-temp-token')
  Future<ExchangeTempTokenResponse> exchangeTempToken(@Body() ExchangeTempTokenModel body);
}
