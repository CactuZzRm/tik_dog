import 'package:json_annotation/json_annotation.dart';

part 'generate_key_response.g.dart';

@JsonSerializable()
class GenerateKeyResponse {
  final String key;

  GenerateKeyResponse({required this.key});

  factory GenerateKeyResponse.fromJson(Map<String, dynamic> json) => _$GenerateKeyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenerateKeyResponseToJson(this);
}
