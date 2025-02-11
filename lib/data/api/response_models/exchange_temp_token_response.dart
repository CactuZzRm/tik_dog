import 'package:json_annotation/json_annotation.dart';

import '../models/user_model.dart';

part 'exchange_temp_token_response.g.dart';

@JsonSerializable()
class ExchangeTempTokenResponse {
  final String token;
  final UserModel user;

  ExchangeTempTokenResponse({
    required this.token,
    required this.user,
  });

  factory ExchangeTempTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ExchangeTempTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeTempTokenResponseToJson(this);
}
