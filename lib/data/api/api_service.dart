import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/data/api/response_models/generate_key_response.dart';
import 'package:tik_dog/data/api/response_models/share_friend_link_response.dart';

import 'models/accept_offer_model.dart';
import 'models/denied_offer_model.dart';
import 'models/friend_model.dart';
import 'models/offer_model.dart';
import 'models/set_key_model.dart';
import 'models/user_model.dart';
import 'response_models/exchange_temp_token_response.dart';
import 'response_models/get_redirect_url_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://app.bigpie.ai')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/api/login')
  Future<GetRedirectUrlResponse> getRedirectUrl(
      @Query('provider') String provider, @Query('referral_key') String? inviteKey);

  @POST('/api/exchange-temp-token')
  Future<ExchangeTempTokenResponse> exchangeTempToken(@Body() ExchangeTempTokenModel body);

  @GET('/api/user/me')
  Future<UserModel> changeSocialNetwork();

  @GET('/api/offers')
  Future<List<OfferModel>> getOffers(@Query('limit') int? limit, @Query('status') String? status);

  @POST('/api/offer/{id}/accept')
  Future<void> acceptOffer(@Path('id') String id, @Body() AcceptOfferModel body);

  @POST('/api/offer/{id}/decline')
  Future<void> deniedOffer(@Path('id') String id, @Body() DeniedOfferModel body);

  @GET('/api/static?key=decline_offer_reasons')
  Future<List<String>> fetchDeniedOfferReasons();

  @GET('/api/user/referrals')
  Future<List<FriendModel>> fetchFriends();

  @GET('/api/user/invite')
  Future<ShareFriendLinkResponse> getShareFriendLink();

  @GET('/api/user/group')
  Future<GenerateKeyResponse> generateKey();

  @POST('/api/user/group')
  Future<void> setKey(@Body() SetKeyModel body);
}
