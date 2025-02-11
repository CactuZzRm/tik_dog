import 'package:json_annotation/json_annotation.dart';

part 'exchange_temp_token_model.g.dart';

@JsonSerializable()
class ExchangeTempTokenModel {
  @JsonKey(name: 'temp_token')
  final String tempToken;

  ExchangeTempTokenModel({required this.tempToken});

  factory ExchangeTempTokenModel.fromJson(Map<String, dynamic> json) => _$ExchangeTempTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeTempTokenModelToJson(this);
}
