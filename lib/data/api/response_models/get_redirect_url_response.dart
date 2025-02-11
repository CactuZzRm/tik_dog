import 'package:json_annotation/json_annotation.dart';

part 'get_redirect_url_response.g.dart';

@JsonSerializable()
class GetRedirectUrlResponse {
  final String url;
  @JsonKey(name: 'temp_token')
  final String tempToken;

  GetRedirectUrlResponse({
    required this.url,
    required this.tempToken,
  });

  factory GetRedirectUrlResponse.fromJson(Map<String, dynamic> json) => _$GetRedirectUrlResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetRedirectUrlResponseToJson(this);
}
