import 'package:json_annotation/json_annotation.dart';

part 'set_key_model.g.dart';

@JsonSerializable()
class SetKeyModel {
  final String key;

  SetKeyModel({required this.key});

  factory SetKeyModel.fromJson(Map<String, dynamic> json) => _$SetKeyModelFromJson(json);
  Map<String, dynamic> toJson() => _$SetKeyModelToJson(this);
}
