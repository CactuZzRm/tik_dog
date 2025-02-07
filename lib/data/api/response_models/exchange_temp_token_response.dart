import 'package:json_annotation/json_annotation.dart';

part 'exchange_temp_token_response.g.dart';

@JsonSerializable()
class ExchangeTempTokenResponse {
  final String token;

  ExchangeTempTokenResponse({required this.token});

  factory ExchangeTempTokenResponse.fromJson(Map<String, dynamic> json) => _$ExchangeTempTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeTempTokenResponseToJson(this);
}